import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlogPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    void handleAddBlog() {
      Navigator.push(context, AddNewBlogPage.route());
    }

    return AppBar(
      title: const Text('Blog App'),
      actions: [
        IconButton(
          onPressed: handleAddBlog,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
