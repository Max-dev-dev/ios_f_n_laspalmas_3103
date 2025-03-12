// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'places_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlacesData _$PlacesDataFromJson(Map<String, dynamic> json) {
  return _PlacesData.fromJson(json);
}

/// @nodoc
mixin _$PlacesData {
  List<PlacesCategory> get places => throw _privateConstructorUsedError;

  /// Serializes this PlacesData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlacesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlacesDataCopyWith<PlacesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlacesDataCopyWith<$Res> {
  factory $PlacesDataCopyWith(
          PlacesData value, $Res Function(PlacesData) then) =
      _$PlacesDataCopyWithImpl<$Res, PlacesData>;
  @useResult
  $Res call({List<PlacesCategory> places});
}

/// @nodoc
class _$PlacesDataCopyWithImpl<$Res, $Val extends PlacesData>
    implements $PlacesDataCopyWith<$Res> {
  _$PlacesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlacesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? places = null,
  }) {
    return _then(_value.copyWith(
      places: null == places
          ? _value.places
          : places // ignore: cast_nullable_to_non_nullable
              as List<PlacesCategory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlacesDataImplCopyWith<$Res>
    implements $PlacesDataCopyWith<$Res> {
  factory _$$PlacesDataImplCopyWith(
          _$PlacesDataImpl value, $Res Function(_$PlacesDataImpl) then) =
      __$$PlacesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlacesCategory> places});
}

/// @nodoc
class __$$PlacesDataImplCopyWithImpl<$Res>
    extends _$PlacesDataCopyWithImpl<$Res, _$PlacesDataImpl>
    implements _$$PlacesDataImplCopyWith<$Res> {
  __$$PlacesDataImplCopyWithImpl(
      _$PlacesDataImpl _value, $Res Function(_$PlacesDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlacesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? places = null,
  }) {
    return _then(_$PlacesDataImpl(
      places: null == places
          ? _value._places
          : places // ignore: cast_nullable_to_non_nullable
              as List<PlacesCategory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlacesDataImpl implements _PlacesData {
  const _$PlacesDataImpl({required final List<PlacesCategory> places})
      : _places = places;

  factory _$PlacesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlacesDataImplFromJson(json);

  final List<PlacesCategory> _places;
  @override
  List<PlacesCategory> get places {
    if (_places is EqualUnmodifiableListView) return _places;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_places);
  }

  @override
  String toString() {
    return 'PlacesData(places: $places)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesDataImpl &&
            const DeepCollectionEquality().equals(other._places, _places));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_places));

  /// Create a copy of PlacesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesDataImplCopyWith<_$PlacesDataImpl> get copyWith =>
      __$$PlacesDataImplCopyWithImpl<_$PlacesDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlacesDataImplToJson(
      this,
    );
  }
}

abstract class _PlacesData implements PlacesData {
  const factory _PlacesData({required final List<PlacesCategory> places}) =
      _$PlacesDataImpl;

  factory _PlacesData.fromJson(Map<String, dynamic> json) =
      _$PlacesDataImpl.fromJson;

  @override
  List<PlacesCategory> get places;

  /// Create a copy of PlacesData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlacesDataImplCopyWith<_$PlacesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlacesCategory _$PlacesCategoryFromJson(Map<String, dynamic> json) {
  return _PlacesCategory.fromJson(json);
}

/// @nodoc
mixin _$PlacesCategory {
  String get time => throw _privateConstructorUsedError;
  List<PlaceItem> get items => throw _privateConstructorUsedError;

  /// Serializes this PlacesCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlacesCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlacesCategoryCopyWith<PlacesCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlacesCategoryCopyWith<$Res> {
  factory $PlacesCategoryCopyWith(
          PlacesCategory value, $Res Function(PlacesCategory) then) =
      _$PlacesCategoryCopyWithImpl<$Res, PlacesCategory>;
  @useResult
  $Res call({String time, List<PlaceItem> items});
}

/// @nodoc
class _$PlacesCategoryCopyWithImpl<$Res, $Val extends PlacesCategory>
    implements $PlacesCategoryCopyWith<$Res> {
  _$PlacesCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlacesCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PlaceItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlacesCategoryImplCopyWith<$Res>
    implements $PlacesCategoryCopyWith<$Res> {
  factory _$$PlacesCategoryImplCopyWith(_$PlacesCategoryImpl value,
          $Res Function(_$PlacesCategoryImpl) then) =
      __$$PlacesCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String time, List<PlaceItem> items});
}

/// @nodoc
class __$$PlacesCategoryImplCopyWithImpl<$Res>
    extends _$PlacesCategoryCopyWithImpl<$Res, _$PlacesCategoryImpl>
    implements _$$PlacesCategoryImplCopyWith<$Res> {
  __$$PlacesCategoryImplCopyWithImpl(
      _$PlacesCategoryImpl _value, $Res Function(_$PlacesCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlacesCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? items = null,
  }) {
    return _then(_$PlacesCategoryImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PlaceItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlacesCategoryImpl implements _PlacesCategory {
  const _$PlacesCategoryImpl(
      {required this.time, required final List<PlaceItem> items})
      : _items = items;

  factory _$PlacesCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlacesCategoryImplFromJson(json);

  @override
  final String time;
  final List<PlaceItem> _items;
  @override
  List<PlaceItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PlacesCategory(time: $time, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesCategoryImpl &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, time, const DeepCollectionEquality().hash(_items));

  /// Create a copy of PlacesCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesCategoryImplCopyWith<_$PlacesCategoryImpl> get copyWith =>
      __$$PlacesCategoryImplCopyWithImpl<_$PlacesCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlacesCategoryImplToJson(
      this,
    );
  }
}

abstract class _PlacesCategory implements PlacesCategory {
  const factory _PlacesCategory(
      {required final String time,
      required final List<PlaceItem> items}) = _$PlacesCategoryImpl;

  factory _PlacesCategory.fromJson(Map<String, dynamic> json) =
      _$PlacesCategoryImpl.fromJson;

  @override
  String get time;
  @override
  List<PlaceItem> get items;

  /// Create a copy of PlacesCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlacesCategoryImplCopyWith<_$PlacesCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaceItem _$PlaceItemFromJson(Map<String, dynamic> json) {
  return _PlaceItem.fromJson(json);
}

/// @nodoc
mixin _$PlaceItem {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get rating => throw _privateConstructorUsedError;
  String get coordinates => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this PlaceItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlaceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaceItemCopyWith<PlaceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaceItemCopyWith<$Res> {
  factory $PlaceItemCopyWith(PlaceItem value, $Res Function(PlaceItem) then) =
      _$PlaceItemCopyWithImpl<$Res, PlaceItem>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String rating,
      String coordinates,
      @JsonKey(name: 'image_url') String imageUrl});
}

/// @nodoc
class _$PlaceItemCopyWithImpl<$Res, $Val extends PlaceItem>
    implements $PlaceItemCopyWith<$Res> {
  _$PlaceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? rating = null,
    Object? coordinates = null,
    Object? imageUrl = null,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlaceItemImplCopyWith<$Res>
    implements $PlaceItemCopyWith<$Res> {
  factory _$$PlaceItemImplCopyWith(
          _$PlaceItemImpl value, $Res Function(_$PlaceItemImpl) then) =
      __$$PlaceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      String rating,
      String coordinates,
      @JsonKey(name: 'image_url') String imageUrl});
}

/// @nodoc
class __$$PlaceItemImplCopyWithImpl<$Res>
    extends _$PlaceItemCopyWithImpl<$Res, _$PlaceItemImpl>
    implements _$$PlaceItemImplCopyWith<$Res> {
  __$$PlaceItemImplCopyWithImpl(
      _$PlaceItemImpl _value, $Res Function(_$PlaceItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlaceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? rating = null,
    Object? coordinates = null,
    Object? imageUrl = null,
  }) {
    return _then(_$PlaceItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlaceItemImpl implements _PlaceItem {
  const _$PlaceItemImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.rating,
      required this.coordinates,
      @JsonKey(name: 'image_url') required this.imageUrl});

  factory _$PlaceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlaceItemImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String rating;
  @override
  final String coordinates;
  @override
  @JsonKey(name: 'image_url')
  final String imageUrl;

  @override
  String toString() {
    return 'PlaceItem(id: $id, title: $title, description: $description, rating: $rating, coordinates: $coordinates, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, rating, coordinates, imageUrl);

  /// Create a copy of PlaceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaceItemImplCopyWith<_$PlaceItemImpl> get copyWith =>
      __$$PlaceItemImplCopyWithImpl<_$PlaceItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlaceItemImplToJson(
      this,
    );
  }
}

abstract class _PlaceItem implements PlaceItem {
  const factory _PlaceItem(
          {required final int id,
          required final String title,
          required final String description,
          required final String rating,
          required final String coordinates,
          @JsonKey(name: 'image_url') required final String imageUrl}) =
      _$PlaceItemImpl;

  factory _PlaceItem.fromJson(Map<String, dynamic> json) =
      _$PlaceItemImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get rating;
  @override
  String get coordinates;
  @override
  @JsonKey(name: 'image_url')
  String get imageUrl;

  /// Create a copy of PlaceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaceItemImplCopyWith<_$PlaceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
