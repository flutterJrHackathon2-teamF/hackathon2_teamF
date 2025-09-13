// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitorDataImpl _$$VisitorDataImplFromJson(Map<String, dynamic> json) =>
    _$VisitorDataImpl(
      visitors: (json['visitors'] as num).toInt(),
      slot_5m: DateTime.parse(json['slot_5m'] as String),
    );

Map<String, dynamic> _$$VisitorDataImplToJson(_$VisitorDataImpl instance) =>
    <String, dynamic>{
      'visitors': instance.visitors,
      'slot_5m': instance.slot_5m.toIso8601String(),
    };
