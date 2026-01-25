import 'dart:typed_data';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/utils/detect_image_mime_type.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

abstract interface class BlogRemoteDataSource {
  const BlogRemoteDataSource();

  Future<BlogModel> uploadBlog({required BlogModel blog});

  Future<String> uploadBlogImg({
    required Uint8List image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
  Future<List<BlogModel>> getCurrentUserBlogs();

  Future<void> deleteBlog({required String blogId});
}

class BlogRemoteDataSourceImpl extends BlogRemoteDataSource {
  final sb.SupabaseClient supabaseClient;

  const BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();

      return BlogModel.fromJson(blog: blogData.first);
    } on sb.PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImg({
    required Uint8List image,
    required BlogModel blog,
  }) async {
    try {
      final String path = blog.id;
      final String table = 'blog_images';

      final mimeType = detectImageMimeType(image);

      await supabaseClient.storage
          .from(table)
          .uploadBinary(
            path,
            image,
            fileOptions: sb.FileOptions(contentType: mimeType),
          );
      return supabaseClient.storage.from(table).getPublicUrl(path);
    } on sb.StorageException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)');

      return blogs
          .map(
            (blog) => BlogModel.fromJson(
              blog: blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } on sb.PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getCurrentUserBlogs() async {
    try {
      final user = supabaseClient.auth.currentUser;

      if (user == null) {
        throw ServerException(message: 'User not logged in');
      }

      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)')
          .eq('poster_id', user.id);

      return blogs
          .map(
            (blog) => BlogModel.fromJson(
              blog: blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } on sb.PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteBlog({required String blogId}) async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw ServerException(message: 'User not logged in');
      }

      await supabaseClient
          .from('blogs')
          .delete()
          .eq('id', blogId)
          .eq('poster_id', user.id);
    } on sb.PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
