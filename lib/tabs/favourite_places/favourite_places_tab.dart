import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/widgets/place_card/place_card.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_state.dart';

class FavouritesPlacesTab extends StatelessWidget {
  const FavouritesPlacesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<PlacesCubit, PlacesState>(
        builder: (BuildContext context, PlacesState state) {
          if (state is! Loaded) {
            return const Center(child: CircularProgressIndicator(color: AppColors.colorWhitePrimary));
          }

          final List<PlaceItem> favourites = state.favourites;

          if (favourites.isEmpty) {
            return const Center(
              child: Text(
                "No favourite places yet.",
                style: TextStyle(color: AppColors.colorWhitePrimary, fontSize: 16),
              ),
            );
          }

          return Column(
            children: <Widget>[
              const SizedBox(height: 28),
              const Text(
                'Saved locations:',
                style: TextStyle(
                  color: AppColors.colorWhitePrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: favourites.length,
                  itemBuilder: (BuildContext context, int index) {
                    final PlaceItem place = favourites[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == favourites.length - 1 ? 100.0 : 8.0,
                      ),
                      child: PlaceInfoCard(place: place),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
}
