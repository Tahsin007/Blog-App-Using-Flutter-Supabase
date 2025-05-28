import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:currency_converter/features/blog/domain/entities/blog_entity.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetAllBlogsUsecase implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepo;
  GetAllBlogsUsecase(this.blogRepo);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepo.getAllBlogs();
  }
}
