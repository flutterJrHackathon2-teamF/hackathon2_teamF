import 'package:flutter/material.dart';
import 'package:hackathon2_app/utils/color.dart';

class HomeScreenButtons extends StatelessWidget {
  const HomeScreenButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Button(
            color: AppColor.primaryRed,
            text: 'スタンプ\nゲット！',
            onPressed: () {},
          ),
          _Button(color: AppColor.blue, text: 'スタンプを\n交換する', onPressed: () {}),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

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
