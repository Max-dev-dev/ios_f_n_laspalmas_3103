import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/onboarding/presentation/widgets/buttons/tab_button.dart';

class SecondTab extends StatelessWidget {
  final VoidCallback onNext;

  SecondTab({
    required this.onNext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'How It Works?',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.left,
          ),
          if (screenWidth > 375)
            const SizedBox(
              height: 16,
            )
          else
            const SizedBox(
              height: 12,
            ),
          const Text(
            '🔹 Choose a time – Enter the time you want to explore.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          const Text(
            '🔹 Get recommendations – The app finds the best places for that time.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          if (screenWidth > 375)
            const SizedBox(
              height: 16,
            )
          else
            const SizedBox(
              height: 12,
            ),
          TabButton(
            onTap: onNext,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
