import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/visitor_prediction.dart';
import '../../../domain/services/prediction_service.dart';
import '../../../data/repositories/prediction_repository.dart';

part 'prediction_viewmodel.g.dart';

@riverpod
class PredictionViewModel extends _$PredictionViewModel {
  @override
  Future<List<VisitorPrediction>?> build() async {
    final repository = ref.watch(predictionRepositoryProvider);
    return await repository.getPredictionData();
  }

  Future<void> refreshPredictionData() async {
    final repository = ref.read(predictionRepositoryProvider);
    repository.clearCache();
    ref.invalidateSelf();
  }

  List<double> getHourlyValues() {
    final asyncValue = ref.read(predictionViewModelProvider);
    return asyncValue.when(
      data: (data) {
        if (data == null || data.isEmpty) {
          return _getMockData();
        }
        return data.map((prediction) => prediction.visitors).toList();
      },
      loading: () => _getMockData(),
      error: (_, __) => _getMockData(),
    );
  }

  List<double> _getMockData() {
    return [12.0, 20.0, 16.0, 18.0, 15.0, 50.0, 22.0, 5.0, 8.0, 12.0];
  }
}
