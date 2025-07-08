
import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure,void>> signOut();

  Future<bool> isSignedIn();
}
