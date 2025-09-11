import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/stamp_data.dart';
import '../../../domain/services/stamp_service.dart';
import '../../../data/repositories/stamp_repository.dart';
import '../../../data/repositories/location_repository.dart';

part 'stamp_viewmodel.g.dart';

@Riverpod(keepAlive: true)
StampRepository stampRepository(StampRepositoryRef ref) {
  return HiveStampRepository();
}

@Riverpod(keepAlive: true)
LocationRepository locationRepository(LocationRepositoryRef ref) {
  return GeolocatorLocationRepository();
}

@Riverpod(keepAlive: true)
StampService stampService(StampServiceRef ref) {
  return StampService(
    stampRepository: ref.watch(stampRepositoryProvider),
    locationRepository: ref.watch(locationRepositoryProvider),
  );
}

@riverpod
class StampViewModel extends _$StampViewModel {
  @override
  Future<StampData> build() async {
    final service = ref.watch(stampServiceProvider);
    return await service.getInitialStampData();
  }

  Future<void> refreshStampData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(stampServiceProvider);
      return await service.getInitialStampData();
    });
  }

  Future<bool> canStampAtCurrentLocation() async {
    final service = ref.read(stampServiceProvider);
    return await service.canStampAtLocation();
  }

  Future<bool> attemptStamp(int stampIndex) async {
    final service = ref.read(stampServiceProvider);
    final success = await service.attemptStamp(stampIndex);

    if (success) {
      // Refresh the data after successful stamp
      await refreshStampData();
    }

    return success;
  }

  Future<void> resetAllStamps() async {
    final service = ref.read(stampServiceProvider);
    await service.resetAllStamps();
    await refreshStampData();
  }
}

@riverpod
Future<bool> locationAllowsStamping(LocationAllowsStampingRef ref) async {
  final service = ref.watch(stampServiceProvider);
  return await service.canStampAtLocation();
}
