import 'package:geolocator/geolocator.dart';
import '../models/stamp_data.dart';

abstract class LocationRepository {
  Future<bool> isLocationPermissionGranted();
  Future<void> requestLocationPermission();
  Future<LocationData?> getCurrentLocation();
  Future<bool> isWithinRange(LocationData targetLocation, double rangeInMeters);
}

class GeolocatorLocationRepository implements LocationRepository {
  @override
  Future<bool> isLocationPermissionGranted() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
           permission == LocationPermission.whileInUse;
  }

  @override
  Future<void> requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      if (!await isLocationPermissionGranted()) {
        await requestLocationPermission();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> isWithinRange(LocationData targetLocation, double rangeInMeters) async {
    final currentLocation = await getCurrentLocation();
    if (currentLocation == null) return false;

    final distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      targetLocation.latitude,
      targetLocation.longitude,
    );

    return distance <= rangeInMeters;
  }
}