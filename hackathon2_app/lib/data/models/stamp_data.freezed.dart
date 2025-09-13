// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamp_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StampData _$StampDataFromJson(Map<String, dynamic> json) {
  return _StampData.fromJson(json);
}

/// @nodoc
mixin _$StampData {
  @HiveField(0)
  List<bool> get stampStatus => throw _privateConstructorUsedError;
  @HiveField(1)
  int get totalStamps => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this StampData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StampData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StampDataCopyWith<StampData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampDataCopyWith<$Res> {
  factory $StampDataCopyWith(StampData value, $Res Function(StampData) then) =
      _$StampDataCopyWithImpl<$Res, StampData>;
  @useResult
  $Res call(
      {@HiveField(0) List<bool> stampStatus,
      @HiveField(1) int totalStamps,
      @HiveField(2) DateTime lastUpdated});
}

/// @nodoc
class _$StampDataCopyWithImpl<$Res, $Val extends StampData>
    implements $StampDataCopyWith<$Res> {
  _$StampDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StampData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stampStatus = null,
    Object? totalStamps = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      stampStatus: null == stampStatus
          ? _value.stampStatus
          : stampStatus // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      totalStamps: null == totalStamps
          ? _value.totalStamps
          : totalStamps // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampDataImplCopyWith<$Res>
    implements $StampDataCopyWith<$Res> {
  factory _$$StampDataImplCopyWith(
          _$StampDataImpl value, $Res Function(_$StampDataImpl) then) =
      __$$StampDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) List<bool> stampStatus,
      @HiveField(1) int totalStamps,
      @HiveField(2) DateTime lastUpdated});
}

/// @nodoc
class __$$StampDataImplCopyWithImpl<$Res>
    extends _$StampDataCopyWithImpl<$Res, _$StampDataImpl>
    implements _$$StampDataImplCopyWith<$Res> {
  __$$StampDataImplCopyWithImpl(
      _$StampDataImpl _value, $Res Function(_$StampDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StampData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stampStatus = null,
    Object? totalStamps = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$StampDataImpl(
      stampStatus: null == stampStatus
          ? _value._stampStatus
          : stampStatus // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      totalStamps: null == totalStamps
          ? _value.totalStamps
          : totalStamps // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0)
class _$StampDataImpl extends _StampData {
  const _$StampDataImpl(
      {@HiveField(0) required final List<bool> stampStatus,
      @HiveField(1) required this.totalStamps,
      @HiveField(2) required this.lastUpdated})
      : _stampStatus = stampStatus,
        super._();

  factory _$StampDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StampDataImplFromJson(json);

  final List<bool> _stampStatus;
  @override
  @HiveField(0)
  List<bool> get stampStatus {
    if (_stampStatus is EqualUnmodifiableListView) return _stampStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stampStatus);
  }

  @override
  @HiveField(1)
  final int totalStamps;
  @override
  @HiveField(2)
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'StampData(stampStatus: $stampStatus, totalStamps: $totalStamps, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampDataImpl &&
            const DeepCollectionEquality()
                .equals(other._stampStatus, _stampStatus) &&
            (identical(other.totalStamps, totalStamps) ||
                other.totalStamps == totalStamps) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stampStatus),
      totalStamps,
      lastUpdated);

  /// Create a copy of StampData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StampDataImplCopyWith<_$StampDataImpl> get copyWith =>
      __$$StampDataImplCopyWithImpl<_$StampDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StampDataImplToJson(
      this,
    );
  }
}

abstract class _StampData extends StampData {
  const factory _StampData(
      {@HiveField(0) required final List<bool> stampStatus,
      @HiveField(1) required final int totalStamps,
      @HiveField(2) required final DateTime lastUpdated}) = _$StampDataImpl;
  const _StampData._() : super._();

  factory _StampData.fromJson(Map<String, dynamic> json) =
      _$StampDataImpl.fromJson;

  @override
  @HiveField(0)
  List<bool> get stampStatus;
  @override
  @HiveField(1)
  int get totalStamps;
  @override
  @HiveField(2)
  DateTime get lastUpdated;

  /// Create a copy of StampData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StampDataImplCopyWith<_$StampDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return _LocationData.fromJson(json);
}

/// @nodoc
mixin _$LocationData {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this LocationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationDataCopyWith<LocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataCopyWith<$Res> {
  factory $LocationDataCopyWith(
          LocationData value, $Res Function(LocationData) then) =
      _$LocationDataCopyWithImpl<$Res, LocationData>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$LocationDataCopyWithImpl<$Res, $Val extends LocationData>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationDataImplCopyWith<$Res>
    implements $LocationDataCopyWith<$Res> {
  factory _$$LocationDataImplCopyWith(
          _$LocationDataImpl value, $Res Function(_$LocationDataImpl) then) =
      __$$LocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$LocationDataImplCopyWithImpl<$Res>
    extends _$LocationDataCopyWithImpl<$Res, _$LocationDataImpl>
    implements _$$LocationDataImplCopyWith<$Res> {
  __$$LocationDataImplCopyWithImpl(
      _$LocationDataImpl _value, $Res Function(_$LocationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LocationDataImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDataImpl implements _LocationData {
  const _$LocationDataImpl({required this.latitude, required this.longitude});

  factory _$LocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDataImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'LocationData(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDataImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      __$$LocationDataImplCopyWithImpl<_$LocationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDataImplToJson(
      this,
    );
  }
}

abstract class _LocationData implements LocationData {
  const factory _LocationData(
      {required final double latitude,
      required final double longitude}) = _$LocationDataImpl;

  factory _LocationData.fromJson(Map<String, dynamic> json) =
      _$LocationDataImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
