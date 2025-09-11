import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'stamp_data.freezed.dart';
part 'stamp_data.g.dart';

@freezed
class StampData with _$StampData {
  @HiveType(typeId: 0)
  const factory StampData({
    @HiveField(0) required List<bool> stampStatus,
    @HiveField(1) required int totalStamps,
    @HiveField(2) required DateTime lastUpdated,
  }) = _StampData;

  factory StampData.fromJson(Map<String, dynamic> json) =>
      _$StampDataFromJson(json);
}

@freezed
class LocationData with _$LocationData {
  const factory LocationData({
    required double latitude,
    required double longitude,
  }) = _LocationData;

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      _$LocationDataFromJson(json);
}