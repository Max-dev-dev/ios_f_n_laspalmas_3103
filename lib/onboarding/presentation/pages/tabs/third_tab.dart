import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/onboarding/presentation/widgets/buttons/tab_button.dart';

class ThirdTab extends StatelessWidget {
  final VoidCallback onNext;

  ThirdTab({
    required this.onNext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Features Overview',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 24 : 18,
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
              height: 4,
            ),
          Text(
            '✔ Smart Location Finder – Find places based on your selected time.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 16 : 13,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '✔ Interactive Map – View and navigate locations easily.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 16 : 13,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '✔ City Culture Blog – Learn about Las Palmas.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 16 : 13,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '✔ Saved Places – Keep track of your favorite spots.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 16 : 13,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '✔ Location Randomizer – Get a random place suggestion.',
            style: TextStyle(
              color: AppColors.colorWhitePrimary,
              fontSize: screenWidth > 375 ? 16 : 13,
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
