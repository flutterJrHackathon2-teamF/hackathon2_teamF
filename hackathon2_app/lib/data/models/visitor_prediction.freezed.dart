// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_prediction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitorPrediction _$VisitorPredictionFromJson(Map<String, dynamic> json) {
  return _VisitorPrediction.fromJson(json);
}

/// @nodoc
mixin _$VisitorPrediction {
  int get hour => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  double get visitors => throw _privateConstructorUsedError;

  /// Serializes this VisitorPrediction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VisitorPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitorPredictionCopyWith<VisitorPrediction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitorPredictionCopyWith<$Res> {
  factory $VisitorPredictionCopyWith(
          VisitorPrediction value, $Res Function(VisitorPrediction) then) =
      _$VisitorPredictionCopyWithImpl<$Res, VisitorPrediction>;
  @useResult
  $Res call({int hour, String time, double visitors});
}

/// @nodoc
class _$VisitorPredictionCopyWithImpl<$Res, $Val extends VisitorPrediction>
    implements $VisitorPredictionCopyWith<$Res> {
  _$VisitorPredictionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VisitorPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? time = null,
    Object? visitors = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      visitors: null == visitors
          ? _value.visitors
          : visitors // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitorPredictionImplCopyWith<$Res>
    implements $VisitorPredictionCopyWith<$Res> {
  factory _$$VisitorPredictionImplCopyWith(_$VisitorPredictionImpl value,
          $Res Function(_$VisitorPredictionImpl) then) =
      __$$VisitorPredictionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, String time, double visitors});
}

/// @nodoc
class __$$VisitorPredictionImplCopyWithImpl<$Res>
    extends _$VisitorPredictionCopyWithImpl<$Res, _$VisitorPredictionImpl>
    implements _$$VisitorPredictionImplCopyWith<$Res> {
  __$$VisitorPredictionImplCopyWithImpl(_$VisitorPredictionImpl _value,
      $Res Function(_$VisitorPredictionImpl) _then)
      : super(_value, _then);

  /// Create a copy of VisitorPrediction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? time = null,
    Object? visitors = null,
  }) {
    return _then(_$VisitorPredictionImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      visitors: null == visitors
          ? _value.visitors
          : visitors // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitorPredictionImpl implements _VisitorPrediction {
  const _$VisitorPredictionImpl(
      {required this.hour, required this.time, required this.visitors});

  factory _$VisitorPredictionImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitorPredictionImplFromJson(json);

  @override
  final int hour;
  @override
  final String time;
  @override
  final double visitors;

  @override
  String toString() {
    return 'VisitorPrediction(hour: $hour, time: $time, visitors: $visitors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitorPredictionImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.visitors, visitors) ||
                other.visitors == visitors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, hour, time, visitors);

  /// Create a copy of VisitorPrediction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitorPredictionImplCopyWith<_$VisitorPredictionImpl> get copyWith =>
      __$$VisitorPredictionImplCopyWithImpl<_$VisitorPredictionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitorPredictionImplToJson(
      this,
    );
  }
}

abstract class _VisitorPrediction implements VisitorPrediction {
  const factory _VisitorPrediction(
      {required final int hour,
      required final String time,
      required final double visitors}) = _$VisitorPredictionImpl;

  factory _VisitorPrediction.fromJson(Map<String, dynamic> json) =
      _$VisitorPredictionImpl.fromJson;

  @override
  int get hour;
  @override
  String get time;
  @override
  double get visitors;

  /// Create a copy of VisitorPrediction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitorPredictionImplCopyWith<_$VisitorPredictionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
