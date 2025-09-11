import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';
import '../../viewmodels/stamp_viewmodel.dart';
import '../../../../data/models/stamp_data.dart';
import 'animation.dart';

class StampCard extends HookConsumerWidget {
  const StampCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stampData = ref.watch(stampViewModelProvider);
    final canStamp = ref.watch(locationAllowsStampingProvider);
    
    // アニメーション状態を管理（各スタンプのインデックスがキー）
    final animatingStamps = useState<Set<int>>({});

    return stampData.when(
      data: (data) => _buildStampGrid(context, ref, data, canStamp, animatingStamps),
      loading: () => _buildLoadingState(),
      error: (error, _) => _buildErrorState(error),
    );
  }

  Widget _buildStampGrid(
    BuildContext context,
    WidgetRef ref,
    StampData data,
    AsyncValue<bool> canStamp,
    ValueNotifier<Set<int>> animatingStamps,
  ) {
    final stampedCount = data.stampedCount;
    final isLocationAllowed = canStamp.valueOrNull ?? false;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: AppColor.card,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: data.totalStamps,
            itemBuilder: (context, index) {
              final isStamped = data.stampStatus[index];
              final canTapStamp = isLocationAllowed && !isStamped;
              final isAnimating = animatingStamps.value.contains(index);

              return GestureDetector(
                onTap: canTapStamp ? () => _onStampTap(ref, index, animatingStamps) : null,
                child: AnimatedStampContainer(
                  isAnimating: isAnimating,
                  onAnimationComplete: () {
                    // アニメーション完了時に状態から除去
                    final newSet = Set<int>.from(animatingStamps.value);
                    newSet.remove(index);
                    animatingStamps.value = newSet;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isStamped
                          ? Colors.white
                          : (isLocationAllowed
                              ? Colors.white
                              : AppColor.primaryGray),
                    ),
                    child: isStamped
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Assets.images.yu.image(fit: BoxFit.contain),
                          )
                        : (canTapStamp
                            ? Icon(Icons.add, color: Colors.grey.shade600)
                            : Icon(Icons.lock, color: Colors.grey.shade500)),
                  ),
                ),
              );
            },
          ),
        ),
        Gap(2),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' $stampedCount / ${data.totalStamps}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        if (!isLocationAllowed)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '指定エリア内でスタンプを押せます',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.card,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.card,
      child: Center(
        child: Text('エラーが発生しました: $error', style: TextStyle(color: Colors.red)),
      ),
    );
  }

  Future<void> _onStampTap(WidgetRef ref, int index, ValueNotifier<Set<int>> animatingStamps) async {
    // アニメーション開始
    final newSet = Set<int>.from(animatingStamps.value);
    newSet.add(index);
    animatingStamps.value = newSet;
    
    final success = await ref
        .read(stampViewModelProvider.notifier)
        .attemptStamp(index);

    if (!success) {
      // アニメーションを停止（失敗時）
      final failedSet = Set<int>.from(animatingStamps.value);
      failedSet.remove(index);
      animatingStamps.value = failedSet;
      
      // Could show a snackbar or toast here for failed attempts
      print('スタンプの押下に失敗しました');
    }
  }
}
