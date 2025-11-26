import 'package:flutter/material.dart';

class AddNewBlogPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? handleAddBlog;

  const AddNewBlogPageAppBar({super.key, this.handleAddBlog});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(onPressed: handleAddBlog, icon: Icon(Icons.done_rounded)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
