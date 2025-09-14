import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/utils/color.dart';
import 'package:hackathon2_app/presentation/home/viewmodels/prediction_viewmodel.dart';

class HourlyBarChart extends ConsumerWidget {
  const HourlyBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final currentHour = now.hour; // 0-23
    final labels = List<String>.generate(10, (i) => '${14 + i}:00~');

    final predictionAsyncValue = ref.watch(predictionViewModelProvider);

    return predictionAsyncValue.when(
      data: (data) {
        if (data == null || data.isEmpty) {
          return _buildErrorMessage('予測データが取得できませんでした');
        }
        final values = data.map((prediction) => prediction.visitors).toList();
        return _buildChart(values, labels, currentHour);
      },
      loading: () => _buildLoadingMessage(),
      error: (_, __) => _buildErrorMessage('予測データの取得に失敗しました'),
    );
  }

  Widget _buildChart(
    List<double> values,
    List<String> labels,
    int currentHour,
  ) {
    return Container(
      color: const Color(0xFFEFF5F8),
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 240,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(labels.length, (i) {
            final hour = 14 + i; // 14..23
            final isCurrent = currentHour == hour;
            final value = values[i];

            // 最大高さをベースにスケールするが、
            // 現在の時間帯の棒だけは高さを少し余裕をもって調整する
            final maxBarHeight = 200.0; // ラベル分を確保した最大値
            final maxValue = values.reduce((a, b) => a > b ? a : b);

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
                  Text('${value.toInt()}人'),
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
                  Text(labels[i], style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingMessage() {
    return Container(
      color: const Color(0xFFEFF5F8),
      height: 240,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      color: const Color(0xFFEFF5F8),
      height: 240,
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
