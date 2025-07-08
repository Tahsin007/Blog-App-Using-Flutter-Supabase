import 'package:currency_converter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:currency_converter/core/secrets/app_secrets.dart';
import 'package:currency_converter/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:currency_converter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:currency_converter/features/auth/domain/repository/auth_repository.dart';
import 'package:currency_converter/features/auth/domain/use_case/current_user_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_in_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_out_usecase.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_up_usecase.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/blog/data/data_source/blog_remote_datasource.dart';
import 'package:currency_converter/features/blog/data/repository/blog_repository_impl.dart';
import 'package:currency_converter/features/blog/domain/repository/blog_repository.dart';
import 'package:currency_converter/features/blog/domain/use_case/get_all_blogs_usecase.dart';
import 'package:currency_converter/features/blog/domain/use_case/upload_blog_usecase.dart';
import 'package:currency_converter/features/blog/presentation/bloc/blog_bloc.dart';
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
  _initBlog();

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    //Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    //Use Cases
    ..registerFactory(() => SignUpUsecase(serviceLocator()))
    ..registerFactory(() => SignInUseCase(serviceLocator()))
    ..registerFactory(() => CurrentUserUsecase(serviceLocator()))
    ..registerFactory(() => SignOutUsecase(serviceLocator()))
    //Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<UploadBlogUsecase>(
      () => UploadBlogUsecase(serviceLocator()),
    )
    ..registerFactory<GetAllBlogsUsecase>(() => GetAllBlogsUsecase(serviceLocator()))
    ..registerLazySingleton<BlogBloc>(() => BlogBloc(serviceLocator(),serviceLocator()));
}
