# CLAUDE.md

このファイルは、Claude Code (claude.ai/code) がこのリポジトリのコードを操作する際のガイダンスを提供します。

## プロジェクト概要

スタンプカード、チャート、ソーシャルメディア統合など、複数のインタラクティブコンポーネントを持つホーム画面UIを特徴とするFlutterハッカソンプロジェクトです。アプリは画像アセット、ユーザー進捗追跡、埋め込みTwitterタイムラインを含む視覚的ダッシュボードを表示します。

## 開発コマンド

### Flutter開発
- `cd hackathon2_app` - Flutterプロジェクトディレクトリに移動（必須の最初のステップ）
- `flutter run` - ホットリロード付きで開発サーバーを起動
- `flutter run --release` - パフォーマンステスト用にリリースモードで実行
- `flutter build apk` - Android APKをビルド
- `flutter build ios` - iOSアプリケーションをビルド
- `flutter clean` - ビルドキャッシュと生成されたファイルをクリーン
- `flutter pub get` - 依存関係をインストール/更新

### コード品質
- `flutter analyze` - 静的解析とリンティングを実行
- `flutter test` - ユニットテストとウィジェットテストを実行

### アセット生成
- `flutter packages pub run build_runner build` - flutter_gen_runnerからアセットを生成
- `assets/images/`ディレクトリに新しい画像を追加した後に実行

## アーキテクチャ概要

### コンポーネントベースのUI構造
アプリは画面と再利用可能なウィジェットを明確に分離したコンポーネントベースのアーキテクチャに従っています：

- **HomeScreen**: スクロール可能なコンテンツ用にListViewを使用するメインコンテナ
- **モジュラーコンポーネント**: 各UI要素は独立した再利用可能なウィジェット
- **アセット管理**: タイプセーフなアセットアクセスにflutter_genを使用
- **カラーシステム**: `AppColor`クラスでの一元化されたカラー定義

### 主要な依存関係
- `webview_flutter: ^4.4.2` - カスタムスクロールハンドリング付きの埋め込みTwitterタイムライン
- `gap: ^3.0.1` - 一貫したレイアウトのためのスペーシングユーティリティ
- `url_launcher: ^6.1.10` - 外部リンクハンドリング
- `flutter_gen_runner: ^5.7.0` - アセットコード生成
- `build_runner: ^2.4.13` - ビルドシステム自動化

### ファイル構造
```
lib/
├── main.dart                           # アプリのエントリーポイント
├── ui/home/
│   └── widgets/
│       ├── screen.dart                 # HomeScreenコンテナ
│       └── components/
│           ├── stamp_card.dart         # 進捗追跡グリッド
│           ├── button.dart             # アクションボタン
│           ├── hourly_chart.dart       # データ可視化
│           └── twitter_post.dart       # WebViewソーシャル統合
├── utils/
│   └── color.dart                      # AppColor定数
└── gen/
    └── assets.gen.dart                 # 生成されたアセットクラス
```

## コンポーネント統合パターン

### WebViewスクロール処理
Twitterコンポーネントは、ジェスチャーの干渉を防ぐために`NotificationListener<ScrollNotification>`を使用してWebViewコンテンツと親ListViewの間の専用スクロール競合解決を実装します。

### アセット使用方法
- 画像: `Assets.images.fuji.image()` - タイプセーフなアセット読み込み
- `assets/images/`ディレクトリのファイルから生成
- build_runnerによる自動再生成

### カラーシステム
- `AppColor.lightBlue`、`AppColor.card`などを使用
- 一元化されたテーマ設定により一貫性を確保
- セマンティックカラー名（card、primaryBlackなど）を含む

## 作業ディレクトリ

Flutterコマンドを実行する前に必ずFlutterプロジェクトディレクトリに移動してください：
```bash
cd hackathon2_app
```

## 現在の開発状況

- ブランチ: `FE/issue_1/create_home_screen_ui`
- 複数のインタラクティブコンポーネントを持つメイン画面実装完了
- スクロール最適化付きのTwitterタイムライン統合
- 画像リソースと設定されたアセットパイプライン

## ブランチ命名規則
### FE
```
FE/issue_123/taskname
```
### API
```
API/issue_123/taskname
```