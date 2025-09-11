import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/stamp_state.dart';
import '../data/repositories/stamp_repository.dart';
import '../data/repositories/location_repository.dart';

part 'stamp_provider.g.dart';

@riverpod
class StampNotifier extends _$StampNotifier {
  late final StampRepository _stampRepository;
  late final LocationRepository _locationRepository;

  @override
  Future<StampState> build() async {
    _stampRepository = StampRepository();
    _locationRepository = LocationRepository();
    await _stampRepository.init();
    return _stampRepository.getStampState();
  }

  Future<void> tryStamp(int position) async {
    final isInRange = await _locationRepository.isInStampRange();
    if (!isInRange) {
      return;
    }

    await _stampRepository.addStamp(position);
    ref.invalidateSelf();
  }

  Future<bool> checkLocationPermission() async {
    return await _locationRepository.isInStampRange();
  }
}

@riverpod
LocationRepository locationRepository(LocationRepositoryRef ref) {
  return LocationRepository();
}