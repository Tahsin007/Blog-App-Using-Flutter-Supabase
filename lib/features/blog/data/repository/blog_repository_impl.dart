import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/blog/data/data_source/blog_remote_datasource.dart';
import 'package:currency_converter/features/blog/data/model/blog_model.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  BlogRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog(BlogParams blogData) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        authorId: blogData.authorId,
        title: blogData.title,
        description: blogData.description,
        imageUrl: "",
        topics: blogData.topics,
        updatedAt: DateTime.now(),
      );

      final uploadedImgUrl = await remoteDataSource.uploadImage(
        blogData.image,
        blogModel,
      );
      blogModel = blogModel.copyWith(imageUrl: uploadedImgUrl);
      final uploadedBlog = await remoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final response = await remoteDataSource.getAllBlogs();
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
