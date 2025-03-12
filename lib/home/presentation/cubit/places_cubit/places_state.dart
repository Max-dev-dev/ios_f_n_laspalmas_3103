// ignore_for_file: always_specify_types

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';

part 'places_state.freezed.dart';

@freezed
abstract class PlacesState with _$PlacesState {
  const factory PlacesState.initial() = _Initial;
  const factory PlacesState.loading() = _Loading;
  const factory PlacesState.loaded({
    required List<PlacesCategory> places,
    @Default([]) List<PlaceItem> favourites,
  }) = Loaded;
  const factory PlacesState.error({required String message}) = _Error;
}
