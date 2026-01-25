import 'dart:typed_data';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/get_current_user_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  final GetCurrentUserBlogs _getCurrentUserBlogs;
  final DeleteBlog _deleteBlog;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
    required GetCurrentUserBlogs getCurrentUserBlogs,
    required DeleteBlog deleteBlog,
  }) : _uploadBlog = uploadBlog,
       _getAllBlogs = getAllBlogs,
       _getCurrentUserBlogs = getCurrentUserBlogs,
       _deleteBlog = deleteBlog,
       super(BlogInitialState()) {
    on<BlogUploadEvent>(_onBlogUpload);
    on<BlogGetAllBlogsEvent>(_onBlogsGetAllBlogs);
    on<BlogGetCurrentUserBlogsEvent>(_onBlogsGetCurrentUserBlogs);
    on<BlogDeleteEvent>(_onDeleteBlog);
  }

  void _onBlogUpload(BlogUploadEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoadingState());

    final response = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    void onFailure(Failure failure) {
      emit(BlogFailureState(message: failure.message));
    }

    void onSuccess(Blog blog) {
      emit(BlogUploadSuccessState());
    }

    response.fold(onFailure, onSuccess);
  }

  void _onBlogsGetAllBlogs(
    BlogGetAllBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoadingState());

    final response = await _getAllBlogs(NoParams());

    void onFailure(Failure failure) {
      emit(BlogFailureState(message: failure.message));
    }

    void onSuccess(List<Blog> blogs) {
      emit(BlogGetAllBlogsSuccessState(blogs: blogs));
    }

    response.fold(onFailure, onSuccess);
  }

  void _onBlogsGetCurrentUserBlogs(
    BlogGetCurrentUserBlogsEvent event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoadingState());

    final response = await _getCurrentUserBlogs(NoParams());

    void onFailure(Failure failure) {
      emit(BlogFailureState(message: failure.message));
    }

    void onSuccess(List<Blog> blogs) {
      emit(BlogGetAllBlogsSuccessState(blogs: blogs));
    }

    response.fold(onFailure, onSuccess);
  }

  void _onDeleteBlog(BlogDeleteEvent event, Emitter<BlogState> emit) async {
    final response = await _deleteBlog(DeleteBlogParams(blogId: event.blogId));

    void onFailure(Failure failure) {
      emit(BlogFailureState(message: failure.message));
    }

    void onSuccess(void _) {
      if (state is BlogGetAllBlogsSuccessState) {
        final currentState = state as BlogGetAllBlogsSuccessState;

        final updatedBlogs = currentState.blogs.where((blog) {
          return blog.id != event.blogId;
        }).toList();

        emit(BlogGetAllBlogsSuccessState(blogs: updatedBlogs));
      }
    }

    response.fold(onFailure, onSuccess);
  }
}
