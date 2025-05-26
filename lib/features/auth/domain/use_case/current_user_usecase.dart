import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/core/common/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecase implements UseCase<User, NoParams> {
  final AuthRepository authRepo;
  CurrentUserUsecase(this.authRepo);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepo.getCurrentUser();
  }
}

class NoParams {}
