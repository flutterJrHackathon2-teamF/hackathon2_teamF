/**
 * Material Design準拠のGoogleスライドテンプレート生成スクリプト
 * Material Design 3のガイドラインに従った配色とレイアウトを提供
 */

// Material Design 3 カラーパレット
const MATERIAL_COLORS = {
  // Primary colors
  primary: '#006EFF',
  primaryContainer: '#D4E3FF',
  onPrimary: '#FFFFFF',
  onPrimaryContainer: '#001B3E',

  // Secondary colors
  secondary: '#565E71',
  secondaryContainer: '#DAE2F9',
  onSecondary: '#FFFFFF',
  onSecondaryContainer: '#131C2B',

  // Tertiary colors
  tertiary: '#705574',
  tertiaryContainer: '#FAD8FD',
  onTertiary: '#FFFFFF',
  onTertiaryContainer: '#29132D',

  // Neutral colors
  surface: '#F9F9FF',
  surfaceVariant: '#E1E2EC',
  background: '#F9F9FF',
  onSurface: '#1A1C1E',
  onSurfaceVariant: '#44474E',

  // Error colors
  error: '#BA1A1A',
  errorContainer: '#FFDAD6',
  onError: '#FFFFFF',
  onErrorContainer: '#410002',

  // Additional
  outline: '#74777F',
  outlineVariant: '#C4C6D0',
  shadow: '#000000'
};

/**
 * マテリアルデザイン準拠のプレゼンテーションを作成
 * @param {string} title - プレゼンテーションのタイトル
 * @return {GoogleAppsScript.Slides.Presentation} 作成されたプレゼンテーション
 */
function createMaterialPresentation(title = 'Material Design Presentation') {
  const presentation = SlidesApp.create(title);

  // プレゼンテーション全体のテーマ設定
  applyMaterialTheme(presentation);

  return presentation;
}

/**
 * マテリアルデザインテーマを適用
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 */
function applyMaterialTheme(presentation) {
  // 最初のスライドの背景色のみ設定
  const slides = presentation.getSlides();
  if (slides.length > 0) {
    const firstSlide = slides[0];
    firstSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);
  }
}

/**
 * タイトルスライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - メインタイトル
 * @param {string} subtitle - サブタイトル
 * @param {string} author - 作成者名
 */
function createTitleSlide(presentation, title, subtitle, author) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);

  // 背景をプライマリコンテナー色に設定
  slide.getBackground().setSolidFill(MATERIAL_COLORS.primaryContainer);

  // 手動でテキストボックスを作成
  // タイトル
  const titleText = slide.insertTextBox(title, 50, 150, 620, 100);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  titleStyle.setFontSize(48);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);
  const titleParagraph = titleText.getText().getParagraphStyle();
  titleParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  // サブタイトルと作成者
  const subtitleFullText = subtitle + '\n\n' + author;
  const subtitleTextBox = slide.insertTextBox(subtitleFullText, 50, 280, 620, 80);
  const subtitleStyle = subtitleTextBox.getText().getTextStyle();
  subtitleStyle.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  subtitleStyle.setFontSize(24);
  subtitleStyle.setFontFamily('Roboto');
  const subtitleParagraph = subtitleTextBox.getText().getParagraphStyle();
  subtitleParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  return slide;
}

/**
 * セクションヘッダースライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} sectionTitle - セクションタイトル
 */
function createSectionHeaderSlide(presentation, sectionTitle) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);

  // 背景をセカンダリコンテナー色に設定
  slide.getBackground().setSolidFill(MATERIAL_COLORS.secondaryContainer);

  // セクションタイトルを中央に配置
  const titleText = slide.insertTextBox(sectionTitle, 50, 200, 620, 100);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSecondaryContainer);
  titleStyle.setFontSize(40);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);
  const titleParagraph = titleText.getText().getParagraphStyle();
  titleParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  return slide;
}

/**
 * コンテンツスライドを作成（タイトルと本文）
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Array<string>} bulletPoints - 箇条書きポイント
 */
function createContentSlide(presentation, title, bulletPoints) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);

  // 背景色を設定
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトルを上部に配置
  const titleText = slide.insertTextBox(title, 50, 50, 620, 60);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // 本文（箇条書き）を配置
  if (bulletPoints.length > 0) {
    const formattedText = '• ' + bulletPoints.join('\n• ');
    const bodyText = slide.insertTextBox(formattedText, 50, 130, 620, 320);
    const bodyStyle = bodyText.getText().getTextStyle();
    bodyStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
    bodyStyle.setFontSize(18);
    bodyStyle.setFontFamily('Roboto');
  }

  return slide;
}

/**
 * 2カラムレイアウトスライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Array<string>} leftContent - 左カラムの内容
 * @param {Array<string>} rightContent - 右カラムの内容
 */
function createTwoColumnSlide(presentation, title, leftContent, rightContent) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);

  // 背景色を設定
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトルを上部に配置
  const titleText = slide.insertTextBox(title, 50, 50, 620, 60);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // 左カラム
  const leftText = slide.insertTextBox(leftContent.join('\n'), 50, 130, 300, 320);
  const leftStyle = leftText.getText().getTextStyle();
  leftStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
  leftStyle.setFontSize(16);
  leftStyle.setFontFamily('Roboto');

  // 右カラム
  const rightText = slide.insertTextBox(rightContent.join('\n'), 370, 130, 300, 320);
  const rightStyle = rightText.getText().getTextStyle();
  rightStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
  rightStyle.setFontSize(16);
  rightStyle.setFontFamily('Roboto');

  return slide;
}

/**
 * カード要素を追加（Material Design Card）
 * @param {GoogleAppsScript.Slides.Slide} slide
 * @param {number} left - X座標
 * @param {number} top - Y座標
 * @param {number} width - 幅
 * @param {number} height - 高さ
 * @param {string} title - カードタイトル
 * @param {string} content - カード内容
 */
function addMaterialCard(slide, left, top, width, height, title, content) {
  // カードの背景となる角丸四角形を作成
  const card = slide.insertShape(SlidesApp.ShapeType.ROUND_RECTANGLE, left, top, width, height);
  card.getFill().setSolidFill(MATERIAL_COLORS.surface);
  card.getBorder().setTransparent();

  // エレベーション効果（影）を追加
  // Google Slides APIでは直接影を設定できないため、背景に別の図形を配置して疑似的に実現
  const shadow = slide.insertShape(
    SlidesApp.ShapeType.ROUND_RECTANGLE,
    left + 2,
    top + 2,
    width,
    height
  );
  shadow.getFill().setSolidFill('#CCCCCC'); // 薄いグレー
  shadow.getBorder().setTransparent();
  shadow.sendToBack();

  // カードタイトル
  const titleText = slide.insertTextBox(title, left + 16, top + 16, width - 32, 30);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(20);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // カード内容
  const contentText = slide.insertTextBox(content, left + 16, top + 56, width - 32, height - 72);
  const contentStyle = contentText.getText().getTextStyle();
  contentStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
  contentStyle.setFontSize(14);
  contentStyle.setFontFamily('Roboto');

  return {card, shadow, titleText, contentText};
}

/**
 * FAB（Floating Action Button）風の要素を追加
 * @param {GoogleAppsScript.Slides.Slide} slide
 * @param {number} right - 右端からの距離
 * @param {number} bottom - 下端からの距離
 * @param {string} icon - アイコンテキスト（例: "+"）
 */
function addFAB(slide, right = 24, bottom = 24, icon = '+') {
  // Google Slidesの標準ページサイズを使用（720 x 540ポイント）
  const pageWidth = 720;
  const pageHeight = 540;
  const fabSize = 56;

  // FABの円を作成
  const fab = slide.insertShape(
    SlidesApp.ShapeType.ELLIPSE,
    pageWidth - right - fabSize,
    pageHeight - bottom - fabSize,
    fabSize,
    fabSize
  );
  fab.getFill().setSolidFill(MATERIAL_COLORS.primary);
  fab.getBorder().setTransparent();

  // アイコンテキスト
  const iconText = slide.insertTextBox(
    icon,
    pageWidth - right - fabSize,
    pageHeight - bottom - fabSize,
    fabSize,
    fabSize
  );
  const iconStyle = iconText.getText().getTextStyle();
  iconStyle.setForegroundColor(MATERIAL_COLORS.onPrimary);
  iconStyle.setFontSize(24);
  iconStyle.setBold(true);
  const paragraphStyle = iconText.getText().getParagraphStyle();
  paragraphStyle.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  return {fab, iconText};
}

/**
 * サンプルプレゼンテーションを生成
 */
function generateSamplePresentation() {
  const presentation = createMaterialPresentation('サンプルプレゼンテーション');

  // タイトルスライド
  createTitleSlide(
    presentation,
    'サンプルタイトル',
    'サンプルサブタイトル',
    'サンプル作成者'
  );

  // セクションヘッダー
  createSectionHeaderSlide(presentation, 'サンプルセクションx');

  // コンテンツスライド
  createContentSlide(
    presentation,
    'サンプルコンテンツ',
    [
      'サンプルテキスト1',
      'サンプルテキスト2',
      'サンプルテキスト3',
      'サンプルテキスト4',
      'サンプルテキスト5'
    ]
  );

  // 2カラムスライド
  createTwoColumnSlide(
    presentation,
    'サンプル2カラム',
    [
      '左カラムタイトル:',
      'サンプルテキストA',
      'サンプルテキストB',
      'サンプルテキストC'
    ],
    [
      '右カラムタイトル:',
      'サンプルテキストX',
      'サンプルテキストY',
      'サンプルテキストZ'
    ]
  );

  // カード要素を含むカスタムスライド
  const customSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  customSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトルを追加
  const titleText = customSlide.insertTextBox('サンプルカード', 24, 24, 400, 40);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // カードを追加
  addMaterialCard(
    customSlide,
    24, 80, 200, 150,
    'サンプルカード1',
    'サンプルテキストです。これはカードコンポーネントのサンプルです。'
  );

  addMaterialCard(
    customSlide,
    240, 80, 200, 150,
    'サンプルカード2',
    'サンプルテキストです。これも別のカードコンポーネントです。'
  );

  // FABを追加
  addFAB(customSlide);

  // 完了メッセージ
  Logger.log('サンプルプレゼンテーションが作成されました: ' + presentation.getUrl());

  return presentation;
}

/**
 * メニューアイテムを追加（Google Slidesのアドオンとして使用する場合）
 */
function onOpen() {
  SlidesApp.getUi()
    .createMenu('Material Design')
    .addItem('サンプルプレゼンテーションを生成', 'generateSamplePresentation')
    .addSeparator()
    .addItem('タイトルスライドを追加', 'addTitleSlideFromMenu')
    .addItem('コンテンツスライドを追加', 'addContentSlideFromMenu')
    .addItem('カードを追加', 'addCardFromMenu')
    .addToUi();
}

/**
 * メニューから呼び出される関数
 */
function addTitleSlideFromMenu() {
  const presentation = SlidesApp.getActivePresentation();
  createTitleSlide(presentation, 'New Title', 'Subtitle', 'Author');
}

function addContentSlideFromMenu() {
  const presentation = SlidesApp.getActivePresentation();
  createContentSlide(presentation, 'Content Title', ['Point 1', 'Point 2', 'Point 3']);
}

function addCardFromMenu() {
  const presentation = SlidesApp.getActivePresentation();
  const slide = presentation.getSelection().getCurrentPage();
  if (slide) {
    addMaterialCard(slide, 50, 50, 200, 150, 'Card Title', 'Card content goes here');
  }
}