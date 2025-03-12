// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return _BlogModel.fromJson(json);
}

/// @nodoc
mixin _$BlogModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_one')
  String get paragraphOne => throw _privateConstructorUsedError;
  @JsonKey(name: 'paragraph_two')
  String get paragraphTwo => throw _privateConstructorUsedError;

  /// Serializes this BlogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlogModelCopyWith<BlogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlogModelCopyWith<$Res> {
  factory $BlogModelCopyWith(BlogModel value, $Res Function(BlogModel) then) =
      _$BlogModelCopyWithImpl<$Res, BlogModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'paragraph_one') String paragraphOne,
      @JsonKey(name: 'paragraph_two') String paragraphTwo});
}

/// @nodoc
class _$BlogModelCopyWithImpl<$Res, $Val extends BlogModel>
    implements $BlogModelCopyWith<$Res> {
  _$BlogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? paragraphOne = null,
    Object? paragraphTwo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphOne: null == paragraphOne
          ? _value.paragraphOne
          : paragraphOne // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphTwo: null == paragraphTwo
          ? _value.paragraphTwo
          : paragraphTwo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlogModelImplCopyWith<$Res>
    implements $BlogModelCopyWith<$Res> {
  factory _$$BlogModelImplCopyWith(
          _$BlogModelImpl value, $Res Function(_$BlogModelImpl) then) =
      __$$BlogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      @JsonKey(name: 'paragraph_one') String paragraphOne,
      @JsonKey(name: 'paragraph_two') String paragraphTwo});
}

/// @nodoc
class __$$BlogModelImplCopyWithImpl<$Res>
    extends _$BlogModelCopyWithImpl<$Res, _$BlogModelImpl>
    implements _$$BlogModelImplCopyWith<$Res> {
  __$$BlogModelImplCopyWithImpl(
      _$BlogModelImpl _value, $Res Function(_$BlogModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? paragraphOne = null,
    Object? paragraphTwo = null,
  }) {
    return _then(_$BlogModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphOne: null == paragraphOne
          ? _value.paragraphOne
          : paragraphOne // ignore: cast_nullable_to_non_nullable
              as String,
      paragraphTwo: null == paragraphTwo
          ? _value.paragraphTwo
          : paragraphTwo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlogModelImpl implements _BlogModel {
  const _$BlogModelImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'paragraph_one') required this.paragraphOne,
      @JsonKey(name: 'paragraph_two') required this.paragraphTwo});

  factory _$BlogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlogModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'paragraph_one')
  final String paragraphOne;
  @override
  @JsonKey(name: 'paragraph_two')
  final String paragraphTwo;

  @override
  String toString() {
    return 'BlogModel(id: $id, title: $title, paragraphOne: $paragraphOne, paragraphTwo: $paragraphTwo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.paragraphOne, paragraphOne) ||
                other.paragraphOne == paragraphOne) &&
            (identical(other.paragraphTwo, paragraphTwo) ||
                other.paragraphTwo == paragraphTwo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, paragraphOne, paragraphTwo);

  /// Create a copy of BlogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlogModelImplCopyWith<_$BlogModelImpl> get copyWith =>
      __$$BlogModelImplCopyWithImpl<_$BlogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlogModelImplToJson(
      this,
    );
  }
}

abstract class _BlogModel implements BlogModel {
  const factory _BlogModel(
          {required final int id,
          required final String title,
          @JsonKey(name: 'paragraph_one') required final String paragraphOne,
          @JsonKey(name: 'paragraph_two') required final String paragraphTwo}) =
      _$BlogModelImpl;

  factory _BlogModel.fromJson(Map<String, dynamic> json) =
      _$BlogModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'paragraph_one')
  String get paragraphOne;
  @override
  @JsonKey(name: 'paragraph_two')
  String get paragraphTwo;

  /// Create a copy of BlogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlogModelImplCopyWith<_$BlogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
