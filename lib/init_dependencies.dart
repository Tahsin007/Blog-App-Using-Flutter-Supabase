import 'package:currency_converter/core/secrets/app_secrets.dart';
import 'package:currency_converter/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:currency_converter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_in_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_up_usecase.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supaBase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supaBase.client);
  _initAuth();

}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => SignUpUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => SignInUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(serviceLocator(),serviceLocator()),
  );
}
