import 'package:currency_converter/features/auth/domain/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_in_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUseCase _signInUseCase;

  AuthBloc(this._signInUseCase, this._signUpUsecase):
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      //Loading State
      emit(AuthLoading());

      final res = await _signUpUsecase.call(
        UserSignUpParams(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      res.fold(
        (failure) {
          emit(AuthFailure(message: failure.message));
        },
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });

    on<AuthSignIn>((event, emit) async {
      //Loading State
      emit(AuthLoading());

      final res = await _signInUseCase.call(
        UserSignInParams(email: event.email, password: event.password),
      );
      res.fold(
        (failure) {
          emit(AuthFailure(message: failure.message));
        },
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });
  }
}
