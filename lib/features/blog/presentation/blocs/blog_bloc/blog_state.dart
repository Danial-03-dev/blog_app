part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitialState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogFailureState extends BlogState {
  final String message;

  const BlogFailureState({required this.message});
}

final class BlogUploadSuccessState extends BlogState {}

final class BlogGetAllBlogsSuccessState extends BlogState {
  final List<Blog> blogs;

  const BlogGetAllBlogsSuccessState({required this.blogs});
}
