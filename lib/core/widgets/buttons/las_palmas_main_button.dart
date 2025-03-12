import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';

class LasPalmasMainButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const LasPalmasMainButton({
    required this.onTap,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorWhitePrimary,
              width: 1,
            ),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFFBF9A30),
                Color(0xFFE7C563),
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 20.0,
                color: AppColors.colorBlackPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
}
