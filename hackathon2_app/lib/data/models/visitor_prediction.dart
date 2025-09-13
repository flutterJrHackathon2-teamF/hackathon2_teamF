import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor_prediction.freezed.dart';
part 'visitor_prediction.g.dart';

@freezed
class VisitorPrediction with _$VisitorPrediction {
  const factory VisitorPrediction({
    required int hour,
    required String time,
    required double visitors,
  }) = _VisitorPrediction;

  factory VisitorPrediction.fromJson(Map<String, dynamic> json) =>
      _$VisitorPredictionFromJson(json);
}