import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/widgets/buttons/las_palmas_main_button.dart';
import 'package:momento_las_palmas/core/widgets/place_card/place_card.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_state.dart';
import 'package:momento_las_palmas/home/presentation/pages/home_page.dart';

class SpinResultView extends StatefulWidget {
  final TabController tabController;

  const SpinResultView({Key? key, required this.tabController})
      : super(key: key);

  @override
  _SpinResultViewState createState() => _SpinResultViewState();
}

class _SpinResultViewState extends State<SpinResultView> {
  PlaceItem? selectedPlace;

  @override
  Widget build(BuildContext context) => BlocBuilder<PlacesCubit, PlacesState>(
        builder: (BuildContext context, PlacesState state) => state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(color: AppColors.colorWhitePrimary),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.colorWhitePrimary),
          ),
          error: (String message) => const Center(
            child: CircularProgressIndicator(color: AppColors.colorWhitePrimary),
          ),
          loaded: (List<PlacesCategory> places, List<PlaceItem> favourites) {
            if (selectedPlace == null && places.isNotEmpty) {
              selectedPlace = _getRandomPlace(places);
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 30.0),
                          _title(),
                          const SizedBox(height: 30.0),
                          if (selectedPlace != null)
                            PlaceInfoCard(place: selectedPlace!),
                          const SizedBox(height: 30.0),
                          LasPalmasMainButton(
                            onTap: () => widget.tabController.animateTo(0),
                            buttonText: 'Spin more',
                          ),
                          const SizedBox(height: 16.0),
                          GestureDetector(
                            onTap: () => backHome(),
                            child: const Text(
                              'Back home',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: AppColors.colorWhitePrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 120.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _title() => const SizedBox(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Result:',
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );

  PlaceItem _getRandomPlace(List<PlacesCategory> places) {
    final Random random = Random();
    final PlacesCategory randomCategory = places[random.nextInt(places.length)];
    return randomCategory.items[random.nextInt(randomCategory.items.length)];
  }

  void backHome() {
    homePageKey.currentState?.backToTimePickerTab();
  }
}
