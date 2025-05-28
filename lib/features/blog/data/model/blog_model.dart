import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.authorId,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.authorName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      topics: List<String>.from(json['topics'] as List),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? authorId,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? authorName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      authorName: authorName ?? this.authorName,
    );
  }
}
