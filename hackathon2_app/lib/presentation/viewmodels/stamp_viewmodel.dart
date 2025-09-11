import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/stamp_data.dart';
import '../../domain/services/stamp_service.dart';
import '../../data/repositories/stamp_repository.dart';
import '../../data/repositories/hive_stamp_repository.dart';
import '../../data/repositories/location_repository.dart';
import '../../data/repositories/geolocator_location_repository.dart';

part 'stamp_viewmodel.g.dart';

@riverpod
StampRepository stampRepository(StampRepositoryRef ref) {
  return HiveStampRepository();
}

@riverpod
LocationRepository locationRepository(LocationRepositoryRef ref) {
  return GeolocatorLocationRepository();
}

@riverpod
StampService stampService(StampServiceRef ref) {
  return StampService(
    ref.watch(stampRepositoryProvider),
    ref.watch(locationRepositoryProvider),
  );
}

@riverpod
class StampViewModel extends _$StampViewModel {
  @override
  Future<StampViewState> build() async {
    final service = ref.watch(stampServiceProvider);
    await service.initializeStamps();
    final stamps = await service.getStamps();
    final canStamp = await service.canStampAtCurrentLocation();
    
    return StampViewState(
      stamps: stamps,
      canStampAtCurrentLocation: canStamp,
      isLoading: false,
    );
  }

  Future<void> stampAtIndex(int index) async {
    state = const AsyncValue.loading();
    
    final service = ref.read(stampServiceProvider);
    final success = await service.stampAtIndex(index);
    
    if (success) {
      final stamps = await service.getStamps();
      final canStamp = await service.canStampAtCurrentLocation();
      
      state = AsyncValue.data(StampViewState(
        stamps: stamps,
        canStampAtCurrentLocation: canStamp,
        isLoading: false,
      ));
    } else {
      // Reload current state if stamping failed
      final stamps = await service.getStamps();
      final canStamp = await service.canStampAtCurrentLocation();
      
      state = AsyncValue.data(StampViewState(
        stamps: stamps,
        canStampAtCurrentLocation: canStamp,
        isLoading: false,
      ));
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    
    final service = ref.read(stampServiceProvider);
    final stamps = await service.getStamps();
    final canStamp = await service.canStampAtCurrentLocation();
    
    state = AsyncValue.data(StampViewState(
      stamps: stamps,
      canStampAtCurrentLocation: canStamp,
      isLoading: false,
    ));
  }
}

class StampViewState {
  final List<StampData> stamps;
  final bool canStampAtCurrentLocation;
  final bool isLoading;

  const StampViewState({
    required this.stamps,
    required this.canStampAtCurrentLocation,
    required this.isLoading,
  });

  int get stampedCount => stamps.where((stamp) => stamp.isStamped).length;
  int get totalCount => stamps.length;
}