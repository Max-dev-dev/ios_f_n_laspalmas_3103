import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/utils/di_container/di_container.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';

class MomentoLasScaffold extends StatelessWidget {
  final Widget body;
  final bool gradientBackground;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const MomentoLasScaffold({
    required this.body,
    this.gradientBackground = true,
    required this.selectedIndex,
    required this.onTabSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => getIt<PlacesCubit>(),
      child: Scaffold(
        appBar: _appBar(context, screenWidth),
        backgroundColor: gradientBackground
            ? Colors.transparent
            : AppColors.colorBlackPrimary,
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: body),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: _bottomNavBar(context),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(
    BuildContext context,
    double screenWidth,
  ) =>
      AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF3F3F3F),
        toolbarHeight: Platform.isAndroid ? 130 : screenWidth > 375 ? 100 : 130,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFBF9A30),
                width: 1,
              ),
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 70.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildIconButton(Icons.article, 0),
                    const SizedBox(width: 50),
                    Image.asset(
                      'assets/images/splash_icons/items.png',
                      width: 100,
                    ),
                    const SizedBox(width: 50),
                    _buildIconButton(Icons.bookmark_outlined, 1),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _bottomNavBar(BuildContext context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF3F3F3F),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFBF9A30),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavButton(Icons.casino, 2),
                _buildNavButton(Icons.access_time, 3),
                _buildNavButton(Icons.map, 4),
              ],
            ),
          ),
        ),
      );

  Widget _buildNavButton(IconData icon, int index) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? const Color(0xFFBF9A30)
              : AppColors.colorBlackPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: AppColors.colorWhitePrimary,
          ),
          onPressed: () => onTabSelected(index),
        ),
      );

  Widget _buildIconButton(IconData icon, int index) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? const Color(0xFFBF9A30)
              : const Color(0xFF1B1B1B),
          border: Border.all(
            color: const Color(0xFF4F4F4F),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: AppColors.colorWhitePrimary,
          ),
          onPressed: () => onTabSelected(index),
        ),
      );
}
