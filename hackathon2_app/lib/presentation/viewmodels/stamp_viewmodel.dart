import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/stamp_data.dart';
import '../../domain/services/stamp_service.dart';
import '../../data/repositories/stamp_repository.dart';
import '../../data/repositories/hive_stamp_repository.dart';
import '../../data/repositories/location_repository.dart';
import '../../data/repositories/geolocator_location_repository.dart';

part 'stamp_viewmodel.g.dart';
part 'stamp_viewmodel.freezed.dart';

@freezed
class StampState with _$StampState {
  const factory StampState({
    @Default([]) List<StampData> stamps,
    @Default(false) bool isLoading,
    @Default(false) bool canStampAtCurrentLocation,
    String? error,
  }) = _StampState;
}

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
  final stampRepo = ref.watch(stampRepositoryProvider);
  final locationRepo = ref.watch(locationRepositoryProvider);
  return StampService(stampRepo, locationRepo);
}

@riverpod
class StampNotifier extends _$StampNotifier {
  @override
  Future<StampState> build() async {
    await _initializeRepositories();
    return await _loadStamps();
  }

  Future<void> _initializeRepositories() async {
    final stampRepo = ref.read(stampRepositoryProvider);
    if (stampRepo is HiveStampRepository) {
      await stampRepo.init();
    }
  }

  Future<StampState> _loadStamps() async {
    try {
      final service = ref.read(stampServiceProvider);
      final stamps = await service.getAllStamps();
      final canStamp = await service.canStampAtCurrentLocation();
      
      return StampState(
        stamps: stamps,
        canStampAtCurrentLocation: canStamp,
        isLoading: false,
      );
    } catch (e) {
      return StampState(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> stampAtIndex(int index) async {
    state = AsyncData(state.value!.copyWith(isLoading: true));
    
    try {
      final service = ref.read(stampServiceProvider);
      final success = await service.stampAtIndex(index);
      
      if (success) {
        // Reload stamps after successful stamp
        final newState = await _loadStamps();
        state = AsyncData(newState);
      } else {
        state = AsyncData(state.value!.copyWith(
          isLoading: false,
          error: '範囲外のため、スタンプを押すことができません',
        ));
      }
    } catch (e) {
      state = AsyncData(state.value!.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> checkLocationPermission() async {
    final newState = await _loadStamps();
    state = AsyncData(newState);
  }
}