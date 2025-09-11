import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';
import '../../viewmodels/stamp_viewmodel.dart';
import '../../../../data/models/stamp_data.dart';
import 'dart:math' as math;

class StampCard extends ConsumerStatefulWidget {
  const StampCard({super.key});

  @override
  ConsumerState<StampCard> createState() => _StampCardState();
}

class _StampCardState extends ConsumerState<StampCard>
    with TickerProviderStateMixin {
  Map<int, AnimationController> _animationControllers = {};
  Map<int, Animation<double>> _scaleAnimations = {};
  Map<int, Animation<double>> _rotationAnimations = {};
  Map<int, Animation<double>> _fadeAnimations = {};
  Map<int, AnimationController> _particleControllers = {};
  Map<int, Animation<double>> _particleAnimations = {};

  @override
  void dispose() {
    _animationControllers.values.forEach((controller) => controller.dispose());
    _particleControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _initializeAnimations(int index) {
    if (!_animationControllers.containsKey(index)) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      
      final particleController = AnimationController(
        duration: const Duration(milliseconds: 1200),
        vsync: this,
      );
      
      _animationControllers[index] = controller;
      _particleControllers[index] = particleController;
      
      _scaleAnimations[index] = Tween<double>(
        begin: 1.0,
        end: 1.3,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));
      
      _rotationAnimations[index] = Tween<double>(
        begin: 0.0,
        end: 0.2,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
      
      _fadeAnimations[index] = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeIn),
      ));
      
      _particleAnimations[index] = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: particleController,
        curve: Curves.easeOut,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final stampData = ref.watch(stampViewModelProvider);
    final canStamp = ref.watch(locationAllowsStampingProvider);

    return stampData.when(
      data: (data) => _buildStampGrid(context, ref, data, canStamp),
      loading: () => _buildLoadingState(),
      error: (error, _) => _buildErrorState(error),
    );
  }

  Widget _buildStampGrid(
    BuildContext context,
    WidgetRef ref,
    StampData data,
    AsyncValue<bool> canStamp,
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

              _initializeAnimations(index);
              
              return GestureDetector(
                onTap: canTapStamp ? () => _onStampTap(ref, index) : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _animationControllers[index]!,
                        _particleControllers[index]!,
                      ]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimations[index]!.value,
                          child: Transform.rotate(
                            angle: _rotationAnimations[index]!.value,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isStamped
                                    ? Colors.white
                                    : (isLocationAllowed
                                        ? Colors.white
                                        : AppColor.primaryGray),
                                boxShadow: isStamped
                                    ? [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.3),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: isStamped
                                  ? Opacity(
                                      opacity: _fadeAnimations[index]!.value,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Assets.images.yu.image(fit: BoxFit.contain),
                                      ),
                                    )
                                  : (canTapStamp
                                      ? Icon(Icons.add, color: Colors.grey.shade600)
                                      : Icon(Icons.lock, color: Colors.grey.shade500)),
                            ),
                          ),
                        );
                      },
                    ),
                    if (isStamped)
                      AnimatedBuilder(
                        animation: _particleControllers[index]!,
                        builder: (context, child) {
                          return _buildParticleEffect(index);
                        },
                      ),
                  ],
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

  Widget _buildParticleEffect(int index) {
    final animation = _particleAnimations[index]!;
    if (animation.value == 0.0) return SizedBox.shrink();
    
    return Stack(
      children: List.generate(8, (particleIndex) {
        final angle = (particleIndex * math.pi * 2) / 8;
        final radius = 30 * animation.value;
        final x = math.cos(angle) * radius;
        final y = math.sin(angle) * radius;
        
        return Transform.translate(
          offset: Offset(x, y),
          child: Opacity(
            opacity: (1.0 - animation.value).clamp(0.0, 1.0),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.withOpacity(0.8),
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _onStampTap(WidgetRef ref, int index) async {
    final success = await ref
        .read(stampViewModelProvider.notifier)
        .attemptStamp(index);

    if (success) {
      // スタンプ成功時のアニメーションを開始
      await _animationControllers[index]!.forward();
      _particleControllers[index]!.forward();
      
      // アニメーション完了後にリセット
      await Future.delayed(const Duration(milliseconds: 200));
      _animationControllers[index]!.reset();
      await Future.delayed(const Duration(milliseconds: 1000));
      _particleControllers[index]!.reset();
    } else {
      // Could show a snackbar or toast here for failed attempts
      print('スタンプの押下に失敗しました');
    }
  }
}
