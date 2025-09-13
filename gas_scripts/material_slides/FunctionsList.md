# Material Design Google Slides 関数一覧

## 基本関数

### 1. createMaterialPresentation(title)
新しいMaterial Design準拠のプレゼンテーションを作成

**パラメータ:**
- `title` (string): プレゼンテーションのタイトル

**使用例:**
```javascript
const presentation = createMaterialPresentation('私のプレゼンテーション');
```

### 2. applyMaterialTheme(presentation)
プレゼンテーションにMaterial Designテーマを適用

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション

## スライド作成関数

### 3. createTitleSlide(presentation, title, subtitle, author)
タイトルスライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): メインタイトル
- `subtitle` (string): サブタイトル
- `author` (string): 作成者名

**使用例:**
```javascript
createTitleSlide(presentation, 'プレゼンテーション', 'サブタイトル', '山田太郎');
```

### 4. createSectionHeaderSlide(presentation, sectionTitle)
セクションヘッダースライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `sectionTitle` (string): セクションタイトル

**使用例:**
```javascript
createSectionHeaderSlide(presentation, '第1章 概要');
```

### 5. createContentSlide(presentation, title, bulletPoints)
コンテンツスライド（箇条書き）を作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `bulletPoints` (Array<string>): 箇条書きのポイント

**使用例:**
```javascript
createContentSlide(presentation, 'ポイント', [
  '重要な点1',
  '重要な点2',
  '重要な点3'
]);
```

### 6. createTwoColumnSlide(presentation, title, leftContent, rightContent)
2カラムレイアウトスライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `leftContent` (Array<string>): 左カラムの内容
- `rightContent` (Array<string>): 右カラムの内容

**使用例:**
```javascript
createTwoColumnSlide(presentation, '比較',
  ['メリット1', 'メリット2'],
  ['デメリット1', 'デメリット2']
);
```

## コンポーネント追加関数

### 7. addMaterialCard(slide, left, top, width, height, title, content)
Material Designカードを追加

**パラメータ:**
- `slide` (Slide): 対象のスライド
- `left` (number): X座標
- `top` (number): Y座標
- `width` (number): 幅
- `height` (number): 高さ
- `title` (string): カードタイトル
- `content` (string): カード内容

**使用例:**
```javascript
const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
addMaterialCard(slide, 50, 50, 200, 150, 'カードタイトル', '内容説明');
```

### 8. addFAB(slide, right, bottom, icon)
FAB（Floating Action Button）を追加

**パラメータ:**
- `slide` (Slide): 対象のスライド
- `right` (number): 右端からの距離（デフォルト: 24）
- `bottom` (number): 下端からの距離（デフォルト: 24）
- `icon` (string): アイコンテキスト（デフォルト: '+'）

**使用例:**
```javascript
addFAB(slide, 24, 24, '✓');
```

## 高度なレイアウト関数

### 9. createDataVisualizationSlide(presentation, title, data)
データビジュアライゼーションスライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `data` (Array<Object>): グラフデータ `[{label: string, value: number}]`

**使用例:**
```javascript
createDataVisualizationSlide(presentation, '売上データ', [
  {label: '1月', value: 100},
  {label: '2月', value: 150},
  {label: '3月', value: 120}
]);
```

### 10. createTimelineSlide(presentation, title, events)
タイムラインスライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `events` (Array<Object>): イベント `[{date: string, title: string, description: string}]`

**使用例:**
```javascript
createTimelineSlide(presentation, 'プロジェクト進行', [
  {date: '2024年1月', title: '企画', description: '初期計画'},
  {date: '2024年3月', title: '開発', description: '実装開始'}
]);
```

### 11. createGridLayoutSlide(presentation, title, items)
グリッドレイアウトスライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `items` (Array<Object>): グリッドアイテム `[{title: string, icon: string, description: string}]`

**使用例:**
```javascript
createGridLayoutSlide(presentation, '特徴', [
  {title: '高速', icon: '⚡', description: '素早い処理'},
  {title: '安全', icon: '🔒', description: 'セキュリティ重視'}
]);
```

### 12. createComparisonSlide(presentation, title, option1, option2)
比較スライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `title` (string): スライドタイトル
- `option1` (Object): オプション1 `{title: string, pros: Array<string>, cons: Array<string>}`
- `option2` (Object): オプション2 `{title: string, pros: Array<string>, cons: Array<string>}`

**使用例:**
```javascript
createComparisonSlide(presentation, '選択肢の比較',
  {
    title: 'プランA',
    pros: ['安価', '簡単'],
    cons: ['機能制限']
  },
  {
    title: 'プランB',
    pros: ['高機能', '拡張性'],
    cons: ['高価格']
  }
);
```

### 13. createQuoteSlide(presentation, quote, author, source)
引用スライドを作成

**パラメータ:**
- `presentation` (Presentation): 対象のプレゼンテーション
- `quote` (string): 引用文
- `author` (string): 著者名
- `source` (string): 出典（オプション）

**使用例:**
```javascript
createQuoteSlide(presentation,
  'デザインとは見た目ではない。どう機能するかだ。',
  'スティーブ・ジョブズ',
  'Apple Inc.'
);
```

## サンプル生成関数

### 14. generateSamplePresentation()
基本的なサンプルプレゼンテーションを生成

**使用例:**
```javascript
generateSamplePresentation();
```

### 15. generateAdvancedSamplePresentation()
高度なレイアウトのサンプルプレゼンテーションを生成

**使用例:**
```javascript
generateAdvancedSamplePresentation();
```

## メニュー関数（Googleスライドアドオン用）

### 16. onOpen()
Googleスライドにメニューを追加

### 17. addTitleSlideFromMenu()
メニューからタイトルスライドを追加

### 18. addContentSlideFromMenu()
メニューからコンテンツスライドを追加

### 19. addCardFromMenu()
メニューからカードを追加

## Material Design カラーパレット

### MATERIAL_COLORS オブジェクト
```javascript
const MATERIAL_COLORS = {
  primary: '#006EFF',           // プライマリカラー
  primaryContainer: '#D4E3FF',  // プライマリコンテナ
  secondary: '#565E71',         // セカンダリカラー
  secondaryContainer: '#DAE2F9', // セカンダリコンテナ
  tertiary: '#705574',          // ターシャリカラー
  tertiaryContainer: '#FAD8FD', // ターシャリコンテナ
  surface: '#F9F9FF',          // サーフェス
  background: '#F9F9FF',       // 背景
  error: '#BA1A1A',           // エラー
  outline: '#74777F'          // アウトライン
  // その他多数のカラー定義
};
```

## 完全な使用例

```javascript
function createMyPresentation() {
  // 1. プレゼンテーション作成
  const presentation = createMaterialPresentation('会社紹介プレゼンテーション');

  // 2. タイトルスライド
  createTitleSlide(presentation, '株式会社サンプル', '会社紹介資料', '営業部 田中');

  // 3. セクションヘッダー
  createSectionHeaderSlide(presentation, '会社概要');

  // 4. コンテンツスライド
  createContentSlide(presentation, '我々の強み', [
    '20年の実績',
    '優秀なエンジニアチーム',
    '顧客満足度95%',
    '24時間サポート体制'
  ]);

  // 5. データ可視化
  createDataVisualizationSlide(presentation, '売上推移', [
    {label: '2020', value: 80},
    {label: '2021', value: 95},
    {label: '2022', value: 110},
    {label: '2023', value: 125}
  ]);

  // 6. 引用スライド
  createQuoteSlide(presentation,
    '顧客の成功が我々の成功である',
    '代表取締役 佐藤',
    '創業時の理念'
  );

  Logger.log('プレゼンテーション作成完了: ' + presentation.getUrl());
}
```