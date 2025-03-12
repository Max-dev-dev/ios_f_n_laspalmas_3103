import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/widgets/app_logo/app_logo.dart';
import 'package:momento_las_palmas/splash/presentation/pages/splash_loader/splash_loader.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  bool _showSplashLoader = false;
  bool _showFinalContent = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 150, end: 40).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.33),
      ),
    )..addListener(() {
        if (_heightAnimation.value <= 40 && !_showSplashLoader) {
          setState(() {
            _showSplashLoader = true;
          });
        }
      });

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showSplashLoader = false;
        _showFinalContent = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              if (_showFinalContent) {
                return const AppLogo();
              } else if (_showSplashLoader) {
                return Center(
                  child: SplashLoader(),
                );
              } else {
                return SizedBox(
                  height: _heightAnimation.value,
                  width: 40,
                  child: Image.asset('assets/images/splash_icons/item.png'),
                );
              }
            },
          ),
        ),
      );
}
