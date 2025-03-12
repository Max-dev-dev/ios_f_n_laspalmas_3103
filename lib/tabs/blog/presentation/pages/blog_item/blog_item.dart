import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/tabs/blog/data/models/blog_model.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/widgets/blog_button.dart';

class BlogItem extends StatelessWidget {
  final BlogModel? blog;
  final VoidCallback onClose;
  final VoidCallback onShareText;

  const BlogItem({
    required this.blog,
    required this.onClose,
    required this.onShareText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (blog == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.colorWhitePrimary,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.colorBlackPrimary,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: onClose,
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.chevron_left,
                      color: Color(0xFFBF9A30),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                const Text(
                  'Reading:',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.colorWhitePrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Text(
              blog!.title,
              style: const TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Text(
              blog!.paragraphOne,
              style: const TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Text(
              blog!.paragraphTwo,
              style: const TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 18)),
          SliverToBoxAdapter(
            child: Row(
              children: <Widget>[
                BlogButton(
                  onTap: onClose,
                  buttonText: 'Close',
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
                    onPressed: onShareText,
                    icon: const Icon(Icons.share, color: AppColors.colorWhitePrimary),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 130)),
        ],
      ),
    );
  }
}
