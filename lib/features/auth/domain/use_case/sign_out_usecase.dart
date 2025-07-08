import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/usecase/use_case.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:currency_converter/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:fpdart/fpdart.dart';

class SignOutUsecase implements UseCase <void,NoParams> {
  final AuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _authRepository.signOut();
    // return Future.value(Right(null)); // Assuming signOut does not return a value
  }


}