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
    final stampState = ref.watch(stampViewModelProvider);
    
    return stampState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (state) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColor.card, // 背景の緑
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 横に5個
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: state.totalCount,
              itemBuilder: (context, index) {
                final stamp = state.stamps.firstWhere((s) => s.id == index);
                final isStamped = stamp.isStamped;
                final canStamp = state.canStampAtCurrentLocation;
                
                return GestureDetector(
                  onTap: () async {
                    if (!isStamped && canStamp) {
                      await ref.read(stampViewModelProvider.notifier).stampAtIndex(index);
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: isStamped
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Assets.images.yu.image(fit: BoxFit.contain),
                          )
                        : canStamp
                            ? const Icon(Icons.circle_outlined, color: Colors.grey)
                            : const Icon(Icons.circle_outlined, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Gap(2),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(' ${state.stampedCount} / ${state.totalCount}', 
                       style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
