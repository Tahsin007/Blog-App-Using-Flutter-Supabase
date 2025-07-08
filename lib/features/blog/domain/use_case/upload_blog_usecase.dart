import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<Blog, BlogParams> {
  final BlogRepository blogRepo;
  UploadBlogUsecase(this.blogRepo);
  @override
  Future<Either<Failure, Blog>> call(BlogParams params) async {
    return await blogRepo.uploadBlog(params);
  }
}
