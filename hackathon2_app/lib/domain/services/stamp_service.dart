import '../../data/models/stamp_data.dart';
import '../../data/repositories/stamp_repository.dart';
import '../../data/repositories/location_repository.dart';

class StampService {
  final StampRepository _stampRepository;
  final LocationRepository _locationRepository;

  // Target location coordinates
  static const LocationData _targetLocation = LocationData(
    latitude: 34.809221021392105,
    longitude: 135.4445460077161,
  );
  static const double _rangeInMeters = 50.0;

  StampService({
    required StampRepository stampRepository,
    required LocationRepository locationRepository,
  })  : _stampRepository = stampRepository,
        _locationRepository = locationRepository;

  Future<StampData> getInitialStampData() async {
    final existingData = await _stampRepository.getStampData();
    
    if (existingData != null) {
      return existingData;
    }

    // Create initial data with 10 empty stamps
    final initialData = StampData(
      stampStatus: List.generate(10, (index) => false),
      totalStamps: 10,
      lastUpdated: DateTime.now(),
    );

    await _stampRepository.saveStampData(initialData);
    return initialData;
  }

  Future<bool> canStampAtLocation() async {
    try {
      return await _locationRepository.isWithinRange(
        _targetLocation,
        _rangeInMeters,
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> attemptStamp(int stampIndex) async {
    try {
      // Check if location allows stamping
      final canStamp = await canStampAtLocation();
      if (!canStamp) return false;

      // Get current data
      final currentData = await _stampRepository.getStampData();
      if (currentData == null) return false;

      // Check if stamp is already stamped
      if (stampIndex >= currentData.stampStatus.length) return false;
      if (currentData.stampStatus[stampIndex]) return false;

      // Update stamp status
      await _stampRepository.updateStampStatus(stampIndex, true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> getStampedCount() async {
    final data = await _stampRepository.getStampData();
    if (data == null) return 0;
    
    return data.stampStatus.where((isStamped) => isStamped).length;
  }

  Future<void> resetAllStamps() async {
    final initialData = StampData(
      stampStatus: List.generate(10, (index) => false),
      totalStamps: 10,
      lastUpdated: DateTime.now(),
    );
    
    await _stampRepository.saveStampData(initialData);
  }
}