import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../presentation/viewmodels/stamp_viewmodel.dart';

class StampCard extends ConsumerWidget {
  const StampCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stampData = ref.watch(stampViewModelProvider);
    final canStamp = ref.watch(locationAllowsStampingProvider);

    return stampData.when(
      data: (data) => _buildStampGrid(context, ref, data, canStamp),
      loading: () => _buildLoadingState(),
      error: (error, _) => _buildErrorState(error),
    );
  }

  Widget _buildStampGrid(BuildContext context, WidgetRef ref, data, AsyncValue<bool> canStamp) {
    final stampedCount = data.stampStatus.where((isStamped) => isStamped).length;
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

              return GestureDetector(
                onTap: canTapStamp ? () => _onStampTap(ref, index) : null,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isStamped 
                        ? Colors.white 
                        : (canTapStamp ? Colors.white : Colors.grey.shade300),
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
              );
            },
          ),
        ),
        Gap(2),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(' $stampedCount / ${data.totalStamps}', 
                     style: TextStyle(fontSize: 20)),
        ),
        if (!isLocationAllowed)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '指定エリア内でスタンプを押せます',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.card,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColor.card,
      child: Center(
        child: Text(
          'エラーが発生しました: $error',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Future<void> _onStampTap(WidgetRef ref, int index) async {
    final success = await ref.read(stampViewModelProvider.notifier).attemptStamp(index);
    
    if (!success) {
      // Could show a snackbar or toast here for failed attempts
      print('スタンプの押下に失敗しました');
    }
  }
}
