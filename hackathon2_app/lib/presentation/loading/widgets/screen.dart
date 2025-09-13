import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/m3e_loding.dart';
import '../viewmodels/loading_viewmodel.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _handleDataLoadingAndNavigation();
  }

  Future<void> _handleDataLoadingAndNavigation() async {
    // LoadingViewModelでデータの事前取得を開始
    final loadingState = ref.read(loadingViewModelProvider);

    // データ取得の完了を待つ
    await loadingState.when(
      data: (success) async {
        // データ取得成功時は最低2秒間ローディング画面を表示
        await Future.delayed(const Duration(seconds: 2));
      },
      loading: () async {
        // ローディング中は最大5秒まで待機
        await Future.delayed(const Duration(seconds: 5));
      },
      error: (error, stack) async {
        // エラー時も最低2秒間表示してからホームに遷移
        await Future.delayed(const Duration(seconds: 2));
      },
    );

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(child: ExpressiveLoading(size: 48)),
    );
  }
}
