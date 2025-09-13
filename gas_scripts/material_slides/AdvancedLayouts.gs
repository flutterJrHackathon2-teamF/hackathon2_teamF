/**
 * Material Design 3準拠の高度なレイアウトとコンポーネント
 */

/**
 * データビジュアライゼーションスライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Array<Object>} data - グラフデータ [{label: string, value: number}]
 */
function createDataVisualizationSlide(presentation, title, data) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトル
  const titleText = slide.insertTextBox(title, 24, 24, 600, 40);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // チャートコンテナ（カード）
  const chartCard = slide.insertShape(
    SlidesApp.ShapeType.ROUND_RECTANGLE,
    24, 80, 672, 400
  );
  chartCard.getFill().setSolidFill(MATERIAL_COLORS.surface);
  chartCard.getBorder().setTransparent();

  // バーチャートを描画
  const chartLeft = 48;
  const chartTop = 120;
  const barWidth = 60;
  const maxHeight = 300;
  const spacing = 20;

  // 最大値を取得
  const maxValue = Math.max(...data.map(d => d.value));

  data.forEach((item, index) => {
    const barHeight = (item.value / maxValue) * maxHeight;
    const xPos = chartLeft + (index * (barWidth + spacing));
    const yPos = chartTop + maxHeight - barHeight;

    // バーを描画
    const bar = slide.insertShape(
      SlidesApp.ShapeType.RECTANGLE,
      xPos, yPos, barWidth, barHeight
    );
    bar.getFill().setSolidFill(MATERIAL_COLORS.primary);
    bar.getBorder().setTransparent();

    // ラベルを追加
    const label = slide.insertTextBox(
      item.label,
      xPos, chartTop + maxHeight + 10, barWidth, 30
    );
    const labelStyle = label.getText().getTextStyle();
    labelStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
    labelStyle.setFontSize(12);
    labelStyle.setFontFamily('Roboto');
    const labelParagraph = label.getText().getParagraphStyle();
    labelParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

    // 値を表示
    const valueText = slide.insertTextBox(
      item.value.toString(),
      xPos, yPos - 25, barWidth, 20
    );
    const valueStyle = valueText.getText().getTextStyle();
    valueStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
    valueStyle.setFontSize(14);
    valueStyle.setFontFamily('Roboto');
    valueStyle.setBold(true);
    const valueParagraph = valueText.getText().getParagraphStyle();
    valueParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);
  });

  return slide;
}

/**
 * タイムラインスライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Array<Object>} events - タイムラインイベント [{date: string, title: string, description: string}]
 */
function createTimelineSlide(presentation, title, events) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトル
  const titleText = slide.insertTextBox(title, 24, 24, 600, 40);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // タイムラインライン
  const lineY = 280;
  const line = slide.insertLine(
    50, lineY,
    670, lineY,
    SlidesApp.LineCategory.STRAIGHT
  );
  line.getLineFill().setSolidFill(MATERIAL_COLORS.outline);
  line.setWeight(2);

  // イベントを配置
  const totalWidth = 620;
  const spacing = totalWidth / (events.length - 1);

  events.forEach((event, index) => {
    const xPos = 50 + (index * spacing);

    // イベントポイント（円）
    const point = slide.insertShape(
      SlidesApp.ShapeType.ELLIPSE,
      xPos - 8, lineY - 8, 16, 16
    );
    point.getFill().setSolidFill(MATERIAL_COLORS.primary);
    point.getBorder().setTransparent();

    // イベントカード
    const cardY = index % 2 === 0 ? lineY - 120 : lineY + 30;
    const eventCard = slide.insertShape(
      SlidesApp.ShapeType.ROUND_RECTANGLE,
      xPos - 80, cardY, 160, 90
    );
    eventCard.getFill().setSolidFill(MATERIAL_COLORS.surfaceVariant);
    eventCard.getBorder().setTransparent();

    // 日付
    const dateText = slide.insertTextBox(
      event.date,
      xPos - 75, cardY + 5, 150, 20
    );
    const dateStyle = dateText.getText().getTextStyle();
    dateStyle.setForegroundColor(MATERIAL_COLORS.primary);
    dateStyle.setFontSize(12);
    dateStyle.setFontFamily('Roboto');
    dateStyle.setBold(true);

    // イベントタイトル
    const eventTitle = slide.insertTextBox(
      event.title,
      xPos - 75, cardY + 25, 150, 20
    );
    const eventTitleStyle = eventTitle.getText().getTextStyle();
    eventTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
    eventTitleStyle.setFontSize(14);
    eventTitleStyle.setFontFamily('Google Sans');
    eventTitleStyle.setBold(true);

    // 説明
    if (event.description) {
      const descText = slide.insertTextBox(
        event.description,
        xPos - 75, cardY + 45, 150, 40
      );
      const descStyle = descText.getText().getTextStyle();
      descStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
      descStyle.setFontSize(11);
      descStyle.setFontFamily('Roboto');
    }

    // コネクターライン
    const connectorY = index % 2 === 0 ? cardY + 90 : cardY;
    const connector = slide.insertLine(
      xPos, lineY,
      xPos, connectorY,
      SlidesApp.LineCategory.STRAIGHT
    );
    connector.getLineFill().setSolidFill(MATERIAL_COLORS.outlineVariant);
    connector.setWeight(1);
    connector.setDashStyle(SlidesApp.DashStyle.DASH);
  });

  return slide;
}

/**
 * グリッドレイアウトスライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Array<Object>} items - グリッドアイテム [{title: string, icon: string, description: string}]
 */
function createGridLayoutSlide(presentation, title, items) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトル
  const titleText = slide.insertTextBox(title, 24, 24, 600, 40);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // グリッドレイアウト（3×2）
  const cardWidth = 210;
  const cardHeight = 160;
  const horizontalSpacing = 20;
  const verticalSpacing = 20;
  const startX = 24;
  const startY = 80;

  items.slice(0, 6).forEach((item, index) => {
    const row = Math.floor(index / 3);
    const col = index % 3;
    const xPos = startX + (col * (cardWidth + horizontalSpacing));
    const yPos = startY + (row * (cardHeight + verticalSpacing));

    // カードを作成
    const card = slide.insertShape(
      SlidesApp.ShapeType.ROUND_RECTANGLE,
      xPos, yPos, cardWidth, cardHeight
    );
    card.getFill().setSolidFill(MATERIAL_COLORS.surface);
    card.getBorder().setTransparent();

    // アイコン（大きなテキストで代用）
    const iconText = slide.insertTextBox(
      item.icon || '📦',
      xPos + 10, yPos + 10, 40, 40
    );
    const iconStyle = iconText.getText().getTextStyle();
    iconStyle.setFontSize(32);

    // タイトル
    const itemTitle = slide.insertTextBox(
      item.title,
      xPos + 60, yPos + 15, cardWidth - 70, 30
    );
    const itemTitleStyle = itemTitle.getText().getTextStyle();
    itemTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
    itemTitleStyle.setFontSize(16);
    itemTitleStyle.setFontFamily('Google Sans');
    itemTitleStyle.setBold(true);

    // 説明
    const description = slide.insertTextBox(
      item.description,
      xPos + 10, yPos + 60, cardWidth - 20, 90
    );
    const descStyle = description.getText().getTextStyle();
    descStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
    descStyle.setFontSize(12);
    descStyle.setFontFamily('Roboto');
  });

  return slide;
}

/**
 * 比較スライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} title - スライドタイトル
 * @param {Object} option1 - オプション1 {title: string, pros: Array<string>, cons: Array<string>}
 * @param {Object} option2 - オプション2 {title: string, pros: Array<string>, cons: Array<string>}
 */
function createComparisonSlide(presentation, title, option1, option2) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  slide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  // タイトル
  const titleText = slide.insertTextBox(title, 24, 24, 600, 40);
  const titleStyle = titleText.getText().getTextStyle();
  titleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  titleStyle.setFontSize(32);
  titleStyle.setFontFamily('Google Sans');
  titleStyle.setBold(true);

  // オプション1のカード
  const card1 = slide.insertShape(
    SlidesApp.ShapeType.ROUND_RECTANGLE,
    24, 80, 330, 380
  );
  card1.getFill().setSolidFill(MATERIAL_COLORS.primaryContainer);
  card1.getBorder().setTransparent();

  // オプション1のタイトル
  const option1Title = slide.insertTextBox(
    option1.title,
    34, 90, 310, 30
  );
  const option1TitleStyle = option1Title.getText().getTextStyle();
  option1TitleStyle.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  option1TitleStyle.setFontSize(20);
  option1TitleStyle.setFontFamily('Google Sans');
  option1TitleStyle.setBold(true);

  // オプション1の長所
  const pros1Text = '✓ ' + option1.pros.join('\n✓ ');
  const pros1 = slide.insertTextBox(
    'Pros:\n' + pros1Text,
    34, 130, 310, 150
  );
  const pros1Style = pros1.getText().getTextStyle();
  pros1Style.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  pros1Style.setFontSize(14);
  pros1Style.setFontFamily('Roboto');

  // オプション1の短所
  const cons1Text = '✗ ' + option1.cons.join('\n✗ ');
  const cons1 = slide.insertTextBox(
    'Cons:\n' + cons1Text,
    34, 290, 310, 150
  );
  const cons1Style = cons1.getText().getTextStyle();
  cons1Style.setForegroundColor(MATERIAL_COLORS.error);
  cons1Style.setFontSize(14);
  cons1Style.setFontFamily('Roboto');

  // オプション2のカード
  const card2 = slide.insertShape(
    SlidesApp.ShapeType.ROUND_RECTANGLE,
    366, 80, 330, 380
  );
  card2.getFill().setSolidFill(MATERIAL_COLORS.secondaryContainer);
  card2.getBorder().setTransparent();

  // オプション2のタイトル
  const option2Title = slide.insertTextBox(
    option2.title,
    376, 90, 310, 30
  );
  const option2TitleStyle = option2Title.getText().getTextStyle();
  option2TitleStyle.setForegroundColor(MATERIAL_COLORS.onSecondaryContainer);
  option2TitleStyle.setFontSize(20);
  option2TitleStyle.setFontFamily('Google Sans');
  option2TitleStyle.setBold(true);

  // オプション2の長所
  const pros2Text = '✓ ' + option2.pros.join('\n✓ ');
  const pros2 = slide.insertTextBox(
    'Pros:\n' + pros2Text,
    376, 130, 310, 150
  );
  const pros2Style = pros2.getText().getTextStyle();
  pros2Style.setForegroundColor(MATERIAL_COLORS.onSecondaryContainer);
  pros2Style.setFontSize(14);
  pros2Style.setFontFamily('Roboto');

  // オプション2の短所
  const cons2Text = '✗ ' + option2.cons.join('\n✗ ');
  const cons2 = slide.insertTextBox(
    'Cons:\n' + cons2Text,
    376, 290, 310, 150
  );
  const cons2Style = cons2.getText().getTextStyle();
  cons2Style.setForegroundColor(MATERIAL_COLORS.error);
  cons2Style.setFontSize(14);
  cons2Style.setFontFamily('Roboto');

  return slide;
}

/**
 * クォート（引用）スライドを作成
 * @param {GoogleAppsScript.Slides.Presentation} presentation
 * @param {string} quote - 引用文
 * @param {string} author - 著者名
 * @param {string} source - 出典
 */
function createQuoteSlide(presentation, quote, author, source) {
  const slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  slide.getBackground().setSolidFill(MATERIAL_COLORS.tertiaryContainer);

  // 引用符アイコン
  const quoteIcon = slide.insertTextBox('"', 100, 100, 60, 60);
  const quoteIconStyle = quoteIcon.getText().getTextStyle();
  quoteIconStyle.setForegroundColor('#C0C0C0'); // 薄いグレー
  quoteIconStyle.setFontSize(72);
  quoteIconStyle.setFontFamily('Georgia');

  // 引用文
  const quoteText = slide.insertTextBox(
    quote,
    100, 180, 520, 200
  );
  const quoteStyle = quoteText.getText().getTextStyle();
  quoteStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  quoteStyle.setFontSize(28);
  quoteStyle.setFontFamily('Georgia');
  quoteStyle.setItalic(true);
  const quoteParagraph = quoteText.getText().getParagraphStyle();
  quoteParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  // 著者名
  const authorText = slide.insertTextBox(
    '— ' + author,
    100, 400, 520, 30
  );
  const authorStyle = authorText.getText().getTextStyle();
  authorStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  authorStyle.setFontSize(20);
  authorStyle.setFontFamily('Google Sans');
  authorStyle.setBold(true);
  const authorParagraph = authorText.getText().getParagraphStyle();
  authorParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  // 出典
  if (source) {
    const sourceText = slide.insertTextBox(
      source,
      100, 430, 520, 25
    );
    const sourceStyle = sourceText.getText().getTextStyle();
    sourceStyle.setForegroundColor('#808080'); // グレー
    sourceStyle.setFontSize(14);
    sourceStyle.setFontFamily('Roboto');
    sourceStyle.setItalic(true);
    const sourceParagraph = sourceText.getText().getParagraphStyle();
    sourceParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);
  }

  return slide;
}

/**
 * 高度なサンプルプレゼンテーションを生成
 */
function generateAdvancedSamplePresentation() {
  const presentation = createMaterialPresentation('Advanced Material Design Presentation');

  // タイトルスライド
  createTitleSlide(
    presentation,
    'Advanced Layouts',
    'Material Design Components',
    'Google Apps Script'
  );

  // データビジュアライゼーション
  createDataVisualizationSlide(
    presentation,
    'Monthly Sales Data',
    [
      {label: 'Jan', value: 45},
      {label: 'Feb', value: 52},
      {label: 'Mar', value: 48},
      {label: 'Apr', value: 63},
      {label: 'May', value: 71},
      {label: 'Jun', value: 68}
    ]
  );

  // タイムライン
  createTimelineSlide(
    presentation,
    'Project Timeline',
    [
      {date: '2024 Q1', title: 'Planning', description: 'Initial research'},
      {date: '2024 Q2', title: 'Design', description: 'UI/UX design'},
      {date: '2024 Q3', title: 'Development', description: 'Implementation'},
      {date: '2024 Q4', title: 'Launch', description: 'Go to market'}
    ]
  );

  // グリッドレイアウト
  createGridLayoutSlide(
    presentation,
    'Key Features',
    [
      {title: 'Fast', icon: '⚡', description: 'Lightning fast performance'},
      {title: 'Secure', icon: '🔒', description: 'Enterprise-grade security'},
      {title: 'Scalable', icon: '📈', description: 'Grows with your needs'},
      {title: 'Reliable', icon: '✅', description: '99.9% uptime guarantee'},
      {title: 'Support', icon: '💬', description: '24/7 customer support'},
      {title: 'Analytics', icon: '📊', description: 'Real-time insights'}
    ]
  );

  // 比較スライド
  createComparisonSlide(
    presentation,
    'Solution Comparison',
    {
      title: 'Option A',
      pros: ['Lower initial cost', 'Quick setup', 'Easy to use'],
      cons: ['Limited features', 'Less scalable']
    },
    {
      title: 'Option B',
      pros: ['Full featured', 'Highly scalable', 'Better performance'],
      cons: ['Higher cost', 'Longer setup time']
    }
  );

  // 引用スライド
  createQuoteSlide(
    presentation,
    'Design is not just what it looks like and feels like. Design is how it works.',
    'Steve Jobs',
    'Apple Inc.'
  );

  Logger.log('高度なプレゼンテーションが作成されました: ' + presentation.getUrl());
  return presentation;
}