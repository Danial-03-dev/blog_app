part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {
  const BlogEvent();
}

final class BlogUploadEvent extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final Uint8List image;
  final List<String> topics;

  const BlogUploadEvent({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class BlogGetAllBlogsEvent extends BlogEvent {}

final class BlogGetCurrentUserBlogsEvent extends BlogEvent {}

final class BlogDeleteEvent extends BlogEvent {
  final String blogId;

  const BlogDeleteEvent({required this.blogId});
}
