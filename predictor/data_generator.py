import pandas as pd
import numpy as np

# --- ダミーデータの生成 ---
print("ダミーデータの生成を開始します...")

base_date = pd.date_range(start='2023-10-01', periods=28, freq='D')  # 4週間分の日付
dates = []
for date in base_date:
    daily_hours = pd.date_range(start=date.strftime('%Y-%m-%d') + ' 14:00:00', 
                               periods=10, freq='H')
    dates.extend(daily_hours)
dates = pd.DatetimeIndex(dates)
periods = len(dates)  # 280 (10時間 × 28日)

# ベースとなる来客数
base_visitors = 5
# 時間帯による変動（14時～24時、夕方にピークを迎える）
hourly_effect = np.sin(np.linspace(0, np.pi, 10)) * 10 + \
                np.sin(np.linspace(0, 4 * np.pi, 10)) * 3
hourly_pattern = np.tile(hourly_effect, periods // 10)

# 曜日による変動（週末に増える）
weekly_effect = []
for day in dates.dayofweek:
    if day >= 5:  # 土日(5:土, 6:日)
        weekly_effect.append(10 + np.random.uniform(-5, 5))
    else: # 平日
        weekly_effect.append(np.random.uniform(-5, 5))

# ランダムなノイズ
random_noise = np.random.randint(-5, 5, size=periods)

# 来客数を計算し、マイナスにならないように調整
visitors = base_visitors + hourly_pattern + weekly_effect + random_noise
visitors[visitors < 0] = 0
visitors = visitors.astype(int)

# Prophetで利用するデータフレームを作成
df = pd.DataFrame({'ds': dates, 'y': visitors})

# --- CSVファイルとして保存 ---
file_name = 'onsen_visitors.csv'
df.to_csv(file_name, index=False)

print(f"データを生成し、'{file_name}' として保存しました。")
print("データの一部:")
print(df.head())