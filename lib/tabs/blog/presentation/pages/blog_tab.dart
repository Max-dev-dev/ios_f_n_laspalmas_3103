// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/utils/di_container/di_container.dart';
import 'package:momento_las_palmas/tabs/blog/data/models/blog_model.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/cubit/blog_cubit/blog_cubit.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/cubit/blog_cubit/blog_state.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/pages/blog_item/blog_item.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/pages/blog_list_item/blog_item_list.dart';
import 'package:share_plus/share_plus.dart';

class BlogTab extends StatefulWidget {
  const BlogTab({Key? key}) : super(key: key);

  @override
  _BlogTabState createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  BlogModel? _selectedBlog;
  bool _isArticleOpen = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _isArticleOpen = _tabController.index == 1;
      });
    });
  }

  void _openBlog(BlogModel blog) {
    setState(() {
      _selectedBlog = blog;
      _tabController.animateTo(1);
    });
  }

  void _closeBlog() {
    setState(() {
      _selectedBlog = null;
      _tabController.animateTo(0);
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<BlogCubit>(),
        child: BlocBuilder<BlogCubit, BlogState>(
          builder: (BuildContext context, BlogState state) => state.when(
            initial: () => const Center(
              child: Text(
                'Initializing...',
                style: TextStyle(color: AppColors.colorWhitePrimary),
              ),
            ),
            loading: () => const Center(
                child: CircularProgressIndicator(
                    color: AppColors.colorWhitePrimary)),
            loaded: (List<BlogModel> blogs) => Column(
              children: <Widget>[
                const SizedBox(height: 28),
                if (!_isArticleOpen)
                  const Text(
                    'Cultural Blog:',
                    style: TextStyle(
                      color: AppColors.colorWhitePrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _buildBlogList(blogs),
                      BlogItem(
                        blog: _selectedBlog,
                        onClose: _closeBlog,
                        onShareText: () {
                          if (_selectedBlog != null) {
                            _shareText(_selectedBlog!);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            error: (String message) => const Center(
              child: Text(
                'Error loading blogs',
                style: TextStyle(color: AppColors.colorWhitePrimary),
              ),
            ),
          ),
        ),
      );

  Widget _buildBlogList(List<BlogModel> blogs) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: blogs.length,
        itemBuilder: (BuildContext context, int index) {
          final BlogModel blog = blogs[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == blogs.length - 1 ? 100.0 : 8.0,
            ),
            child: BlogListItem(
              title: blog.title,
              readingTime: "~5 minutes of reading",
              onReadPressed: () => _openBlog(blog),
              onSharePressed: () => _shareText(blog),
            ),
          );
        },
      );

  void _shareText(BlogModel blog) {
    final String shareText =
        'Read about this place: ${blog.title}\n\n${blog.paragraphOne}\n\n${blog.paragraphTwo}';
    Share.share(shareText);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
