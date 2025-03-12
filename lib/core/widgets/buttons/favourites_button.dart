import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_state.dart';

class FavouriteButton extends StatelessWidget {
  final PlaceItem place;

  const FavouriteButton({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<PlacesCubit, PlacesState>(
      builder: (BuildContext context, PlacesState state) {
        if (state is! Loaded) return const SizedBox.shrink();

        final bool isFavourite = state.favourites.any((PlaceItem p) => p.title == place.title);
        final PlacesCubit cubit = context.read<PlacesCubit>();

        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorWhitePrimary, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () {
              if (isFavourite) {
                cubit.removeFromFavourites(place);
              } else {
                cubit.addToFavourites(place);
              }
            },
            icon: Icon(
              Icons.bookmark,
              color: isFavourite ? const Color(0xFFE7C563) : AppColors.colorWhitePrimary,
            ),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        );
      },
    );
}
