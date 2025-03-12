import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/router/router.dart';
import 'package:momento_las_palmas/core/widgets/app_logo/app_logo.dart';
import 'package:momento_las_palmas/onboarding/presentation/pages/tabs/first_tab.dart';
import 'package:momento_las_palmas/onboarding/presentation/pages/tabs/second_tab.dart';
import 'package:momento_las_palmas/onboarding/presentation/pages/tabs/third_tab.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Stack(
              children: <Widget>[
                Container(
                  key: ValueKey<int>(_tabController.index),
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        _getImageForTab(_tabController.index),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/onboard_images/shadow.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned.fill(
                  top: 150,
                  child: Align(
                    alignment: Alignment.center,
                    child: AppLogo(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.colorBlackPrimary,
              ),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  FirstTab(
                    onNext: () {
                      _tabController.animateTo(1);
                    },
                  ),
                  SecondTab(
                    onNext: () {
                      _tabController.animateTo(2);
                    },
                  ),
                  ThirdTab(
                    onNext: () {
                      context.pushReplacement(AppRoutes.homePage);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getImageForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'assets/images/onboard_images/1.png';
      case 1:
        return 'assets/images/onboard_images/2.png';
      case 2:
        return 'assets/images/onboard_images/3.png';
      default:
        return 'assets/images/onboard_images/1.png';
    }
  }
}
