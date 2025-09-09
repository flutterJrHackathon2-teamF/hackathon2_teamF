import 'package:flutter/material.dart';
import '../../../../utils/color.dart';
import '../../../../gen/assets.gen.dart';

class StampCard extends StatelessWidget {
  final int total = 10;
  final int stamped = 3;

  const StampCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        itemCount: total,
        itemBuilder: (context, index) {
          final isStamped = index < stamped;
          return Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child:
                isStamped
                    ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Assets.images.yu.image(
                        fit: BoxFit.contain,
                      ),
                    )
                    : null,
          );
        },
      ),
    );
  }
}
