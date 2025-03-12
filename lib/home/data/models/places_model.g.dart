// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlacesDataImpl _$$PlacesDataImplFromJson(Map<String, dynamic> json) =>
    _$PlacesDataImpl(
      places: (json['places'] as List<dynamic>)
          .map((e) => PlacesCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlacesDataImplToJson(_$PlacesDataImpl instance) =>
    <String, dynamic>{
      'places': instance.places,
    };

_$PlacesCategoryImpl _$$PlacesCategoryImplFromJson(Map<String, dynamic> json) =>
    _$PlacesCategoryImpl(
      time: json['time'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => PlaceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlacesCategoryImplToJson(
        _$PlacesCategoryImpl instance) =>
    <String, dynamic>{
      'time': instance.time,
      'items': instance.items,
    };

_$PlaceItemImpl _$$PlaceItemImplFromJson(Map<String, dynamic> json) =>
    _$PlaceItemImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      rating: json['rating'] as String,
      coordinates: json['coordinates'] as String,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$$PlaceItemImplToJson(_$PlaceItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'rating': instance.rating,
      'coordinates': instance.coordinates,
      'image_url': instance.imageUrl,
    };
