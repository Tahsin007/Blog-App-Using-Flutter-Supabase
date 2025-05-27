import 'package:currency_converter/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:currency_converter/core/common/widgets/loader.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/features/blog/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state is AppUserLoggedIn) {
              final user = state.user;
              return HomePage(user);
            }
            return const SignInPage();
          },
        ),
      ),
    );
  }
}
