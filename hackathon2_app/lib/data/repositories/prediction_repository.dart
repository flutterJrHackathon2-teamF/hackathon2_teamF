import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/data/models/visitor_prediction.dart';
import 'package:hackathon2_app/domain/services/prediction_service.dart';
import 'package:hackathon2_app/presentation/home/viewmodels/prediction_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prediction_repository.g.dart';

@Riverpod(keepAlive: true)
class PredictionRepositoryCache extends _$PredictionRepositoryCache {
  List<VisitorPrediction>? _cachedData;

  @override
  List<VisitorPrediction>? build() {
    return _cachedData;
  }

  void setCache(List<VisitorPrediction> data) {
    _cachedData = data;
    state = data;
  }

  void clearCache() {
    _cachedData = null;
    state = null;
  }
}

abstract class PredictionRepository {
  Future<List<VisitorPrediction>?> getPredictionData();
  void clearCache();
}

@Riverpod(keepAlive: true)
PredictionRepository predictionRepository(Ref ref) {
  final service = ref.watch(predictionServiceProvider);
  return PredictionRepositoryImpl(ref, service);
}

class PredictionRepositoryImpl implements PredictionRepository {
  final Ref ref;
  final PredictionService _service;

  PredictionRepositoryImpl(this.ref, this._service);

  @override
  Future<List<VisitorPrediction>?> getPredictionData() async {
    if (!_isBusinessHours(DateTime.now())) {
      return null;
    }

    final cachedData = ref.read(predictionRepositoryCacheProvider);
    if (cachedData != null && cachedData.isNotEmpty) {
      return cachedData;
    }

    try {
      final data = await _service.fetchPredictionData();
      if (data.isNotEmpty) {
        ref.read(predictionRepositoryCacheProvider.notifier).setCache(data);
      }
      return data;
    } catch (e) {
      return null;
    }
  }

  @override
  void clearCache() {
    ref.read(predictionRepositoryCacheProvider.notifier).clearCache();
  }

  bool _isBusinessHours(DateTime now) {
    final hour = now.hour;
    return hour >= 14 && hour < 24;
  }
}