import 'package:blog_app/features/blog/presentation/widgets/blog_category_chip.dart';
import 'package:flutter/widgets.dart';

class BlogCardCategoryList extends StatelessWidget {
  final List<String> categoryList;

  const BlogCardCategoryList({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: categoryList
            .map((category) => BlogCategoryChip(label: category))
            .toList(),
      ),
    );
  }
}
