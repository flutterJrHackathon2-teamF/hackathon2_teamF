# API テストガイド

## 概要
温泉来客数予測APIをフロントエンド開発者がテストするための手順書です。

## 前提条件

### 必要なツール
- Python 3.8以上
- pip（Pythonパッケージマネージャー）
- curl（通常はプリインストール済み）

### 必要なパッケージのインストール
```bash
cd predictor
pip install -r requirements.txt
```

## クイックスタート

### 1. 環境変数の設定

#### 方法A: 環境変数を直接設定
```bash
export SUPABASE_URL="https://sejdzkjojnkdvgnfocfr.supabase.co"
export SUPABASE_KEY="your-anon-key-here"
```

#### 方法B: .envファイルを作成
```bash
cd predictor
cat > .env << EOF
SUPABASE_URL=https://sejdzkjojnkdvgnfocfr.supabase.co
SUPABASE_KEY=your-anon-key-here
EOF
```

### 2. APIサーバーの起動
```bash
# predictorディレクトリから実行
cd predictor
uvicorn onsen_api:app --reload --host 0.0.0.0 --port 8000
```

サーバーが起動すると以下のメッセージが表示されます：
```
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
INFO:     Started reloader process
```

### 3. APIのテスト

新しいターミナルを開いて、以下のコマンドを実行します。

## テスト方法

### 方法1: curlコマンド（最も簡単）

#### 基本的なテスト
```bash
curl http://localhost:8000/predict
```

#### JSON整形して表示
```bash
curl http://localhost:8000/predict | python -m json.tool
```

#### レスポンスヘッダーも確認
```bash
curl -i http://localhost:8000/predict
```

#### サイレントモードで本文のみ表示
```bash
curl -s http://localhost:8000/predict | python -m json.tool
```

### 方法2: httpieを使用（より見やすい出力）

#### インストール
```bash
pip install httpie
```

#### テスト実行
```bash
http GET localhost:8000/predict
```

### 方法3: Pythonワンライナー

#### レスポンスの確認
```bash
python -c "import requests; import json; print(json.dumps(requests.get('http://localhost:8000/predict').json(), indent=2))"
```

#### データ件数の確認
```bash
python -c "import requests; data = requests.get('http://localhost:8000/predict').json(); print(f'データ件数: {len(data)}件')"
```

#### 時間範囲の確認
```bash
python -c "import requests; data = requests.get('http://localhost:8000/predict').json(); hours = [d['hour'] for d in data]; print(f'時間範囲: {min(hours)}時-{max(hours)}時')"
```

## 期待されるレスポンス

### 正常なレスポンス例
```json
[
  {
    "hour": 14,
    "time": "14:00",
    "visitors": 12.5
  },
  {
    "hour": 15,
    "time": "15:00",
    "visitors": 18.3
  },
  {
    "hour": 16,
    "time": "16:00",
    "visitors": 22.1
  },
  // ... 23時まで合計10件
]
```

### レスポンスの仕様
| フィールド | 型 | 説明 |
|-----------|---|------|
| hour | integer | 時間（14-23） |
| time | string | 表示用時刻文字列（HH:MM形式） |
| visitors | float | 予測来客数（小数点1桁） |

### データ件数
- 固定10件（14:00から23:00まで1時間ごと）

## Flutter側での使用例

### Dartコードでのアクセス例
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchPrediction() async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/predict')
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load prediction');
  }
}
```

### Flutter開発時の注意点
- Android エミュレータからは `10.0.2.2:8000` を使用
- iOS シミュレータからは `localhost:8000` を使用
- 実機テストの場合は開発マシンのIPアドレスを使用

## トラブルシューティング

### エラー: Connection refused
```bash
curl: (7) Failed to connect to localhost port 8000: Connection refused
```
**解決方法**: APIサーバーが起動していません。`uvicorn onsen_api:app --reload`を実行してください。

### エラー: Supabaseデータ取得エラー
```json
{"detail": "データ取得エラー: ..."}
```
**解決方法**: 
1. 環境変数が正しく設定されているか確認
2. Supabaseのアクセスキーが有効か確認
3. Supabaseに`visitors_5m`テーブルが存在するか確認

### エラー: 予測に必要な十分なデータがありません
```json
{"detail": "予測に必要な十分なデータがありません"}
```
**解決方法**: Supabaseに最低50件以上のデータが必要です。

## モックデータでのテスト

Supabaseを使わずにローカルのCSVファイルでテストする場合：

1. `onsen_api.py`を一時的に修正
2. `fetch_visitor_data_from_supabase`関数をコメントアウト
3. ローカルCSVを読み込むように変更

```python
# onsen_api.pyの一時的な修正例
def fetch_visitor_data_from_supabase(days: int = 28) -> pd.DataFrame:
    # テスト用：ローカルCSVを使用
    df = pd.read_csv('onsen_visitors.csv', parse_dates=['ds'])
    df = df.rename(columns={'ds': 'slot_5m', 'y': 'visitors'})
    return df
```

## 本番環境への移行

### 環境変数の設定
```bash
export SUPABASE_URL="本番のSupabase URL"
export SUPABASE_KEY="本番のSupabase Key"
```

### サーバー起動（本番モード）
```bash
uvicorn onsen_api:app --host 0.0.0.0 --port 8000 --workers 4
```

### HTTPS化（推奨）
本番環境ではnginxやCaddyを使用してHTTPS化することを推奨します。

## 参考リンク

- [FastAPI ドキュメント](https://fastapi.tiangolo.com/)
- [Supabase ドキュメント](https://supabase.io/docs)
- [Prophet ドキュメント](https://facebook.github.io/prophet/)