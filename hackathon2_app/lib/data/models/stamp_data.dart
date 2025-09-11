import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_data.freezed.dart';
part 'stamp_data.g.dart';

@freezed
@HiveType(typeId: 0)
class StampData with _$StampData {
  const factory StampData({
    @HiveField(0) required int id,
    @HiveField(1) required bool isStamped,
    @HiveField(2) required DateTime? stampedAt,
  }) = _StampData;

  factory StampData.fromJson(Map<String, dynamic> json) => _$StampDataFromJson(json);
}