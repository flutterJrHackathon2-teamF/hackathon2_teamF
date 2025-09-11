import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// スタンプアニメーションの状態を管理するHook
class StampAnimationState {
  final AnimationController scaleController;
  final AnimationController rotationController;
  final AnimationController fadeController;
  final AnimationController particleController;
  final AnimationController glowController;
  
  final Animation<double> scaleAnimation;
  final Animation<double> rotationAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> particleAnimation;
  final Animation<double> glowAnimation;

  StampAnimationState({
    required this.scaleController,
    required this.rotationController,
    required this.fadeController,
    required this.particleController,
    required this.glowController,
    required this.scaleAnimation,
    required this.rotationAnimation,
    required this.fadeAnimation,
    required this.particleAnimation,
    required this.glowAnimation,
  });

  /// すべてのアニメーションを開始
  void startAnimation() {
    scaleController.forward();
    rotationController.forward();
    fadeController.forward();
    particleController.forward();
    glowController.forward();
  }

  /// すべてのアニメーションをリセット
  void resetAnimation() {
    scaleController.reset();
    rotationController.reset();
    fadeController.reset();
    particleController.reset();
    glowController.reset();
  }
}

/// スタンプアニメーションを管理するカスタムHook
StampAnimationState useStampAnimation({
  Duration duration = const Duration(milliseconds: 1200),
}) {
  // 各アニメーションコントローラーを作成
  final scaleController = useAnimationController(duration: duration);
  final rotationController = useAnimationController(duration: duration);
  final fadeController = useAnimationController(
    duration: Duration(milliseconds: (duration.inMilliseconds * 0.6).round()),
  );
  final particleController = useAnimationController(duration: duration);
  final glowController = useAnimationController(
    duration: Duration(milliseconds: (duration.inMilliseconds * 0.8).round()),
  );

  // アニメーションを作成
  final scaleAnimation = useMemoized(
    () => Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.elasticOut,
    )),
    [scaleController],
  );

  final rotationAnimation = useMemoized(
    () => Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: rotationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    )),
    [rotationController],
  );

  final fadeAnimation = useMemoized(
    () => Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeInOut,
    )),
    [fadeController],
  );

  final particleAnimation = useMemoized(
    () => Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: particleController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    )),
    [particleController],
  );

  final glowAnimation = useMemoized(
    () => Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: glowController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
    )),
    [glowController],
  );

  return StampAnimationState(
    scaleController: scaleController,
    rotationController: rotationController,
    fadeController: fadeController,
    particleController: particleController,
    glowController: glowController,
    scaleAnimation: scaleAnimation,
    rotationAnimation: rotationAnimation,
    fadeAnimation: fadeAnimation,
    particleAnimation: particleAnimation,
    glowAnimation: glowAnimation,
  );
}

/// パーティクル効果のコンポーネント
class ParticleEffect extends StatelessWidget {
  final Animation<double> animation;
  final Color color;
  final double size;

  const ParticleEffect({
    super.key,
    required this.animation,
    this.color = Colors.orange,
    this.size = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: List.generate(8, (index) {
              final angle = (index * 45) * (3.14159 / 180);
              final distance = animation.value * 20;
              final x = distance * (0.7 + 0.3 * animation.value) * 
                       (index.isEven ? 1 : -1) * 
                       (index % 4 < 2 ? 1 : -1);
              final y = distance * (0.7 + 0.3 * animation.value) * 
                       (index < 4 ? -1 : 1);
              
              return Positioned(
                left: size / 2 + x,
                top: size / 2 + y,
                child: Opacity(
                  opacity: (1.0 - animation.value).clamp(0.0, 1.0),
                  child: Container(
                    width: 4 - (2 * animation.value),
                    height: 4 - (2 * animation.value),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

/// 発光エフェクトのコンポーネント
class GlowEffect extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  final Color glowColor;

  const GlowEffect({
    super.key,
    required this.animation,
    required this.child,
    this.glowColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: glowColor.withOpacity(0.3 * animation.value),
                blurRadius: 10 * animation.value,
                spreadRadius: 2 * animation.value,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

/// アニメーション付きスタンプコンテナ
class AnimatedStampContainer extends HookWidget {
  final Widget child;
  final bool isAnimating;
  final VoidCallback? onAnimationComplete;
  final Duration duration;

  const AnimatedStampContainer({
    super.key,
    required this.child,
    required this.isAnimating,
    this.onAnimationComplete,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  Widget build(BuildContext context) {
    final animationState = useStampAnimation(duration: duration);
    
    useEffect(() {
      if (isAnimating) {
        animationState.startAnimation();
        
        // アニメーション完了時のコールバック
        if (onAnimationComplete != null) {
          Future.delayed(duration, onAnimationComplete!);
        }
      } else {
        animationState.resetAnimation();
      }
      return null;
    }, [isAnimating]);

    return AnimatedBuilder(
      animation: Listenable.merge([
        animationState.scaleAnimation,
        animationState.rotationAnimation,
        animationState.fadeAnimation,
        animationState.particleAnimation,
        animationState.glowAnimation,
      ]),
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // パーティクル効果
            ParticleEffect(
              animation: animationState.particleAnimation,
              color: Colors.orange,
              size: 60,
            ),
            
            // 発光エフェクト付きのメインコンテンツ
            GlowEffect(
              animation: animationState.glowAnimation,
              glowColor: Colors.orange,
              child: Transform.scale(
                scale: animationState.scaleAnimation.value,
                child: Transform.rotate(
                  angle: animationState.rotationAnimation.value,
                  child: Opacity(
                    opacity: animationState.fadeAnimation.value,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}