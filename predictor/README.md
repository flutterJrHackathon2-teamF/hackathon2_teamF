# 温泉来客数予測システム

## 概要
温泉の来客数を時系列予測するシステムです。FacebookのProphetモデルを使用し、Supabaseから取得した5分毎の過去データを1時間単位に集約して、次日14-23時の来客数を予測します。

## ファイル構成

```
predictor/
├── predictor.py          # 予測モジュール（コア機能、5分データ集約機能付き）
├── onsen_api.py          # FastAPI サーバー（Supabase連携）
├── demo.py               # 使用例デモンストレーション  
├── data_generator.py     # テスト用データ生成（1時間毎）
├── onsen_visitors.csv    # サンプルデータ（1時間毎）
└── README.md            # このファイル（プロジェクト概要）
```

## クイックスタート

### 1. 依存関係のインストール
```bash
pip install fastapi uvicorn pandas prophet supabase
```

### 2. テスト用データ生成
```bash
python data_generator.py
```

### 3. デモ実行
```bash
python demo.py
```

### 4. API サーバー起動
```bash
uvicorn onsen_api:app --reload
```

## API仕様

### エンドポイント
```
GET /predict
```

### レスポンス例
```json
[
  {"hour": 14, "time": "14:00", "visitors": 12.5},
  {"hour": 15, "time": "15:00", "visitors": 18.3},
  {"hour": 16, "time": "16:00", "visitors": 22.1},
  // ... 23:00まで10件
]
```

### レスポンス仕様
- **配列要素数**: 固定10件（14:00-23:00）
- **hour**: 時間（14-23）- グラフのX軸に使用
- **time**: 表示用時刻文字列
- **visitors**: 予測来客数（小数点1桁） - グラフのY軸に使用

## 主要機能

### データ集約機能
`predictor.py`の`aggregate_to_hourly`メソッドが5分毎のデータを1時間毎に自動集約:
- 12個の5分スロットの平均値を計算
- 欠損値は自動的に除外
- `slot_5m`と`visitors`カラムを`ds`と`y`に変換

### 予測関数
```python
predict_onsen_visitors(
    csv_path=None,           # CSVファイルパス（オプション）
    dataframe=None,          # DataFrameを直接渡す（オプション）
    aggregate_5min=True      # 5分データを1時間に集約（デフォルト: True）
)
```

## システム構成

### アーキテクチャ
```
Supabase DB (5分毎) → FastAPI → データ集約(1時間毎) → 予測モジュール → JSON レスポンス
```

**データフロー:**
1. Supabaseから5分毎の来客数データ（`visitors_5m`テーブル）を取得
2. 5分毎のデータを1時間単位に平均化して集約
3. 集約されたデータでProphetモデルを学習
4. 次日14-23時の1時間毎の来客数を予測

### 環境変数
```bash
SUPABASE_URL=your-supabase-project-url
SUPABASE_KEY=your-supabase-anon-key
```

### データベーススキーマ
```sql
CREATE TABLE visitors_5m (
    slot_5m TIMESTAMP WITH TIME ZONE PRIMARY KEY,
    visitors SMALLINT NOT NULL
);
```

**テーブル説明:**
- `visitors_5m`: 5分毎の来客数データを格納
- `slot_5m`: 5分間隔のタイムスロット（タイムゾーン付きタイムスタンプ）
- `visitors`: その5分間の来客数

## Flutter統合

### サービスクラス例
```dart
class PredictionService {
  static const String apiUrl = 'https://your-api-domain.com';
  
  Future<List<VisitorPrediction>> fetchPrediction() async {
    final response = await http.get(Uri.parse('$apiUrl/predict'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => VisitorPrediction.fromJson(item)).toList();
    } else {
      throw Exception('予測データの取得に失敗しました');
    }
  }
}

class VisitorPrediction {
  final int hour;
  final String time;
  final double visitors;
  
  VisitorPrediction({required this.hour, required this.time, required this.visitors});
  
  factory VisitorPrediction.fromJson(Map<String, dynamic> json) {
    return VisitorPrediction(
      hour: json['hour'],
      time: json['time'],
      visitors: json['visitors'].toDouble(),
    );
  }
}
```

## デプロイ

### 開発環境
```bash
uvicorn onsen_api:app --reload --host 0.0.0.0 --port 8000
```

### 本番環境
```bash
uvicorn onsen_api:app --host 0.0.0.0 --port 8000 --workers 4
```

## 制限事項・注意点

### データ要件
- 過去4週間以上のデータが必要
- データは14-23時のみ有効
- Supabaseには5分間隔のデータを格納
- 予測時に5分毎のデータを1時間毎に自動集約

### パフォーマンス
- 予測処理は数秒かかる
- キャッシュ機能の実装を推奨
- 最低50件のデータが必要

### 今後の改善案
- 予測結果のキャッシュ機能
- 複数日分の予測対応
- 信頼区間の表示
- 異常値検知機能
