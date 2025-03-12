import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;

  const TabButton({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFFBF9A30),
                Color(0xFFE7C563),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Center(
            child: Text(
              'Continue →',
              style: TextStyle(
                fontSize: 20.0,
                color: AppColors.colorBlackPrimary,
              ),
            ),
          ),
        ),
      );
}
