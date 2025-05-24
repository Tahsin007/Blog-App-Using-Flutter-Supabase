import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<String?> getCurrentUserEmail() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getCurrentUserId() {
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId.toString());
    }on ServerException catch(e) {
      return left(Failure(e.message));
    }
  }
}
