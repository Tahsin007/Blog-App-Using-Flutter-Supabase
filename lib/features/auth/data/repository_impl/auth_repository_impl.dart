import 'dart:ffi';

import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:currency_converter/core/common/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<bool> isSignedIn() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure,void>> signOut() async{
    try {
      await authRemoteDataSource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userData = await authRemoteDataSource.getCurrentUser();
      if (userData == null) {
        print("User Not Logged In");
        return left(Failure("User Not Logged in"));
      }
      print(userData.id);

      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
