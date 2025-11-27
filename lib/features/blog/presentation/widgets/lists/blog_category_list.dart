import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_category_chip.dart';
import 'package:flutter/material.dart';

class BlogCategoryList extends StatelessWidget {
  final List<String> selectedTopics;
  final void Function(String)? handleCategorySelect;
  const BlogCategoryList({
    super.key,
    required this.selectedTopics,
    this.handleCategorySelect,
  });

  @override
  Widget build(BuildContext context) {
    final categoryList = Constants.categoryList;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: categoryList
            .map(
              (category) => BlogCategoryChip(
                label: category,
                onPressed: () {
                  if (handleCategorySelect == null) return;
                  handleCategorySelect!(category);
                },
                isActive: selectedTopics.contains(category),
              ),
            )
            .toList(),
      ),
    );
  }
}
