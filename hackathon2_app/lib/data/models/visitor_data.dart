import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor_data.freezed.dart';
part 'visitor_data.g.dart';

@freezed
class VisitorData with _$VisitorData {
  const factory VisitorData({
    required int visitors,
    required DateTime slot_5m,
  }) = _VisitorData;

  factory VisitorData.fromJson(Map<String, dynamic> json) =>
      _$VisitorDataFromJson(json);
}
