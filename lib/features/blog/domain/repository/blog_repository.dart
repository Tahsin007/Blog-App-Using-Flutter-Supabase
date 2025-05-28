import 'dart:io';

import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(BlogParams blogData);
  Future<Either<Failure,List<Blog>>> getAllBlogs();
}

class BlogParams {
  final File image;
  final String title;
  final String description;
  final String authorId;
  final List<String> topics;
  BlogParams({
    required this.image,
    required this.authorId,
    required this.description,
    required this.title,
    required this.topics,
  });
}
