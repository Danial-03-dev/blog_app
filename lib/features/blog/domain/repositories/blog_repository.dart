import 'dart:typed_data';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  const BlogRepository();

  Future<Either<Failure, Blog>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
  Future<Either<Failure, List<Blog>>> getCurrentUserBlogs();

  Future<Either<Failure, void>> deleteBlog({required String blogId});
}
