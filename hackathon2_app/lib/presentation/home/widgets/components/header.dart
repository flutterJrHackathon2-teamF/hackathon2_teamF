import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/gen/assets.gen.dart';
import 'package:hackathon2_app/presentation/home/viewmodels/visitor_viewmodel.dart';
import 'package:hackathon2_app/utils/color.dart';

class HomeScreenHeader extends ConsumerWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitorState = ref.watch(visitorViewModelProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Assets.images.fuji.image(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.card,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people, color: AppColor.primaryBlack, size: 24),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Text(
                      '現在の訪問者数',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.primaryBlack.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    visitorState.when(
                      data: (data) {
                        // 判定は ViewModel 経由（Repository 側で営業時間外を考慮）
                        final statusMessage = ref
                            .read(visitorViewModelProvider.notifier)
                            .getVisitorStatusMessage((data?.visitors) ?? 0);
                        final isClosed = statusMessage == '営業時間外です';

                        if (isClosed) {
                          // 営業時間外：人数は表示せず、案内のみ
                          return Column(
                            children: [
                              Text(
                                '営業時間外です',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.primaryBlack.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '受付時間 14:00〜24:00',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.primaryBlack.withOpacity(0.6),
                                ),
                              ),
                            ],
                          );
                        }

                        if (data != null) {
                          return Column(
                            children: [
                              Text(
                                '${data.visitors}人',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryBlack,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                statusMessage,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColor.primaryBlack.withOpacity(0.6),
                                ),
                              ),
                            ],
                          );
                        }

                        // 営業時間内でデータがまだ無い場合
                        return Text(
                          '取得中...',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primaryBlack.withOpacity(0.7),
                          ),
                        );
                      },
                      loading:
                          () => Text(
                            '読み込み中...',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primaryBlack.withOpacity(0.7),
                            ),
                          ),
                      error:
                          (error, stack) => Text(
                            'エラー',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
