import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_data.freezed.dart';
part 'location_data.g.dart';

@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    required double latitude,
    required double longitude,
    required double accuracy,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);
}