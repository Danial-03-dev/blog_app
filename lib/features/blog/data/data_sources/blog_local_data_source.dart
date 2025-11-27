import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract interface class BlogLocalDataSource {
  const BlogLocalDataSource();

  void uploadLocalBlogs({required List<BlogModel> blogs});

  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  const BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    return box.values
        .map(
          (blog) => BlogModel.fromJson(blog: Map<String, dynamic>.from(blog)),
        )
        .toList();
  }

  @override
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs}) async {
    await box.clear();

    for (final blog in blogs) {
      await box.add(blog.toJson());
    }
  }
}
