// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitorData _$VisitorDataFromJson(Map<String, dynamic> json) {
  return _VisitorData.fromJson(json);
}

/// @nodoc
mixin _$VisitorData {
  int get visitors => throw _privateConstructorUsedError;
  DateTime get slot_5m => throw _privateConstructorUsedError;

  /// Serializes this VisitorData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VisitorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitorDataCopyWith<VisitorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitorDataCopyWith<$Res> {
  factory $VisitorDataCopyWith(
          VisitorData value, $Res Function(VisitorData) then) =
      _$VisitorDataCopyWithImpl<$Res, VisitorData>;
  @useResult
  $Res call({int visitors, DateTime slot_5m});
}

/// @nodoc
class _$VisitorDataCopyWithImpl<$Res, $Val extends VisitorData>
    implements $VisitorDataCopyWith<$Res> {
  _$VisitorDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitors = null,
    Object? slot_5m = null,
  }) {
    return _then(_value.copyWith(
      visitors: null == visitors
          ? _value.visitors
          : visitors // ignore: cast_nullable_to_non_nullable
              as int,
      slot_5m: null == slot_5m
          ? _value.slot_5m
          : slot_5m // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitorDataImplCopyWith<$Res>
    implements $VisitorDataCopyWith<$Res> {
  factory _$$VisitorDataImplCopyWith(
          _$VisitorDataImpl value, $Res Function(_$VisitorDataImpl) then) =
      __$$VisitorDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int visitors, DateTime slot_5m});
}

/// @nodoc
class __$$VisitorDataImplCopyWithImpl<$Res>
    extends _$VisitorDataCopyWithImpl<$Res, _$VisitorDataImpl>
    implements _$$VisitorDataImplCopyWith<$Res> {
  __$$VisitorDataImplCopyWithImpl(
      _$VisitorDataImpl _value, $Res Function(_$VisitorDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VisitorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitors = null,
    Object? slot_5m = null,
  }) {
    return _then(_$VisitorDataImpl(
      visitors: null == visitors
          ? _value.visitors
          : visitors // ignore: cast_nullable_to_non_nullable
              as int,
      slot_5m: null == slot_5m
          ? _value.slot_5m
          : slot_5m // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitorDataImpl implements _VisitorData {
  const _$VisitorDataImpl({required this.visitors, required this.slot_5m});

  factory _$VisitorDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitorDataImplFromJson(json);

  @override
  final int visitors;
  @override
  final DateTime slot_5m;

  @override
  String toString() {
    return 'VisitorData(visitors: $visitors, slot_5m: $slot_5m)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitorDataImpl &&
            (identical(other.visitors, visitors) ||
                other.visitors == visitors) &&
            (identical(other.slot_5m, slot_5m) || other.slot_5m == slot_5m));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, visitors, slot_5m);

  /// Create a copy of VisitorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitorDataImplCopyWith<_$VisitorDataImpl> get copyWith =>
      __$$VisitorDataImplCopyWithImpl<_$VisitorDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitorDataImplToJson(
      this,
    );
  }
}

abstract class _VisitorData implements VisitorData {
  const factory _VisitorData(
      {required final int visitors,
      required final DateTime slot_5m}) = _$VisitorDataImpl;

  factory _VisitorData.fromJson(Map<String, dynamic> json) =
      _$VisitorDataImpl.fromJson;

  @override
  int get visitors;
  @override
  DateTime get slot_5m;

  /// Create a copy of VisitorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitorDataImplCopyWith<_$VisitorDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
