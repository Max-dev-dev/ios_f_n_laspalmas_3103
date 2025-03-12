import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.colorGradientFirst,
            AppColors.colorGradientSecond,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
}
