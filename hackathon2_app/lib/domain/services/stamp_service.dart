import 'dart:math';
import 'package:geolocator/geolocator.dart';
import '../../data/models/stamp_data.dart';
import '../../data/models/location_data.dart';
import '../../data/repositories/stamp_repository.dart';
import '../../data/repositories/location_repository.dart';

class StampService {
  final StampRepository _stampRepository;
  final LocationRepository _locationRepository;

  // Target location coordinates from the requirements
  static const double _targetLatitude = 34.809221021392105;
  static const double _targetLongitude = 135.4445460077161;
  static const double _allowedRangeMeters = 50.0;

  StampService(this._stampRepository, this._locationRepository);

  Future<List<StampData>> getAllStamps() async {
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

    return distance <= _allowedRangeMeters;
  }

  Future<bool> stampAtIndex(int index) async {
    final canStamp = await canStampAtCurrentLocation();
    if (!canStamp) return false;

    final stamp = StampData(
      id: index,
      isStamped: true,
      stampedAt: DateTime.now(),
    );

    await _stampRepository.saveStamp(stamp);
    return true;
  }

  Future<int> getStampedCount() async {
    final stamps = await getAllStamps();
    return stamps.where((stamp) => stamp.isStamped).length;
  }

  Future<bool> isStampedAtIndex(int index) async {
    final stamp = await _stampRepository.getStampById(index);
    return stamp?.isStamped ?? false;
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }
}