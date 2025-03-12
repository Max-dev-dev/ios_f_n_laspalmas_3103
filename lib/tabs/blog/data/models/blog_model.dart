// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_model.freezed.dart';
part 'blog_model.g.dart';

@freezed
class BlogModel with _$BlogModel {
  const factory BlogModel({
    required int id,
    required String title,
    @JsonKey(name: 'paragraph_one') required String paragraphOne,
    @JsonKey(name: 'paragraph_two') required String paragraphTwo,
  }) = _BlogModel;

  factory BlogModel.fromJson(Map<String, dynamic> json) => _$BlogModelFromJson(json);
}
