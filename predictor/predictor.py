"""
温泉来客数予測モジュール
CSVデータを入力として、Prophetモデルで予測を行う
"""

import pandas as pd
from prophet import Prophet
import warnings
warnings.filterwarnings('ignore')


class OnsenPredictor:
    """温泉来客数予測クラス"""
    
    def __init__(self):
        self.model = None
        self.is_trained = False
    
    def load_data(self, csv_path):
        """
        CSVファイルからデータを読み込む
        
        Args:
            csv_path (str): CSVファイルのパス
            
        Returns:
            pd.DataFrame: 読み込んだデータフレーム
        """
        try:
            df = pd.read_csv(csv_path, parse_dates=['ds'])
            return df
        except FileNotFoundError:
            raise FileNotFoundError(f"ファイルが見つかりません: {csv_path}")
        except Exception as e:
            raise Exception(f"データ読み込みエラー: {e}")
    
    def train_model(self, df):
        """
        Prophetモデルを学習する
        
        Args:
            df (pd.DataFrame): 学習データ（'ds', 'y'カラムが必要）
        """
        if not {'ds', 'y'}.issubset(df.columns):
            raise ValueError("データフレームには'ds'と'y'カラムが必要です")
        
        self.model = Prophet(daily_seasonality=True, weekly_seasonality=True)
        self.model.fit(df)
        self.is_trained = True
    
    def predict_next_day(self, df):
        """
        次の1日分（14-23時）を予測する
        
        Args:
            df (pd.DataFrame): 学習済みデータ
            
        Returns:
            pd.DataFrame: 予測結果（'ds', 'yhat'カラムを含む）
        """
        if not self.is_trained:
            raise Exception("モデルが学習されていません。先にtrain_model()を実行してください")
        
        # 次の1日分（14-23時）の日時を生成
        last_date = df['ds'].max()
        future_dates = pd.date_range(
            start=last_date + pd.Timedelta(days=1, hours=14),
            periods=10, 
            freq='h'
        )
        
        # DataFrame形式に変換
        future = pd.DataFrame({'ds': future_dates})
        
        # 予測実行
        forecast = self.model.predict(future)
        
        return forecast[['ds', 'yhat', 'yhat_lower', 'yhat_upper']]
    
    def get_same_weekday_data(self, df, target_date):
        """
        指定日と同じ曜日の前回データを取得
        
        Args:
            df (pd.DataFrame): データフレーム
            target_date (pd.Timestamp): 対象日時
            
        Returns:
            pd.DataFrame: 同じ曜日の前回データ（10時間分）
        """
        target_weekday = target_date.dayofweek
        same_weekday_data = df[df['ds'].dt.dayofweek == target_weekday].tail(10)
        return same_weekday_data[['ds', 'y']]


def predict_onsen_visitors(csv_path):
    """
    CSVファイルから温泉来客数を予測する関数
    
    Args:
        csv_path (str): CSVファイルのパス
        
    Returns:
        pd.DataFrame: 予測結果（yhatカラムを含む）
    """
    predictor = OnsenPredictor()
    
    # データ読み込み
    df = predictor.load_data(csv_path)
    
    # モデル学習
    predictor.train_model(df)
    
    # 予測実行
    forecast = predictor.predict_next_day(df)
    
    return forecast


if __name__ == "__main__":
    # 使用例
    try:
        result = predict_onsen_visitors('onsen_visitors.csv')
        print("予測結果:")
        print(result[['ds', 'yhat']])
    except Exception as e:
        print(f"エラー: {e}")