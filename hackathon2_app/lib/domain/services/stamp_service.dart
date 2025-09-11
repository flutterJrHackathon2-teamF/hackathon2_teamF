import 'dart:math';
import 'package:geolocator/geolocator.dart';
import '../../data/models/location_data.dart';
import '../../data/models/stamp_data.dart';
import '../../data/repositories/location_repository.dart';
import '../../data/repositories/stamp_repository.dart';

class StampService {
  final StampRepository _stampRepository;
  final LocationRepository _locationRepository;
  
  // Target location coordinates as specified in the requirements
  static const double _targetLatitude = 34.809221021392105;
  static const double _targetLongitude = 135.4445460077161;
  static const double _allowedDistanceInMeters = 50.0;

  StampService(this._stampRepository, this._locationRepository);

  Future<List<StampData>> getStamps() async {
    return await _stampRepository.getAllStamps();
  }

  Future<bool> canStampAtCurrentLocation() async {
    final currentLocation = await _locationRepository.getCurrentLocation();
    if (currentLocation == null) return false;

    final distance = _calculateDistance(
      currentLocation.latitude,
      currentLocation.longitude,
      _targetLatitude,
      _targetLongitude,
    );

    return distance <= _allowedDistanceInMeters;
  }

  Future<bool> stampAtIndex(int index) async {
    if (!await canStampAtCurrentLocation()) {
      return false;
    }

    final stamp = StampData(
      id: index,
      isStamped: true,
      stampedAt: DateTime.now(),
    );

    await _stampRepository.saveStamp(stamp);
    return true;
  }

  Future<void> initializeStamps() async {
    final stamps = await _stampRepository.getAllStamps();
    if (stamps.isEmpty) {
      // Initialize with 10 empty stamps
      for (int i = 0; i < 10; i++) {
        final stamp = StampData(
          id: i,
          isStamped: false,
          stampedAt: null,
        );
        await _stampRepository.saveStamp(stamp);
      }
    }
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}