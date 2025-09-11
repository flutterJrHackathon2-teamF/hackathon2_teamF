import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/utils/color.dart';
import '../../viewmodels/stamp_viewmodel.dart';

class HomeScreenButtons extends ConsumerWidget {
  const HomeScreenButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canStamp = ref.watch(locationAllowsStampingProvider);
    final isLocationAllowed = canStamp.valueOrNull ?? false;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Button(
            color: isLocationAllowed ? AppColor.primaryRed : AppColor.primaryGray,
            text: 'スタンプ\nゲット！',
            onPressed: isLocationAllowed ? () {} : null,
          ),
          _Button(
            color: isLocationAllowed ? AppColor.blue : AppColor.primaryGray,
            text: 'スタンプを\n交換する',
            onPressed: isLocationAllowed ? () {} : null,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;

  const _Button({
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(150, 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: AppColor.white),
      ),
    );
  }
}
