import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../presentation/viewmodels/stamp_viewmodel.dart';

class StampCard extends ConsumerWidget {
  final int total = 10;

  const StampCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stampState = ref.watch(stampNotifierProvider);

    return stampState.when(
      data: (state) => _buildStampGrid(context, ref, state),
      loading: () => _buildLoadingWidget(),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildStampGrid(BuildContext context, WidgetRef ref, StampState state) {
    final stampedCount = state.stamps.where((stamp) => stamp.isStamped).length;
    
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
            itemCount: total,
            itemBuilder: (context, index) {
              final isStamped = state.stamps.any((stamp) => 
                stamp.id == index && stamp.isStamped);
              final canStamp = state.canStampAtCurrentLocation;
              
              return GestureDetector(
                onTap: () async {
                  if (!isStamped && canStamp) {
                    await ref.read(stampNotifierProvider.notifier).stampAtIndex(index);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: !canStamp && !isStamped 
                        ? Border.all(color: Colors.grey, width: 2)
                        : null,
                  ),
                  child: isStamped
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Assets.images.yu.image(fit: BoxFit.contain),
                        )
                      : !canStamp 
                          ? Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                  Colors.grey,
                                  BlendMode.saturation,
                                ),
                                child: Assets.images.yu.image(
                                  fit: BoxFit.contain,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : null,
                ),
              );
            },
          ),
        ),
        const Gap(2),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(' $stampedCount / $total', style: const TextStyle(fontSize: 20)),
        ),
        if (state.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              state.error!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return const Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          color: AppColor.card,
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Gap(2),
        Text('Loading...', style: TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget _buildErrorWidget(String error) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: AppColor.card,
          height: 200,
          child: Center(
            child: Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Gap(2),
        const Text('Error loading stamps', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
