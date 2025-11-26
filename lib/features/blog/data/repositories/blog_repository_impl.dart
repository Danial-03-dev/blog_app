import 'dart:typed_data';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  const BlogRepositoryImpl({required this.blogRemoteDataSource});

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required Uint8List image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    BlogModel blog = BlogModel(
      id: Uuid().v1(),
      posterId: posterId,
      title: title,
      content: content,
      imageUrl: '',
      topics: topics,
      updatedAt: DateTime.now(),
    );

    try {
      final imageUrl = await blogRemoteDataSource.uploadBlogImg(
        image: image,
        blog: blog,
      );

      final blogWithImgUrl = blog.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(
        blog: blogWithImgUrl,
      );

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
