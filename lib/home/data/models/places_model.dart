// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'places_model.freezed.dart';
part 'places_model.g.dart';

@freezed
class PlacesData with _$PlacesData {
  const factory PlacesData({
    required List<PlacesCategory> places,
  }) = _PlacesData;

  factory PlacesData.fromJson(Map<String, dynamic> json) => _$PlacesDataFromJson(json);
}

@freezed
class PlacesCategory with _$PlacesCategory {
  const factory PlacesCategory({
    required String time,
    required List<PlaceItem> items,
  }) = _PlacesCategory;

  factory PlacesCategory.fromJson(Map<String, dynamic> json) => _$PlacesCategoryFromJson(json);
}

@freezed
class PlaceItem with _$PlaceItem {
  const factory PlaceItem({
    required int id,
    required String title,
    required String description,
    required String rating,
    required String coordinates,
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _PlaceItem;

  factory PlaceItem.fromJson(Map<String, dynamic> json) => _$PlaceItemFromJson(json);
}
