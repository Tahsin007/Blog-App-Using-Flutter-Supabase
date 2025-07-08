import 'package:currency_converter/core/error/exceptions.dart';
import 'package:currency_converter/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  final loggedInUser = Supabase.instance.client;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException("User is null, sign in failed");
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException('Failed to sign In: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException("User is null, sign up failed");
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);
        print(
          "User access Token: ${supabaseClient.auth.currentSession?.accessToken}",
        );
        print("User Name : ${userData}");
        return UserModel.fromJson(userData.first);
      }
      return null;
    } catch (e) {
      throw ServerException('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  
  @override
  Future<void> signOut() async{
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException('Failed to sign out: ${e.toString()}');
    }
  }
}
