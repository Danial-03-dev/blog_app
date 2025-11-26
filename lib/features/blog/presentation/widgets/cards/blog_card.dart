import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/widgets/lists/blog_card_category_list.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color? color;

  const BlogCard({super.key, required this.blog, this.color});

  @override
  Widget build(BuildContext context) {
    final readingTime = calculateReadingTime(blog.content);

    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  BlogCardCategoryList(categoryList: blog.topics),
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text('$readingTime min'),
            ],
          ),
        ),
      ),
    );
  }
}
