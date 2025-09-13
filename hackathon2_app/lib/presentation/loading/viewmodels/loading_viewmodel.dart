import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/visitor_repository.dart';

part 'loading_viewmodel.g.dart';

@riverpod
class LoadingViewModel extends _$LoadingViewModel {
  @override
  Future<bool> build() async {
    // データの事前取得を実行
    await _preloadData();
    return true;
  }

  Future<void> _preloadData() async {
    try {
      final repository = ref.read(visitorRepositoryProvider);

      // 訪問者データを事前取得してキャッシュに保存
      await repository.getLatestVisitorData();

      // 追加で必要なデータがあればここで取得
      // 例：スタンプデータ、その他の初期化データなど
    } catch (e) {
      // エラーが発生してもローディング画面は進む
      // 実際のデータ表示時にエラーハンドリングを行う
    }
  }

  Future<void> retryPreload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _preloadData();
      return true;
    });
  }
}
