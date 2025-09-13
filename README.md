# Hackathon2 Team F - Flutter App

## 概要
スタンプカード、チャート、ソーシャルメディア統合など、複数のインタラクティブコンポーネントを持つFlutterモバイルアプリケーションです。位置情報ベースのスタンプ収集機能と、リアルタイムデータ可視化を提供します。

## 主な機能
- 📍 位置情報ベースのスタンプ収集
- 📊 時間別データチャート表示
- 🐦 Twitter埋め込みタイムライン
- 💾 ローカルデータ永続化（Hive）
- 🎨 カスタムアニメーション付きローディング画面

## 技術スタック
- **Flutter**: 3.7.2+
- **状態管理**: Riverpod 2.4.9
- **データ永続化**: Hive 2.2.3
- **ルーティング**: GoRouter 14.6.2
- **コード生成**: Freezed, JsonSerializable
- **位置情報**: Geolocator 10.1.0

## ディレクトリ構成

```
hackathon2_teamF/
├── README.md                           # このファイル
├── CLAUDE.md                          # Claude Code用ガイダンス
├── AGENTS.md                          # エージェント設定
├── gas_scripts/                       # Google Apps Script
└── hackathon2_app/                   # Flutterプロジェクトルート
    ├── pubspec.yaml                   # 依存関係定義
    ├── assets/
    │   └── images/                    # 画像アセット
    │       ├── fuji.png
    │       ├── stamp_basic.png
    │       ├── stamp_gold.png
    │       └── stamp_silver.png
    ├── lib/
    │   ├── main.dart                  # アプリエントリーポイント
    │   ├── router/
    │   │   └── app_router.dart        # GoRouterナビゲーション設定
    │   ├── data/
    │   │   ├── models/
    │   │   │   ├── stamp_data.dart   # スタンプデータモデル（Freezed）
    │   │   │   ├── stamp_data.freezed.dart
    │   │   │   └── stamp_data.g.dart
    │   │   └── repositories/
    │   │       ├── location_repository.dart  # 位置情報アクセス
    │   │       └── stamp_repository.dart     # スタンプデータ永続化
    │   ├── domain/
    │   │   └── services/
    │   │       └── stamp_service.dart        # ビジネスロジック
    │   ├── presentation/
    │   │   ├── home/
    │   │   │   ├── viewmodels/
    │   │   │   │   ├── stamp_viewmodel.dart  # Riverpod Provider
    │   │   │   │   └── stamp_viewmodel.g.dart
    │   │   │   └── widgets/
    │   │   │       ├── screen.dart           # ホーム画面メインコンテナ
    │   │   │       └── components/
    │   │   │           ├── stamp_card.dart   # スタンプカードグリッド
    │   │   │           ├── button.dart       # カスタムボタン
    │   │   │           ├── hourly_chart.dart # 時間別チャート
    │   │   │           └── twitter_post.dart # Twitter WebView
    │   │   └── loading/
    │   │       └── widgets/
    │   │           └── screen.dart           # ローディング画面
    │   ├── widgets/                          # 共通ウィジェット
    │   │   ├── dialog.dart                   # カスタムダイアログ
    │   │   ├── m3e_loding.dart              # ロゴ付きローディング
    │   │   └── linear_wavy_progress.dart    # アニメーションプログレス
    │   ├── utils/
    │   │   └── color.dart                    # アプリカラー定義
    │   └── gen/
    │       └── assets.gen.dart               # 生成されたアセットクラス
    └── test/
        └── widget_test.dart                   # テストファイル
```

## アーキテクチャ

### レイヤード・アーキテクチャ
```
Presentation Layer (UI/ViewModels)
       ↓
Domain Layer (Services/Business Logic)
       ↓
Data Layer (Repositories/Models)
```

### 主要コンポーネント

#### Data Layer
- **Models**: Freezedによる不変データクラス
- **Repositories**: データソースとのインターフェース
  - `LocationRepository`: 位置情報取得
  - `StampRepository`: Hiveによるローカルデータ永続化

#### Domain Layer
- **Services**: ビジネスロジックの実装
  - `StampService`: スタンプ収集・検証ロジック

#### Presentation Layer
- **ViewModels**: Riverpodによる状態管理
- **Widgets**: UIコンポーネント
  - モジュラー設計による再利用可能なコンポーネント
  - WebView統合によるソーシャルメディア埋め込み

## セットアップ

### 必要環境
- Flutter SDK: 3.7.2以上
- Dart SDK: 3.0以上
- iOS: Xcode 14+（iOS開発の場合）
- Android: Android Studio（Android開発の場合）

### インストール手順

1. リポジトリをクローン
```bash
git clone [repository-url]
cd hackathon2_teamF
```

2. Flutterプロジェクトディレクトリに移動
```bash
cd hackathon2_app
```

3. 依存関係をインストール
```bash
flutter pub get
```

4. コード生成を実行
```bash
flutter packages pub run build_runner build
```

5. アプリを実行
```bash
flutter run
```

## 開発コマンド

### 基本コマンド
```bash
# 開発サーバー起動（ホットリロード付き）
flutter run

# リリースビルド実行
flutter run --release

# Android APKビルド
flutter build apk

# iOSアプリビルド
flutter build ios

# キャッシュクリーン
flutter clean

# 依存関係更新
flutter pub get
```

### コード品質
```bash
# 静的解析実行
flutter analyze

# テスト実行
flutter test
```

### コード生成
```bash
# Freezed, JsonSerializable, Riverpodコード生成
flutter packages pub run build_runner build

# 変更監視付きコード生成
flutter packages pub run build_runner watch
```

## 位置情報の権限設定

### iOS (ios/Runner/Info.plist)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>スタンプを取得するために位置情報を使用します</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>バックグラウンドでもスタンプを取得するために位置情報を使用します</string>
```

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

## カラーテーマ

アプリ全体で統一されたカラーテーマを使用：

- `AppColor.lightBlue`: メインテーマカラー
- `AppColor.card`: カード背景色
- `AppColor.primaryBlack`: テキスト色
- `AppColor.grey`: セカンダリ要素

## 貢献

1. Featureブランチを作成
```bash
git checkout -b FE/issue_[番号]/[タスク名]
```

2. 変更をコミット
```bash
git commit -m "feat: 新機能の追加"
```

3. Pull Requestを作成

## ライセンス

このプロジェクトはハッカソン用のプロトタイプです。
