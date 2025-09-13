# Material Design Google Slides Generator

Google Apps Script (GAS) を使用して、Material Design 3準拠のGoogleスライドを自動生成するスクリプト集です。

## 概要

このプロジェクトは、Material Design 3のガイドラインに従った美しいプレゼンテーションを自動的に作成するGoogle Apps Scriptのコレクションです。

## ファイル構成

### MaterialSlideGenerator.gs
基本的なMaterial Designテンプレートとコンポーネントを提供します：
- Material Design 3カラーパレット
- 基本的なスライドレイアウト（タイトル、コンテンツ、2カラム）
- Material Card コンポーネント
- FAB (Floating Action Button) 要素

### AdvancedLayouts.gs
より高度なレイアウトとビジュアライゼーション：
- データビジュアライゼーション（バーチャート）
- タイムライン表示
- グリッドレイアウト
- 比較スライド
- 引用スライド

## 使用方法

### 1. Google Apps Scriptプロジェクトの作成

1. [Google Apps Script](https://script.google.com/)にアクセス
2. 新しいプロジェクトを作成
3. スクリプトファイル（.gs）の内容をコピー＆ペースト

### 2. 基本的な使用例

```javascript
// シンプルなプレゼンテーションを作成
function createMyPresentation() {
  const presentation = createMaterialPresentation('My Presentation');

  // タイトルスライドを追加
  createTitleSlide(
    presentation,
    'プレゼンテーションタイトル',
    'サブタイトル',
    '作成者名'
  );

  // コンテンツスライドを追加
  createContentSlide(
    presentation,
    'スライドタイトル',
    ['ポイント1', 'ポイント2', 'ポイント3']
  );

  Logger.log('作成完了: ' + presentation.getUrl());
}
```

### 3. サンプルプレゼンテーションの生成

```javascript
// 基本的なサンプル
generateSamplePresentation();

// 高度なレイアウトのサンプル
generateAdvancedSamplePresentation();
```

## Material Design カラーパレット

以下のMaterial Design 3カラーが定義されています：

- **Primary**: #006EFF（メインアクセント色）
- **Secondary**: #565E71（セカンダリアクセント色）
- **Tertiary**: #705574（第三のアクセント色）
- **Surface**: #F9F9FF（サーフェス色）
- **Background**: #F9F9FF（背景色）
- **Error**: #BA1A1A（エラー色）

## 利用可能なスライドレイアウト

### 基本レイアウト
- **タイトルスライド**: プレゼンテーションの開始ページ
- **セクションヘッダー**: セクション区切り
- **コンテンツスライド**: タイトルと箇条書き
- **2カラムレイアウト**: 左右分割レイアウト

### 高度なレイアウト
- **データビジュアライゼーション**: バーチャート表示
- **タイムライン**: 時系列イベント表示
- **グリッドレイアウト**: カード型グリッド配置
- **比較スライド**: 2つのオプションの比較
- **引用スライド**: 名言や重要な引用の表示

## カスタマイズ

### カラーの変更

`MATERIAL_COLORS`オブジェクトを編集することで、カラーパレットをカスタマイズできます：

```javascript
const MATERIAL_COLORS = {
  primary: '#your-color-here',
  // ...
};
```

### 新しいレイアウトの追加

既存の関数を参考に、新しいレイアウト関数を作成できます：

```javascript
function createCustomSlide(presentation, title, content) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  // カスタムレイアウトを実装
  return slide;
}
```

## 注意事項

- Google Slidesの一部の高度な機能（影のエフェクトなど）は、Google Apps Script APIの制限により完全には実装できない場合があります
- 大量のスライドを生成する場合は、実行時間の制限に注意してください
- 生成されたプレゼンテーションは、Google Slidesエディタで手動で編集・調整できます

## ライセンス

このプロジェクトは教育・開発目的で自由に使用できます。

## 参考資料

- [Material Design 3](https://m3.material.io/)
- [Google Apps Script Slides Service](https://developers.google.com/apps-script/reference/slides)
- [Google Slides API](https://developers.google.com/slides/api)