import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/visitor_data.dart';
import '../../../domain/services/visitor_service.dart';
import '../../../data/repositories/visitor_repository.dart';

part 'visitor_viewmodel.g.dart';

@Riverpod(keepAlive: true)
VisitorService visitorService(Ref ref) {
  return VisitorService(Supabase.instance.client);
}

@riverpod
class VisitorViewModel extends _$VisitorViewModel {
  @override
  Future<VisitorData?> build() async {
    final repository = ref.watch(visitorRepositoryProvider);
    return await repository.getLatestVisitorData();
  }

  Future<void> refreshVisitorData() async {
    final repository = ref.read(visitorRepositoryProvider);
    repository.clearCache();
    ref.invalidateSelf();
  }

  String getVisitorStatusMessage(int visitorCount) {
    final repository = ref.read(visitorRepositoryProvider);
    return repository.getVisitorStatusMessage(visitorCount);
  }
}

@riverpod
Future<int> latestVisitorCount(Ref ref) async {
  final repository = ref.watch(visitorRepositoryProvider);
  final data = await repository.getLatestVisitorData();
  return data?.visitors ?? 0;
}
