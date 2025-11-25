import 'package:flutter/material.dart';

class AddNewBlogPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddNewBlogPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
