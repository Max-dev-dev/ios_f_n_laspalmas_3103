// ignore_for_file: always_specify_types

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(const PlacesState.initial());

  final Logger logger = Logger();

  Future<void> loadPlaces() async {
    emit(const PlacesState.loading());
    try {
      final String jsonString =
          await rootBundle.loadString('assets/local_data/places_data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final PlacesData placeData = PlacesData.fromJson(jsonData);

      final List<PlaceItem> favourites = await _loadFavourites();

      emit(PlacesState.loaded(places: placeData.places, favourites: favourites));
    } catch (e) {
      logger.e('Failed to load places data: $e');
      emit(const PlacesState.error(message: 'Failed to load places data'));
    }
  }

  Future<void> addToFavourites(PlaceItem place) async {
    final PlacesState currentState = state;
    if (currentState is Loaded) {
      final List<PlaceItem> updatedFavourites = List.from(currentState.favourites);

      if (!updatedFavourites.any((PlaceItem p) => p.title == place.title)) {
        updatedFavourites.add(place);
        await _saveFavourites(updatedFavourites);
        emit(currentState.copyWith(favourites: updatedFavourites));
      }
    }
  }

  Future<void> removeFromFavourites(PlaceItem place) async {
    final PlacesState currentState = state;
    if (currentState is Loaded) {
      final List<PlaceItem> updatedFavourites = List.from(currentState.favourites);

      updatedFavourites.removeWhere((PlaceItem p) => p.title == place.title);
      await _saveFavourites(updatedFavourites);
      emit(currentState.copyWith(favourites: updatedFavourites));
    }
  }

  Future<void> _saveFavourites(List<PlaceItem> favourites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(favourites.map((PlaceItem p) => p.toJson()).toList());
    await prefs.setString('favourites_places', jsonString);
  }

  Future<List<PlaceItem>> _loadFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('favourites_places');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => PlaceItem.fromJson(e)).toList();
    }
    return <PlaceItem>[];
  }
}
