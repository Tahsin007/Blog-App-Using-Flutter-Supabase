import 'package:currency_converter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:currency_converter/core/common/entities/user_entity.dart';
import 'package:currency_converter/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_in_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_out_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_up_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final SignInUseCase _signInUseCase;
  final CurrentUserUsecase _currentUserUsecase;
  final SignOutUsecase _signOutUsecase;
  final AppUserCubit _appUserCubit;

  AuthBloc(
    this._signInUseCase,
    this._signUpUsecase,
    this._currentUserUsecase,
    this._signOutUsecase,
    this._appUserCubit,
  ) : super(AuthInitial()) {
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthIsUserLoggedIn>(_checkStatus);
    on<AuthSignOut>(_onSignOut);
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signOutUsecase.call(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthInitial()),
    );
  }

  //Those are the functions for every events
  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signUpUsecase.call(
      UserSignUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );
    res.fold((failure) => emit(AuthFailure(message: failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signInUseCase.call(
      UserSignInParams(email: event.email, password: event.password),
    );
    res.fold((failure) => emit(AuthFailure(message: failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }

  Future<void> _checkStatus(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    // Your check status logic here
    emit(AuthLoading());
    final res = await _currentUserUsecase.call(NoParams());
    res.fold((failure) => emit(AuthFailure(message: failure.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(AuthSuccess(user));
    });
  }
}
