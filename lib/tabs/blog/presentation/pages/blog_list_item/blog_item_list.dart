import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/widgets/blog_button.dart';

class BlogListItem extends StatelessWidget {
  final String title;
  final String readingTime;
  final VoidCallback onReadPressed;
  final VoidCallback onSharePressed;

  const BlogListItem({
    Key? key,
    required this.title,
    required this.readingTime,
    required this.onReadPressed,
    required this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        color: AppColors.colorBlackPrimary,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: AppColors.colorWhitePrimary,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 7),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorWhitePrimary,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                readingTime,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.colorWhitePrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  BlogButton(
                    onTap: onReadPressed,
                    buttonText: 'Read',
                  ),
                  const SizedBox(width: 12.0),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.colorWhitePrimary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: onSharePressed,
                      icon: const Icon(Icons.share, color: AppColors.colorWhitePrimary),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
