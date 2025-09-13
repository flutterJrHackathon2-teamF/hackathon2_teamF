/**
 * Hackathon2 Team F 発表用スライド生成（10分間版）
 * リアルタイム来場者予測・カウントアプリ
 */

function createHackathonPresentation10min() {
  const presentation = createMaterialPresentation('Hackathon2 Team F - リアルタイム来場者予測アプリ');

  // スライド1: タイトル
  createTitleSlide(
    presentation,
    'リアルタイム来場者予測システム',
    'AI × Supabase × Flutter',
    'Hackathon2 Team F'
  );

  // スライド2: 課題と解決策
  createTwoColumnSlide(
    presentation,
    '課題と解決策',
    [
      '🔴 課題:',
      '• イベント会場の混雑管理',
      '• 来場者数の予測困難',
      '• リアルタイム情報不足',
      '• 待ち時間の不透明性'
    ],
    [
      '✅ 解決策:',
      '• AI来場者数予測',
      '• リアルタイムカウント',
      '• クラウド同期',
      '• 可視化ダッシュボード'
    ]
  );

  // スライド3: プロジェクト概要
  createContentSlide(
    presentation,
    'システム概要',
    [
      '📊 リアルタイム来場者数の追跡と予測',
      '☁️ Supabase Realtimeによる即時データ同期',
      '🎨 Material Design 3 Expressiveによる先進的UI',
      '🏗️ MVVM + Repositoryパターンによる保守性の高い設計',
      '📱 Flutter によるクロスプラットフォーム対応'
    ]
  );

  // スライド4: 主要機能
  const featuresSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  featuresSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const featuresTitle = featuresSlide.insertTextBox('主要機能', 50, 20, 620, 40);
  const featuresTitleStyle = featuresTitle.getText().getTextStyle();
  featuresTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  featuresTitleStyle.setFontSize(28);
  featuresTitleStyle.setFontFamily('Google Sans');
  featuresTitleStyle.setBold(true);

  // 機能カード
  addMaterialCard(
    featuresSlide,
    50, 70, 300, 90,
    '👥 来場者カウント',
    'リアルタイムで入退場をカウント'
  );

  addMaterialCard(
    featuresSlide,
    370, 70, 300, 90,
    '📈 AI予測',
    '過去データから来場者数を予測'
  );

  addMaterialCard(
    featuresSlide,
    50, 170, 300, 90,
    '🔄 自動同期',
    'Supabaseで複数端末を同期'
  );

  addMaterialCard(
    featuresSlide,
    370, 170, 300, 90,
    '📊 データ可視化',
    '時間別グラフで傾向を表示'
  );

  addMaterialCard(
    featuresSlide,
    50, 270, 300, 90,
    '🐦 SNS連携',
    'Twitter埋め込みで情報発信'
  );

  addMaterialCard(
    featuresSlide,
    370, 270, 300, 90,
    '💾 オフライン対応',
    'Hiveによるローカル永続化'
  );

  // スライド5: MVVM + Repository アーキテクチャ
  const archSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  archSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const archTitle = archSlide.insertTextBox('MVVM + Repository パターン', 50, 20, 620, 40);
  const archTitleStyle = archTitle.getText().getTextStyle();
  archTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  archTitleStyle.setFontSize(28);
  archTitleStyle.setFontFamily('Google Sans');
  archTitleStyle.setBold(true);

  // アーキテクチャ図（コンパクト版）
  const archText = archSlide.insertTextBox(
    'View (UI) ← ViewModel (State) ← Repository ← DataSource',
    50, 70, 620, 30
  );
  archText.getText().getTextStyle().setFontSize(18);
  archText.getText().getParagraphStyle().setParagraphAlignment(SlidesApp.ParagraphAlignment.CENTER);

  addMaterialCard(
    archSlide,
    50, 110, 300, 120,
    'View Layer',
    '• Material Design 3 Widgets\n• カスタムアニメーション\n• WebView統合'
  );

  addMaterialCard(
    archSlide,
    370, 110, 300, 120,
    'ViewModel (Riverpod)',
    '• 状態管理\n• ビジネスロジック\n• データ変換処理'
  );

  addMaterialCard(
    archSlide,
    50, 250, 300, 120,
    'Repository Pattern',
    '• データソース抽象化\n• キャッシュ管理\n• エラーハンドリング'
  );

  addMaterialCard(
    archSlide,
    370, 250, 300, 120,
    'Data Sources',
    '• Supabase Realtime\n• Hive Local DB\n• Location API'
  );

  // スライド6: Supabase統合
  createContentSlide(
    presentation,
    'Supabase Realtime統合',
    [
      '⚡ WebSocketによるリアルタイム通信',
      '🔄 自動的なデータ同期とコンフリクト解決',
      '🔐 Row Level Securityによるセキュアなアクセス制御',
      '📊 PostgreSQLベースの堅牢なデータ管理',
      '🌐 エッジファンクションによるサーバーレス処理'
    ]
  );

  // スライド7: Material Design 3 Expressive
  const m3Slide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  m3Slide.getBackground().setSolidFill(MATERIAL_COLORS.primaryContainer);

  const m3Title = m3Slide.insertTextBox('Material Design 3 Expressive', 50, 20, 620, 40);
  const m3TitleStyle = m3Title.getText().getTextStyle();
  m3TitleStyle.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  m3TitleStyle.setFontSize(28);
  m3TitleStyle.setFontFamily('Google Sans');
  m3TitleStyle.setBold(true);

  const m3Features = m3Slide.insertTextBox(
    '🌊 LinearWavyProgressIndicator\n\n' +
    '✨ ExperimentalMaterial3ExpressiveAPI\n\n' +
    '🎯 AndroidView + Jetpack Compose統合\n\n' +
    '📱 iOS/Web フォールバック対応\n\n' +
    '🎨 MaterialExpressiveTheme',
    50, 80, 620, 300
  );
  const m3FeaturesStyle = m3Features.getText().getTextStyle();
  m3FeaturesStyle.setForegroundColor(MATERIAL_COLORS.onPrimaryContainer);
  m3FeaturesStyle.setFontSize(22);
  m3FeaturesStyle.setFontFamily('Google Sans');

  // スライド8: 技術スタック詳細
  const techDetailSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  techDetailSlide.getBackground().setSolidFill(MATERIAL_COLORS.background);

  const techDetailTitle = techDetailSlide.insertTextBox('技術スタック', 50, 20, 620, 40);
  const techDetailTitleStyle = techDetailTitle.getText().getTextStyle();
  techDetailTitleStyle.setForegroundColor(MATERIAL_COLORS.onSurface);
  techDetailTitleStyle.setFontSize(28);
  techDetailTitleStyle.setFontFamily('Google Sans');
  techDetailTitleStyle.setBold(true);

  // 技術カテゴリー別表示
  addMaterialCard(
    techDetailSlide,
    50, 70, 200, 160,
    'Frontend',
    'Flutter 3.7.2\nDart 3.0\nMaterial Design 3'
  );

  addMaterialCard(
    techDetailSlide,
    260, 70, 200, 160,
    'State & Navigation',
    'Riverpod 2.4.9\nGoRouter 14.6.2\nFreezed'
  );

  addMaterialCard(
    techDetailSlide,
    470, 70, 200, 160,
    'Backend',
    'Supabase\nPostgreSQL\nRealtime'
  );

  addMaterialCard(
    techDetailSlide,
    50, 240, 200, 160,
    'Local Storage',
    'Hive 2.2.3\nShared Preferences'
  );

  addMaterialCard(
    techDetailSlide,
    260, 240, 200, 160,
    'APIs',
    'Geolocator\nWebView\nTwitter Embed'
  );

  addMaterialCard(
    techDetailSlide,
    470, 240, 200, 160,
    'Dev Tools',
    'Build Runner\nLinter\nAnalyzer'
  );

  // スライド9: デモンストレーション
  createSectionHeaderSlide(presentation, 'デモンストレーション');

  // スライド10: 実装の工夫
  createTwoColumnSlide(
    presentation,
    '実装の工夫',
    [
      '🏗️ アーキテクチャ:',
      '• MVVM+Repositoryで責任分離',
      '• DIによる疎結合設計',
      '• テスタブルな構造',
      '• 拡張性の確保'
    ],
    [
      '🎨 UI/UX:',
      '• Material 3 Expressive活用',
      '• スムーズなアニメーション',
      '• 直感的な操作性',
      '• レスポンシブデザイン'
    ]
  );

  // スライド11: 技術的チャレンジ
  createContentSlide(
    presentation,
    '技術的チャレンジと解決',
    [
      '🔧 Supabase Realtimeの同期処理最適化',
      '📱 AndroidViewとFlutterウィジェットの統合',
      '🎯 MVVM実装でのデータフローの整理',
      '⚡ パフォーマンス最適化とメモリ管理',
      '🔄 オフライン時のデータ整合性確保'
    ]
  );

  // スライド12: 今後の展望
  createContentSlide(
    presentation,
    '今後の展望',
    [
      '🤖 機械学習モデルの精度向上',
      '📊 より詳細な分析機能の追加',
      '🌐 多言語対応の実装',
      '🔔 プッシュ通知機能',
      '📱 Apple Watch / Wear OS対応'
    ]
  );

  // スライド13: 学びと感想
  const reflectionSlide = presentation.appendSlide(SlidesApp.PredefinedLayout.BLANK);
  reflectionSlide.getBackground().setSolidFill(MATERIAL_COLORS.tertiaryContainer);

  const reflectionTitle = reflectionSlide.insertTextBox('学びと振り返り', 50, 40, 620, 40);
  const reflectionTitleStyle = reflectionTitle.getText().getTextStyle();
  reflectionTitleStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  reflectionTitleStyle.setFontSize(28);
  reflectionTitleStyle.setFontFamily('Google Sans');
  reflectionTitleStyle.setBold(true);

  const reflectionText = reflectionSlide.insertTextBox(
    '💡 最新技術への挑戦\n' +
    'Material Design 3 Expressiveという実験的APIに挑戦し、\n' +
    '新しいUIパラダイムを実装できました。\n\n' +
    '🏗️ 設計の重要性\n' +
    'MVVM + Repositoryパターンにより、\n' +
    '複雑な機能も整理された形で実装できました。\n\n' +
    '🤝 チーム開発の学び\n' +
    'Supabaseのリアルタイム機能を活用することで、\n' +
    'チーム開発でも効率的にデータを共有できました。',
    50, 100, 620, 280
  );
  const reflectionTextStyle = reflectionText.getText().getTextStyle();
  reflectionTextStyle.setForegroundColor(MATERIAL_COLORS.onTertiaryContainer);
  reflectionTextStyle.setFontSize(18);
  reflectionTextStyle.setFontFamily('Google Sans');

  // スライド14: まとめ
  createContentSlide(
    presentation,
    'まとめ',
    [
      '✅ リアルタイム来場者予測システムの実現',
      '✅ MVVM + Repositoryによる堅牢な設計',
      '✅ Supabase Realtimeでのリアルタイムデータ同期',
      '✅ Material Design 3 Expressiveによる先進的UI',
      '🚀 実用的なソリューションとして展開可能'
    ]
  );

  // スライド15: 質疑応答
  createSectionHeaderSlide(presentation, 'ご質問・ご意見をお待ちしています');

  Logger.log('10分間発表用プレゼンテーションが作成されました: ' + presentation.getUrl());
  return presentation;
}