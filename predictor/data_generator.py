import pandas as pd
import numpy as np
from datetime import datetime, timedelta
try:
    from zoneinfo import ZoneInfo
except ImportError:
    from backports.zoneinfo import ZoneInfo
import pytz
import sys

def generate_visitor_data(weeks=4, start_date=None, end_date=None):
    """
    温泉来客数の5分毎ダミーデータを生成
    
    Args:
        weeks: 生成する週数（start_date, end_dateが未指定の場合）
        start_date: 開始日時（YYYY-MM-DD形式の文字列）
        end_date: 終了日時（YYYY-MM-DD形式の文字列）
    
    Returns:
        pd.DataFrame: Supabase用のデータフレーム
    """
    print("Supabase用 5分毎ダミーデータの生成を開始します...")
    
    # 日本時間での期間設定
    jst = ZoneInfo("Asia/Tokyo")
    
    if start_date and end_date:
        # 指定された期間を使用
        start_time = datetime.strptime(start_date, '%Y-%m-%d').replace(tzinfo=jst)
        end_time = datetime.strptime(end_date, '%Y-%m-%d').replace(hour=23, minute=59, tzinfo=jst)
        print(f"指定期間: {start_date} - {end_date}")
    else:
        # 現在時刻から過去に遡る
        end_time = datetime.now(jst).replace(minute=0, second=0, microsecond=0)
        start_time = end_time - timedelta(weeks=weeks)
        print(f"過去{weeks}週間分のデータを生成")
    
    # 5分間隔のタイムスタンプを生成（14:00-23:55）
    dates = []
    current = start_time
    
    while current <= end_time:
        # 14時から23時55分まで
        if 14 <= current.hour <= 23:
            dates.append(current)
        current += timedelta(minutes=5)
    
    print(f"生成期間: {start_time.strftime('%Y-%m-%d %H:%M')} - {end_time.strftime('%Y-%m-%d %H:%M')}")
    print(f"生成データポイント数: {len(dates)}件")
    
    # ベースとなる来客数
    base_visitors = 10
    
    # 来客数データの生成
    visitors_data = []
    
    for timestamp in dates:
        # 時間帯による変動
        hour = timestamp.hour
        if 17 <= hour <= 20:  # 夕方のピーク時間
            hourly_effect = 15 + np.random.uniform(-3, 3)
        elif 14 <= hour <= 16:  # 午後の時間
            hourly_effect = 8 + np.random.uniform(-2, 2)
        else:  # 夜の時間（21-23時）
            hourly_effect = 5 + np.random.uniform(-2, 2)
        
        # 曜日による変動
        weekday = timestamp.weekday()
        if weekday >= 5:  # 土日
            weekly_effect = 8 + np.random.uniform(-2, 3)
        else:  # 平日
            weekly_effect = np.random.uniform(-3, 2)
        
        # 季節による変動（月ベース）
        month = timestamp.month
        if month in [12, 1, 2]:  # 冬（温泉シーズン）
            seasonal_effect = 5 + np.random.uniform(-1, 2)
        elif month in [6, 7, 8]:  # 夏
            seasonal_effect = np.random.uniform(-3, 1)
        else:  # 春・秋
            seasonal_effect = np.random.uniform(-1, 1)
        
        # 5分間隔でのランダムな変動（小さめ）
        random_noise = np.random.uniform(-2, 2)
        
        # 最終的な来客数計算
        total_visitors = base_visitors + hourly_effect + weekly_effect + seasonal_effect + random_noise
        
        # マイナスにならないよう調整
        total_visitors = max(0, int(round(total_visitors)))
        
        visitors_data.append(total_visitors)
    
    # JSTをUTCに変換してSupabase用のDataFrameを作成
    dates_utc = [dt.astimezone(pytz.UTC) for dt in dates]
    
    # Supabaseのvisitors_5mテーブル形式のデータフレームを作成
    df = pd.DataFrame({
        'slot_5m': dates_utc,
        'visitors': visitors_data
    })
    
    # UTC時刻をISO形式の文字列に変換
    df['slot_5m'] = df['slot_5m'].apply(lambda x: x.isoformat())
    
    return df

def main():
    """メイン実行関数"""
    print("=" * 60)
    print("温泉来客数ダミーデータ生成スクリプト")
    print("=" * 60)
    
    # コマンドライン引数の処理
    if len(sys.argv) >= 2:
        if sys.argv[1] == "-h" or sys.argv[1] == "--help":
            print("\n使用方法:")
            print("  python data_generator.py                    # 過去4週間分を生成")
            print("  python data_generator.py 8                  # 過去8週間分を生成")
            print("  python data_generator.py 2024-01-01 2024-01-31  # 指定期間を生成")
            print("\n例:")
            print("  python data_generator.py 6                  # 過去6週間")
            print("  python data_generator.py 2024-12-01 2024-12-31  # 12月分")
            return
        
        if len(sys.argv) == 2:
            # 週数指定
            try:
                weeks = int(sys.argv[1])
                df = generate_visitor_data(weeks=weeks)
            except ValueError:
                print("エラー: 週数は整数で指定してください")
                return
        elif len(sys.argv) == 3:
            # 期間指定
            try:
                start_date = sys.argv[1]
                end_date = sys.argv[2]
                df = generate_visitor_data(start_date=start_date, end_date=end_date)
            except ValueError:
                print("エラー: 日付はYYYY-MM-DD形式で指定してください")
                return
        else:
            print("エラー: 引数が多すぎます。-h で使用方法を確認してください")
            return
    else:
        # デフォルト（4週間）
        df = generate_visitor_data(weeks=4)
    
    # CSVファイルとして保存
    file_name = 'visitors_5m_supabase.csv'
    df.to_csv(file_name, index=False)
    
    print(f"\nデータを生成し、'{file_name}' として保存しました。")
    print(f"総データ数: {len(df)}件")
    print(f"来客数統計: 平均={df['visitors'].mean():.1f}, 最小={df['visitors'].min()}, 最大={df['visitors'].max()}")
    
    print("\nデータの一部 (JST表示):")
    # 表示用にJSTに戻す
    df_display = df.copy()
    df_display['slot_5m_jst'] = pd.to_datetime(df['slot_5m']).dt.tz_convert('Asia/Tokyo')
    print(df_display[['slot_5m_jst', 'visitors']].head(10))
    
    print(f"\n✅ Supabaseのvisitors_5mテーブルにこのCSVをインポートできます")
    print(f"✅ ファイル名: {file_name}")
    print("\n📋 Supabaseでのインポート手順:")
    print("   1. Supabaseダッシュボードでvisitors_5mテーブルを開く")
    print("   2. 「Import data via spreadsheet」をクリック")
    print(f"   3. {file_name}をアップロード")

if __name__ == "__main__":
    main()