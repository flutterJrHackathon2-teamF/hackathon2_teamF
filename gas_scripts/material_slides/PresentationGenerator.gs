/**
 * Hackathon2 Team F 発表用スライド生成（10分間版）
 */

function createHackathonPresentation() {
  const presentation = createMaterialPresentation('Hackathon2 Team F - リアルタイム来場者予測アプリ');

  // スライド1: タイトル
  createTitleSlide(
    presentation,
    'Hackathon2 Team F',
    'リアルタイム来場者予測・カウントアプリ',
    'Material Design 3 Expressive × Supabase'
  );

  // スライド2: プロジェクト概要
  createContentSlide(
    presentation,
    'プロジェクト概要',
    [
      'リアルタイム来場者数の予測と追跡',
      'Supabaseによるリアルタイムデータ同期',
      'Material Design 3 Expressiveによる先進的UI',
      'MVVM + Repositoryパターンによる堅牢な設計',
      'Twitter統合による情報発信'
    ]
  );

  // スライド3: 主な機能
  createTwoColumnSlide(
    presentation,
    '主な機能',
    [
      'コア機能:',
      '👥 リアルタイム来場者カウント',
      '📈 AI来場者数予測',
      '🔄 Supabaseリアルタイム同期',
      '📊 時間別データチャート',
      '🐦 Twitter統合'
    ],
    [
      'UI/UX:',
      '🎨 Material Design 3 Expressive',
      '🌊 LinearWavyProgressIndicator',
      '⚡ カスタムアニメーション',
      '📱 レスポンシブデザイン',
      '🎯 直感的な操作性'
    ]
  );

  // スライド4: MVVM + Repository アーキテクチャ
  const archSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  archSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const archTitle = archSlide.insertTextBox('MVVM + Repository パターン', 50, 20, 620, 40);
  const archTitleStyle = archTitle.getText().getTextStyle();
  archTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  archTitleStyle.setFontSize(28);
  archTitleStyle.setFontFamily('Google Sans');
  archTitleStyle.setBold(true);

  // アーキテクチャ図
  addMaterialCard(
    archSlide,
    50, 70, 620, 80,
    'View Layer (Widgets)',
    'Material Design 3 • WebView • カスタムアニメーション'
  );

  const arrow1 = archSlide.insertTextBox('↕', 350, 155, 20, 20);
  arrow1.getText().getTextStyle().setFontSize(20);

  addMaterialCard(
    archSlide,
    50, 180, 620, 80,
    'ViewModel Layer (Riverpod)',
    '状態管理 • ビジネスロジック • データ変換'
  );

  const arrow2 = archSlide.insertTextBox('↓', 350, 265, 20, 20);
  arrow2.getText().getTextStyle().setFontSize(20);

  addMaterialCard(
    archSlide,
    50, 290, 620, 80,
    'Repository Layer',
    'データ抽象化 • キャッシュ管理 • API/DB切り替え'
  );

  const arrow3 = archSlide.insertTextBox('↓', 350, 375, 20, 20);
  arrow3.getText().getTextStyle().setFontSize(20);

  addMaterialCard(
    archSlide,
    50, 400, 620, 80,
    'Data Sources',
    'Supabase Realtime • Hive Local DB • Location API'
  );

  // スライド5: 技術スタック
  const techSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  techSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const techTitle = techSlide.insertTextBox('技術スタック', 50, 20, 620, 40);
  const techTitleStyle = techTitle.getText().getTextStyle();
  techTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  techTitleStyle.setFontSize(28);
  techTitleStyle.setFontFamily('Google Sans');
  techTitleStyle.setBold(true);

  // 技術スタックをグリッド表示（サイズ調整）
  const techs = [
    ['Flutter 3.7.2+', '📱 クロスプラットフォーム'],
    ['Supabase', '☁️ リアルタイムBaaS'],
    ['Riverpod 2.4.9', '🔄 状態管理'],
    ['Hive 2.2.3', '💾 ローカルDB'],
    ['GoRouter 14.6.2', '🧭 ナビゲーション'],
    ['Material 3', '🎨 Expressive UI']
  ];

  techs.forEach((tech, index) => {
    const row = Math.floor(index / 2);
    const col = index % 2;
    const x = 60 + (col * 310);
    const y = 80 + (row * 110);

    addMaterialCard(
      techSlide,
      x, y, 280, 90,
      tech[0],
      tech[1]
    );
  });

  // スライド6: Material Design 3 Expressive の実装
  createContentSlide(
    presentation,
    'Material Design 3 Expressive',
    [
      'ExperimentalMaterial3ExpressiveAPI を活用',
      'MaterialExpressiveTheme でテーマ統一',
      'LinearWavyProgressIndicator でユニークなアニメーション',
      'AndroidView + Jetpack Compose でネイティブ実装',
      'iOS/Web フォールバック対応で全プラットフォーム対応'
    ]
  );

  // スライド7: 実装のポイント
  createTwoColumnSlide(
    presentation,
    '技術的挑戦と学び',
    [
      '技術的挑戦:',
      'AndroidView統合によるネイティブUI実装',
      'WebViewスクロール競合の解決',
      'Riverpodによる複雑な状態管理',
      'Freezed + Hiveでのデータ永続化',
      'Material 3 Expressiveの先行採用'
    ],
    [
      '学んだこと:',
      'レイヤードアーキテクチャの重要性',
      'プラットフォーム固有実装の価値',
      'コンポーネント設計の効果',
      '新技術の早期採用のメリット',
      'チーム開発でのコード品質管理'
    ]
  );

  // スライド8: ディレクトリ構成の工夫
  const dirSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  dirSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const dirTitle = dirSlide.insertTextBox('ディレクトリ構成の工夫', 50, 30, 620, 50);
  const dirTitleStyle = dirTitle.getText().getTextStyle();
  dirTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  dirTitleStyle.setFontSize(32);
  dirTitleStyle.setFontFamily('Google Sans');
  dirTitleStyle.setBold(true);

  const dirText = dirSlide.insertTextBox(
    `lib/
├── presentation/     # UI層 - 画面とViewModelを分離
├── domain/          # ドメイン層 - ビジネスロジック
├── data/           # データ層 - モデルとリポジトリ
├── widgets/        # 共通ウィジェット
├── utils/          # ユーティリティ
└── gen/           # 自動生成ファイル

コンポーネントベース設計で再利用性とメンテナンス性を向上`,
    50, 90, 620, 350
  );
  const dirTextStyle = dirText.getText().getTextStyle();
  dirTextStyle.setForegroundColor(MATERIAL_COLORS.onSurfaceVariant);
  dirTextStyle.setFontSize(16);
  dirTextStyle.setFontFamily('Roboto Mono');

  // スライド9: 感想
  const impressionSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  impressionSlide.getBackground().setSolidFill(MATERIAL_COLORS.tertiaryContainer);

  const impressionTitle = impressionSlide.insertTextBox('振り返りと感想', 50, 50, 620, 50);
  const impressionTitleStyle = impressionTitle.getText().getTextStyle();
  impressionTitleStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  impressionTitleStyle.setFontSize(32);
  impressionTitleStyle.setFontFamily('Google Sans');
  impressionTitleStyle.setBold(true);

  const impressionText = impressionSlide.insertTextBox(
    'ハッカソンを通じて、最新技術の早期採用と、きちんとしたアーキテクチャ設計の両立の重要性を学びました。\n\nMaterial Design 3 Expressiveという実験的なAPIも、適切な設計によって安全に活用できることを実感しました。',
    50, 120, 620, 200
  );
  const impressionTextStyle = impressionText.getText().getTextStyle();
  impressionTextStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  impressionTextStyle.setFontSize(20);
  impressionTextStyle.setFontFamily('Google Sans');
  impressionTextStyle.setItalic(true);

  const authorText = impressionSlide.insertTextBox(
    '— Team F 一同',
    50, 350, 620, 40
  );
  const authorTextStyle = authorText.getText().getTextStyle();
  authorTextStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  authorTextStyle.setFontSize(18);
  authorTextStyle.setFontFamily('Google Sans');
  const authorParagraph = authorText.getText().getParagraphStyle();
  authorParagraph.setParagraphAlignment(SlidesApp.ParagraphAlignment.END);

  // スライド10: まとめ
  createContentSlide(
    presentation,
    'まとめ',
    [
      '✅ レイヤードアーキテクチャによる保守性の向上',
      '✅ Material Design 3 Expressive による差別化',
      '✅ プラットフォーム固有実装とフォールバックの両立',
      '✅ チーム開発での技術選定とコード品質管理',
      '🚀 今後も新技術の積極的な活用を継続していきます！'
    ]
  );

  // 最終スライド: 質疑応答
  createSectionHeaderSlide(presentation, 'ご質問・ご意見をお聞かせください');

  Logger.log('発表用プレゼンテーションが作成されました: ' + presentation.getUrl());
  return presentation;
}