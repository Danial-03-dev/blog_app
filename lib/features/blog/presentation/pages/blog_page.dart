import 'package:blog_app/features/blog/presentation/widgets/appbars/blog_page_appbar.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: BlogPageAppBar());
  }
}
