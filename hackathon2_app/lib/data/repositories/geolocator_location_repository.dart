import 'package:geolocator/geolocator.dart';
import '../models/location_data.dart';
import 'location_repository.dart';

class GeolocatorLocationRepository implements LocationRepository {
  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isLocationPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestLocationPermission() async {
    if (await isLocationPermissionGranted()) {
      return true;
    }

    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}