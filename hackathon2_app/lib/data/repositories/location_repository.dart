import '../models/location_data.dart';

abstract class LocationRepository {
  Future<LocationData?> getCurrentLocation();
  Future<bool> checkLocationPermission();
  Future<bool> requestLocationPermission();
}