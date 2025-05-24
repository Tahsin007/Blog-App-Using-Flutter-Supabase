import 'package:currency_converter/core/error/failure.dart';
import 'package:currency_converter/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure,User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure,User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String?> getCurrentUserId();

  Future<String?> getCurrentUserEmail();
}