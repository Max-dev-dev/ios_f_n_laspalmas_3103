// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlogModelImpl _$$BlogModelImplFromJson(Map<String, dynamic> json) =>
    _$BlogModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      paragraphOne: json['paragraph_one'] as String,
      paragraphTwo: json['paragraph_two'] as String,
    );

Map<String, dynamic> _$$BlogModelImplToJson(_$BlogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'paragraph_one': instance.paragraphOne,
      'paragraph_two': instance.paragraphTwo,
    };
