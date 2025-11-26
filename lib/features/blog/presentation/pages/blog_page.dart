import 'package:blog_app/core/common/widgets/custom_scroll_config.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/appbars/blog_page_appbar.dart';
import 'package:blog_app/features/blog/presentation/widgets/lists/blogs_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();

    context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlogPageAppBar(),
      body: CustomScrollConfig(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlogsList(),
        ),
      ),
    );
  }
}
