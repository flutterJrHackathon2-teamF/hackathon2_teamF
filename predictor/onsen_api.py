"""
温泉来客数予測API（Flutter用シンプル版）
14-24時の予測来場者数のみを返すAPI
"""

from fastapi import FastAPI, HTTPException
import pandas as pd
from supabase import create_client, Client
import os
from datetime import datetime, timedelta
from predictor import OnsenPredictor
import logging
import pytz
from zoneinfo import ZoneInfo

app = FastAPI(title="温泉来客数予測API", version="1.0.0")

# Supabase設定
SUPABASE_URL = os.getenv("SUPABASE_URL", "your-supabase-url")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "your-supabase-key")
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def fetch_visitor_data_from_supabase(days: int = 28) -> pd.DataFrame:
    """
    Supabaseから来客数データを取得（タイムゾーン対応）
    
    Args:
        days: 過去何日分のデータを取得するか
        
    Returns:
        pd.DataFrame: 来客数データ（slot_5m, visitorsカラム）
    """
    try:
        # 日本時間で現在時刻を取得
        jst = ZoneInfo("Asia/Tokyo")
        now_jst = datetime.now(jst)
        
        # 過去28日分の範囲をJSTで計算
        start_jst = now_jst - timedelta(days=days)
        
        # JSTをUTCに変換してSupabaseに送信
        start_utc = start_jst.astimezone(pytz.UTC)
        end_utc = now_jst.astimezone(pytz.UTC)
        
        logger.info(f"JST範囲: {start_jst.strftime('%Y-%m-%d %H:%M')} - {now_jst.strftime('%Y-%m-%d %H:%M')}")
        logger.info(f"UTC範囲: {start_utc.strftime('%Y-%m-%d %H:%M')} - {end_utc.strftime('%Y-%m-%d %H:%M')}")
        
        # Supabaseからvisitors_5mテーブルのデータを取得
        response = supabase.table("visitors_5m").select(
            "slot_5m, visitors"
        ).gte(
            "slot_5m", start_utc.isoformat()
        ).lte(
            "slot_5m", end_utc.isoformat()
        ).order("slot_5m").execute()
        
        if not response.data:
            raise ValueError("データが見つかりません")
        
        # DataFrameに変換
        df = pd.DataFrame(response.data)
        df['slot_5m'] = pd.to_datetime(df['slot_5m'], utc=True)  # UTC として読み込み
        
        # UTC から JST に変換
        df['slot_5m'] = df['slot_5m'].dt.tz_convert('Asia/Tokyo')
        
        # 14-23時のデータのみフィルタリング（JST基準）
        df = df[df['slot_5m'].dt.hour.between(14, 23)]
        
        logger.info(f"取得データ数: {len(df)}件")
        if len(df) > 0:
            logger.info(f"データ期間: {df['slot_5m'].min()} - {df['slot_5m'].max()}")
        
        return df
        
    except Exception as e:
        logger.error(f"Supabaseデータ取得エラー: {e}")
        raise HTTPException(status_code=500, detail=f"データ取得エラー: {str(e)}")


@app.get("/predict")
async def predict_visitors():
    """
    次の1日分（14-23時）の来客数予測をFlutter用に返す
    
    Returns:
        list: 時間別予測来場者数のリスト
    """
    try:
        logger.info("来客数予測開始")
        
        # Supabaseから5分毎のデータを取得
        df = fetch_visitor_data_from_supabase(days=28)
        
        if len(df) < 50:
            raise HTTPException(
                status_code=400, 
                detail="予測に必要な十分なデータがありません"
            )
        
        # 予測実行（5分データを1時間に集約して予測）
        predictor = OnsenPredictor()
        
        # 5分データを1時間に集約
        df_hourly = predictor.aggregate_to_hourly(df)
        
        # モデル学習と予測
        predictor.train_model(df_hourly)
        forecast = predictor.predict_next_day(df_hourly)
        
        # Flutter用にシンプルな形式で返す
        predictions = []
        for _, row in forecast.iterrows():
            predictions.append({
                "hour": int(row['ds'].hour),
                "time": row['ds'].strftime('%H:%M'),
                "visitors": round(row['yhat'], 1)
            })
        
        logger.info(f"予測完了: {len(predictions)}件")
        return predictions
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"予測エラー: {e}")
        raise HTTPException(status_code=500, detail=f"予測エラー: {str(e)}")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)