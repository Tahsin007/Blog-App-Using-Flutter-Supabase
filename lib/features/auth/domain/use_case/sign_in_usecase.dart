import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/features/auth/domain/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInUseCase implements UseCase<User, UserSignInParams> {
  final AuthRepository authRepo;
  SignInUseCase(this.authRepo);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepo.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({required this.email, required this.password});
}
