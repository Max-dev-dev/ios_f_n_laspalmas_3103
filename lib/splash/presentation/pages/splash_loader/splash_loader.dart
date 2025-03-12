import 'package:flutter/material.dart';

class SplashLoader extends StatefulWidget {
  @override
  _SplashLoaderState createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (BuildContext context, Widget? child) => Transform.rotate(
            angle: _rotationAnimation.value,
            child: child,
          ),
          child: Image.asset(
            'assets/images/splash_icons/splash_loader.png',
            width: 130,
            height: 140,
          ),
        ),
      );
}
