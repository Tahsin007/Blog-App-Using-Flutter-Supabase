import 'package:currency_converter/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Either<Failure,String> signInWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Either<Failure,String> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String?> getCurrentUserId();

  Future<String?> getCurrentUserEmail();
}