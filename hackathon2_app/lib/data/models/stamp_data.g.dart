// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StampDataImplAdapter extends TypeAdapter<_$StampDataImpl> {
  @override
  final int typeId = 0;

  @override
  _$StampDataImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$StampDataImpl(
      stampStatus: (fields[0] as List).cast<bool>(),
      totalStamps: fields[1] as int,
      lastUpdated: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$StampDataImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.totalStamps)
      ..writeByte(2)
      ..write(obj.lastUpdated)
      ..writeByte(0)
      ..write(obj.stampStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StampDataImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StampDataImpl _$$StampDataImplFromJson(Map<String, dynamic> json) =>
    _$StampDataImpl(
      stampStatus:
          (json['stampStatus'] as List<dynamic>).map((e) => e as bool).toList(),
      totalStamps: (json['totalStamps'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$StampDataImplToJson(_$StampDataImpl instance) =>
    <String, dynamic>{
      'stampStatus': instance.stampStatus,
      'totalStamps': instance.totalStamps,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_$LocationDataImpl _$$LocationDataImplFromJson(Map<String, dynamic> json) =>
    _$LocationDataImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LocationDataImplToJson(_$LocationDataImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
