import 'package:currency_converter/core/secrets/app_secrets.dart';
import 'package:currency_converter/features/auth/data/data_source/remote/auth_remote.dart';
import 'package:currency_converter/features/auth/data/repository_impl/auth_repository_impl.dart';
import 'package:currency_converter/features/auth/domain/use_case/sign_up_usecase.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final supaBase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          signUpUseCase: SignUpUsecase(AuthRepositoryImpl(
            AuthRemoteDataSourceImpl(supaBase.client)
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home:  SignInPage(),
    );
  }
}