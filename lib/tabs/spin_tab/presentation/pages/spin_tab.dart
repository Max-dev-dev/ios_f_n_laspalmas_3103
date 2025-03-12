import 'dart:math';

import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/widgets/buttons/las_palmas_main_button.dart';
import 'package:momento_las_palmas/tabs/spin_tab/presentation/pages/spin_result/spin_result.dart';

class SpinTab extends StatefulWidget {
  const SpinTab({Key? key}) : super(key: key);

  @override
  _SpinTabState createState() => _SpinTabState();
}

class _SpinTabState extends State<SpinTab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _tabController.animateTo(1);
        }
      });

    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  void _spinWheel() {
    final double randomAngle = 2 * pi * (4 + _random.nextDouble() * 2);
    _animation = Tween<double>(
      begin: _animation.value,
      end: _animation.value + randomAngle,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Builder(
          builder: (BuildContext context) {
            _tabController = DefaultTabController.of(context);
            return TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _spinWheelView(),
                SpinResultView(tabController: _tabController),
              ],
            );
          },
        ),
      );

  Widget _spinWheelView() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: screenWidth > 375 ? 40 : 10),
                  _title(),
                  SizedBox(height: screenWidth > 375 ? 30 : 10),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) =>
                            Transform.rotate(
                          angle: _animation.value,
                          child: Image.asset(
                            'assets/images/spin_images/circle_icon.png',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -30,
                        child: Image.asset(
                          'assets/images/spin_images/triangle_icon.png',
                          width: 78,
                          height: 78,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  LasPalmasMainButton(
                    onTap: _spinWheel,
                    buttonText: 'Surprise me',
                  ),
                  if (screenWidth > 375)
                    const Spacer()
                  else
                    const SizedBox(
                      height: 130,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Feeling Spontaneous?',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 24 : 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Let fate decide your next destination in Las Palmas!',
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
}
