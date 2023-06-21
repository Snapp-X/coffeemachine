// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coffeemachine_chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CoffeemachineChartState {
  List<double> get currentTemperature => throw _privateConstructorUsedError;
  List<double> get targetTemperature => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CoffeemachineChartStateCopyWith<CoffeemachineChartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoffeemachineChartStateCopyWith<$Res> {
  factory $CoffeemachineChartStateCopyWith(CoffeemachineChartState value,
          $Res Function(CoffeemachineChartState) then) =
      _$CoffeemachineChartStateCopyWithImpl<$Res, CoffeemachineChartState>;
  @useResult
  $Res call({List<double> currentTemperature, List<double> targetTemperature});
}

/// @nodoc
class _$CoffeemachineChartStateCopyWithImpl<$Res,
        $Val extends CoffeemachineChartState>
    implements $CoffeemachineChartStateCopyWith<$Res> {
  _$CoffeemachineChartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTemperature = null,
    Object? targetTemperature = null,
  }) {
    return _then(_value.copyWith(
      currentTemperature: null == currentTemperature
          ? _value.currentTemperature
          : currentTemperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
      targetTemperature: null == targetTemperature
          ? _value.targetTemperature
          : targetTemperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CoffeemachineChartStateCopyWith<$Res>
    implements $CoffeemachineChartStateCopyWith<$Res> {
  factory _$$_CoffeemachineChartStateCopyWith(_$_CoffeemachineChartState value,
          $Res Function(_$_CoffeemachineChartState) then) =
      __$$_CoffeemachineChartStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<double> currentTemperature, List<double> targetTemperature});
}

/// @nodoc
class __$$_CoffeemachineChartStateCopyWithImpl<$Res>
    extends _$CoffeemachineChartStateCopyWithImpl<$Res,
        _$_CoffeemachineChartState>
    implements _$$_CoffeemachineChartStateCopyWith<$Res> {
  __$$_CoffeemachineChartStateCopyWithImpl(_$_CoffeemachineChartState _value,
      $Res Function(_$_CoffeemachineChartState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentTemperature = null,
    Object? targetTemperature = null,
  }) {
    return _then(_$_CoffeemachineChartState(
      currentTemperature: null == currentTemperature
          ? _value._currentTemperature
          : currentTemperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
      targetTemperature: null == targetTemperature
          ? _value._targetTemperature
          : targetTemperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc

class _$_CoffeemachineChartState implements _CoffeemachineChartState {
  const _$_CoffeemachineChartState(
      {required final List<double> currentTemperature,
      required final List<double> targetTemperature})
      : _currentTemperature = currentTemperature,
        _targetTemperature = targetTemperature;

  final List<double> _currentTemperature;
  @override
  List<double> get currentTemperature {
    if (_currentTemperature is EqualUnmodifiableListView)
      return _currentTemperature;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentTemperature);
  }

  final List<double> _targetTemperature;
  @override
  List<double> get targetTemperature {
    if (_targetTemperature is EqualUnmodifiableListView)
      return _targetTemperature;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetTemperature);
  }

  @override
  String toString() {
    return 'CoffeemachineChartState(currentTemperature: $currentTemperature, targetTemperature: $targetTemperature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CoffeemachineChartState &&
            const DeepCollectionEquality()
                .equals(other._currentTemperature, _currentTemperature) &&
            const DeepCollectionEquality()
                .equals(other._targetTemperature, _targetTemperature));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_currentTemperature),
      const DeepCollectionEquality().hash(_targetTemperature));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CoffeemachineChartStateCopyWith<_$_CoffeemachineChartState>
      get copyWith =>
          __$$_CoffeemachineChartStateCopyWithImpl<_$_CoffeemachineChartState>(
              this, _$identity);
}

abstract class _CoffeemachineChartState implements CoffeemachineChartState {
  const factory _CoffeemachineChartState(
          {required final List<double> currentTemperature,
          required final List<double> targetTemperature}) =
      _$_CoffeemachineChartState;

  @override
  List<double> get currentTemperature;
  @override
  List<double> get targetTemperature;
  @override
  @JsonKey(ignore: true)
  _$$_CoffeemachineChartStateCopyWith<_$_CoffeemachineChartState>
      get copyWith => throw _privateConstructorUsedError;
}
