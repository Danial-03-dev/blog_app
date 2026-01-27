import 'package:blog_app/core/common/widgets/buttons/logout_button.dart';
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
      title: const Text('Shared Thoughts'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: handleAddBlog,
                icon: const Icon(Icons.add_circle_outline),
              ),
              LogoutButton(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
