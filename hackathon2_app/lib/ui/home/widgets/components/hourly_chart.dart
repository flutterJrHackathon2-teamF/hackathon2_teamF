// This is a paste-ready widget for your project.
import 'package:flutter/material.dart';
import 'package:hackathon2_app/utils/color.dart';

class HourlyBarChart extends StatelessWidget {
  HourlyBarChart({super.key});

  final List<int> mock = const [
    12,
    20,
    16,
    18,
    15,
    50,
    22,
    5,
    8,
    12,
    10,
  ]; // 14:00..24:00 (11 slots)

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.hour; // 0-23
    final labels = List<String>.generate(11, (i) => '${14 + i}:00~');

    return Container(
      color: const Color(0xFFEFF5F8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 240,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(labels.length, (i) {
            final hour = 14 + i; // 14..24
            final isCurrent = currentHour == hour;
            final value = mock[i].toDouble();

            // 最大高さをベースにスケールするが、
            // 現在の時間帯の棒だけは高さを少し余裕をもって調整する
            final maxBarHeight = 200.0; // ラベル分を確保した最大値
            final maxValue = mock.reduce((a, b) => a > b ? a : b).toDouble();

            double barHeight = (value / maxValue) * maxBarHeight;

            if (isCurrent && barHeight > maxBarHeight * 0.9) {
              // 現在の棒だけは縮めてオーバーフローを防ぐ
              barHeight = maxBarHeight * 0.9;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      width: 24,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color:
                            isCurrent ? AppColor.primaryPurple : AppColor.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[i],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
