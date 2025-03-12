import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/widgets/buttons/las_palmas_main_button.dart';
import 'package:momento_las_palmas/core/widgets/place_card/place_card.dart';
import 'package:momento_las_palmas/home/data/models/places_model.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_state.dart';

class PlaceResult extends StatefulWidget {
  final TabController tabController;
  final String hour;

  PlaceResult({
    required this.tabController,
    required this.hour,
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceResult> createState() => _PlaceResultState();
}

class _PlaceResultState extends State<PlaceResult> {
  PlaceItem? selectedPlace;

  final Map<String, List<String>> timeRanges = <String, List<String>>{
    "☀️ Dawnlight (06:00–12:00)": <String>["06:00", "12:00"],
    "🌤 Breeze (12:00–18:00)": <String>["12:00", "18:00"],
    "🌅 Sunset Glow (18:00–00:00)": <String>["18:00", "00:00"],
    "🌙 Midnight Pulse (00:00–06:00)": <String>["00:00", "06:00"],
  };

  final Map<String, String> subtitles = <String, String>{
    "☀️ Dawnlight (06:00–12:00)":
        "The perfect time for a morning coffee, beach walks, and catching the first sunlight.",
    "🌤 Breeze (12:00–18:00)":
        "Ideal for beach lounging, sightseeing, or a light terrace lunch.",
    "🌅 Sunset Glow (18:00–00:00)":
        "An atmospheric time for sunset views, dinner, and the start of nighttime adventures.",
    "🌙 Midnight Pulse (00:00–06:00)":
        "For night owls: a time for bars, late-night walks, and the city's nocturnal energy.",
  };

  String determineTimeRange(String hour) {
    final DateTime inputTime = DateTime.parse("2022-01-01T$hour:00");
    for (final MapEntry<String, List<String>> entry in timeRanges.entries) {
      final DateTime startTime =
          DateTime.parse("2022-01-01T${entry.value[0]}:00");
      DateTime endTime = DateTime.parse("2022-01-01T${entry.value[1]}:00");
      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }
      if ((inputTime.isAfter(startTime) ||
              inputTime.isAtSameMomentAs(startTime)) &&
          (inputTime.isBefore(endTime) ||
              inputTime.isAtSameMomentAs(endTime))) {
        return entry.key;
      }
    }
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (BuildContext context, PlacesState state) => state.when(
        initial: () => const Center(
          child: CircularProgressIndicator(color: AppColors.colorWhitePrimary),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.colorWhitePrimary),
        ),
        error: (String message) => Center(
          child: Text("Error: $message",
              style: const TextStyle(color: AppColors.colorWhitePrimary)),
        ),
        loaded: (List<PlacesCategory> places, List<PlaceItem> favourites) {
          final String timeRange = determineTimeRange(widget.hour);
          final PlacesCategory? category = places
              .firstWhereOrNull((PlacesCategory p) => p.time == timeRange);
          if (category != null && category.items.isNotEmpty) {
            selectedPlace ??=
                category.items[Random().nextInt(category.items.length)];
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
                        _title(
                            timeRange, subtitles[timeRange] ?? "", screenWidth),
                        const SizedBox(height: 30.0),
                        if (selectedPlace != null)
                          PlaceInfoCard(
                            place: selectedPlace!,
                          ),
                        const SizedBox(height: 30.0),
                        LasPalmasMainButton(
                          onTap: () => widget.tabController.animateTo(0),
                          buttonText: 'Search new',
                        ),
                        const SizedBox(height: 16.0),
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
  }

  Widget _title(String title, String subtitle, double screenWidth) => SizedBox(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: screenWidth > 375 ? 24 : 18,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: screenWidth > 375 ? 16 : 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
