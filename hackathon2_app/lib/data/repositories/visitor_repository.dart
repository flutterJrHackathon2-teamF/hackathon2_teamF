import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon2_app/data/models/visitor_data.dart';
import 'package:hackathon2_app/domain/services/visitor_service.dart';
import 'package:hackathon2_app/presentation/home/viewmodels/visitor_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visitor_repository.g.dart';

@Riverpod(keepAlive: true)
class VisitorRepositoryCache extends _$VisitorRepositoryCache {
  VisitorData? _cachedData;

  @override
  VisitorData? build() {
    return _cachedData;
  }

  void setCache(VisitorData data) {
    _cachedData = data;
    state = data;
  }

  void clearCache() {
    _cachedData = null;
    state = null;
  }
}

/// Repository interface (defined locally since no separate file exists)
abstract class VisitorRepository {
  Future<VisitorData?> getLatestVisitorData();
  void clearCache();
  String getVisitorStatusMessage(int visitorCount);
}

@Riverpod(keepAlive: true)
VisitorRepository visitorRepository(Ref ref) {
  final service = ref.watch(visitorServiceProvider);
  return VisitorRepositoryImpl(ref, service);
}

class VisitorRepositoryImpl implements VisitorRepository {
  final Ref ref;
  final VisitorService _service;

  VisitorRepositoryImpl(this.ref, this._service);

  @override
  Future<VisitorData?> getLatestVisitorData() async {
    final cachedData = ref.read(visitorRepositoryCacheProvider);
    if (cachedData != null) {
      return cachedData;
    }

    final data = await _service.fetchLatestVisitorDataFromSupabase();
    if (data != null) {
      ref.read(visitorRepositoryCacheProvider.notifier).setCache(data);
    }
    return data;
  }

  @override
  void clearCache() {
    ref.read(visitorRepositoryCacheProvider.notifier).clearCache();
  }

  @override
  String getVisitorStatusMessage(int visitorCount) {
    if (visitorCount < 50) {
      return "空いています";
    } else if (visitorCount < 100) {
      return "やや混雑しています";
    } else {
      return "混雑しています";
    }
  }
}
