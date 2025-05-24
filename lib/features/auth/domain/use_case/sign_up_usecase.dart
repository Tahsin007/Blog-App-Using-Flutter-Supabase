import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/features/auth/domain/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignUpUsecase implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  SignUpUsecase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String password;
  final String email;

  UserSignUpParams({
    required this.email,
    required this.name,
    required this.password,
  });
}
