import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.posterId,
    super.posterName,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson({required Map<String, dynamic> blog}) {
    return BlogModel(
      id: blog['id'] as String,
      posterId: blog['poster_id'] as String,
      title: blog['title'] as String,
      content: blog['content'] as String,
      imageUrl: blog['image_url'] as String,
      topics: List<String>.from(blog['topics'] ?? []),
      updatedAt: blog['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(blog['updated_at']),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? posterName,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      posterName: posterName ?? this.posterName,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
