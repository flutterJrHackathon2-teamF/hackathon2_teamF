import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../providers/stamp_provider.dart';

class StampCard extends ConsumerWidget {
  const StampCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stampStateAsync = ref.watch(stampNotifierProvider);

    return stampStateAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (stampState) {
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
                itemCount: stampState.stampedPositions.length,
                itemBuilder: (context, index) {
                  final isStamped = stampState.stampedPositions[index];
                  
                  return GestureDetector(
                    onTap: () async {
                      await ref.read(stampNotifierProvider.notifier).tryStamp(index);
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
                          : FutureBuilder<bool>(
                              future: ref.read(locationRepositoryProvider).isInStampRange(),
                              builder: (context, snapshot) {
                                final inRange = snapshot.data ?? false;
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: inRange ? Colors.white : Colors.grey.withOpacity(0.5),
                                  ),
                                );
                              },
                            ),
                    ),
                  );
                },
              ),
            ),
            Gap(2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(' ${stampState.totalStamps} / 10', style: const TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }
}
