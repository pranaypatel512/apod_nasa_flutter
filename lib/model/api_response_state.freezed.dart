// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$APIResponseState {
  List<MediaListResponse> get list => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $APIResponseStateCopyWith<APIResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $APIResponseStateCopyWith<$Res> {
  factory $APIResponseStateCopyWith(
          APIResponseState value, $Res Function(APIResponseState) then) =
      _$APIResponseStateCopyWithImpl<$Res, APIResponseState>;
  @useResult
  $Res call({List<MediaListResponse> list, bool isLoading});
}

/// @nodoc
class _$APIResponseStateCopyWithImpl<$Res, $Val extends APIResponseState>
    implements $APIResponseStateCopyWith<$Res> {
  _$APIResponseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MediaListResponse>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_APIResponseStateCopyWith<$Res>
    implements $APIResponseStateCopyWith<$Res> {
  factory _$$_APIResponseStateCopyWith(
          _$_APIResponseState value, $Res Function(_$_APIResponseState) then) =
      __$$_APIResponseStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MediaListResponse> list, bool isLoading});
}

/// @nodoc
class __$$_APIResponseStateCopyWithImpl<$Res>
    extends _$APIResponseStateCopyWithImpl<$Res, _$_APIResponseState>
    implements _$$_APIResponseStateCopyWith<$Res> {
  __$$_APIResponseStateCopyWithImpl(
      _$_APIResponseState _value, $Res Function(_$_APIResponseState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? isLoading = null,
  }) {
    return _then(_$_APIResponseState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<MediaListResponse>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_APIResponseState implements _APIResponseState {
  _$_APIResponseState(
      {final List<MediaListResponse> list = const [], this.isLoading = true})
      : _list = list;

  final List<MediaListResponse> _list;
  @override
  @JsonKey()
  List<MediaListResponse> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'APIResponseState(list: $list, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_APIResponseState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_list), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_APIResponseStateCopyWith<_$_APIResponseState> get copyWith =>
      __$$_APIResponseStateCopyWithImpl<_$_APIResponseState>(this, _$identity);
}

abstract class _APIResponseState implements APIResponseState {
  factory _APIResponseState(
      {final List<MediaListResponse> list,
      final bool isLoading}) = _$_APIResponseState;

  @override
  List<MediaListResponse> get list;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_APIResponseStateCopyWith<_$_APIResponseState> get copyWith =>
      throw _privateConstructorUsedError;
}
