// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitorPredictionImpl _$$VisitorPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$VisitorPredictionImpl(
      hour: (json['hour'] as num).toInt(),
      time: json['time'] as String,
      visitors: (json['visitors'] as num).toDouble(),
    );

Map<String, dynamic> _$$VisitorPredictionImplToJson(
        _$VisitorPredictionImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'time': instance.time,
      'visitors': instance.visitors,
    };
