import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/presentation/home/viewmodels/prediction_viewmodel.dart';
import 'package:hackathon2_app/utils/color.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '予測来場者数',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(labels.length, (i) {
                    final hour = 14 + i; // 14..23
                    final isCurrent = currentHour == hour;
                    final value = values[i];

                    // 固定スケール（最大値での正規化はしない）
                    const maxBarHeight = 200.0; // ラベル分を確保した最大値
                    const maxPeople = 60.0; // 60人で満タン
                    final pxPerPerson = maxBarHeight / maxPeople; // 60人 → 200px

                    double barHeight = value * pxPerPerson;

                    // 上限を超えないようにクランプ
                    if (barHeight > maxBarHeight) {
                      barHeight = maxBarHeight;
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
                                    isCurrent
                                        ? AppColor.primaryPurple
                                        : AppColor.blue,
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
            ),
          ),
        ],
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
