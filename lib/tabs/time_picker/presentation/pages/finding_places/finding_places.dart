import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'dart:async';
import 'package:momento_las_palmas/core/widgets/buttons/las_palmas_main_button.dart';

class FindingPlaces extends StatefulWidget {
  final TabController tabController;

  const FindingPlaces({Key? key, required this.tabController})
      : super(key: key);

  @override
  _FindingPlacesState createState() => _FindingPlacesState();
}

class _FindingPlacesState extends State<FindingPlaces>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    Future.delayed(const Duration(seconds: 2), () {
      _animationController.stop();
      widget.tabController.animateTo(widget.tabController.index + 1);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: screenWidth > 375 ? 30 : 10),
          _title(screenWidth),
          SizedBox(height: screenWidth > 375 ? 30 : 10),
          RotationTransition(
            turns: _animationController,
            child: Image.asset(
              'assets/images/splash_icons/loading_time_icon.png',
              width: 300,
              height: 300,
            ),
          ),
          if (screenWidth > 375) ...<Widget>[
            const SizedBox(height: 30.0),
            LasPalmasMainButton(
              onTap: () {},
              buttonText: 'Please wait...',
            ),
            const Spacer(),
          ] else
            const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _title(double screenWidth) => SizedBox(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Finding the perfect place...',
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: screenWidth > 375 ? 24 : 18,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Hold on while we match you with the best location in Las Palmas.',
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
