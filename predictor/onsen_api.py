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

app = FastAPI(title="温泉来客数予測API", version="1.0.0")

# Supabase設定
SUPABASE_URL = os.getenv("SUPABASE_URL", "your-supabase-url")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "your-supabase-key")
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def fetch_visitor_data_from_supabase(days: int = 28) -> pd.DataFrame:
    """
    Supabaseから来客数データを取得
    
    Args:
        days: 過去何日分のデータを取得するか
        
    Returns:
        pd.DataFrame: 来客数データ（ds, yカラム）
    """
    try:
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)
        
        # Supabaseからデータを取得（テーブル名とカラム名は実際に合わせて調整）
        response = supabase.table("visitor_data").select(
            "datetime, visitor_count"
        ).gte(
            "datetime", start_date.isoformat()
        ).lte(
            "datetime", end_date.isoformat()
        ).order("datetime").execute()
        
        if not response.data:
            raise ValueError("データが見つかりません")
        
        # DataFrameに変換
        df = pd.DataFrame(response.data)
        df = df.rename(columns={"datetime": "ds", "visitor_count": "y"})
        df['ds'] = pd.to_datetime(df['ds'])
        
        # 14-23時のデータのみフィルタリング
        df = df[df['ds'].dt.hour.between(14, 23)]
        
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
        
        # Supabaseからデータを取得
        df = fetch_visitor_data_from_supabase(days=28)
        
        if len(df) < 50:
            raise HTTPException(
                status_code=400, 
                detail="予測に必要な十分なデータがありません"
            )
        
        # 予測実行
        predictor = OnsenPredictor()
        predictor.train_model(df)
        forecast = predictor.predict_next_day(df)
        
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