"""
onsen_predictor モジュールの使用例
"""

from predictor import OnsenPredictor, predict_onsen_visitors

def main():
    print("=== 方法1: 関数を直接使用 ===")
    try:
        # 簡単な使用方法
        result = predict_onsen_visitors('onsen_visitors.csv')
        print("予測結果（yhatのみ）:")
        for _, row in result.iterrows():
            print(f"{row['ds'].strftime('%H:%M')}: {row['yhat']:.1f}人")
    except Exception as e:
        print(f"エラー: {e}")
    
    print("\n=== 方法2: クラスを使用（詳細制御） ===")
    try:
        # より詳細な制御が可能
        predictor = OnsenPredictor()
        
        # データ読み込み
        df = predictor.load_data('onsen_visitors.csv')
        
        # モデル学習
        predictor.train_model(df)
        
        # 予測実行
        forecast = predictor.predict_next_day(df)
        
        # 前回同じ曜日のデータと比較
        predicted_date = forecast['ds'].iloc[0]
        same_weekday_data = predictor.get_same_weekday_data(df, predicted_date)
        
        print(f"前回の{predicted_date.strftime('%A')}のデータ:")
        for _, row in same_weekday_data.iterrows():
            print(f"{row['ds'].strftime('%H:%M')}: {row['y']}人")
        
        print(f"\n次の{predicted_date.strftime('%A')}の予測:")
        for _, row in forecast.iterrows():
            print(f"{row['ds'].strftime('%H:%M')}: {row['yhat']:.1f}人 (範囲: {row['yhat_lower']:.1f}-{row['yhat_upper']:.1f})")
            
    except Exception as e:
        print(f"エラー: {e}")

if __name__ == "__main__":
    main()