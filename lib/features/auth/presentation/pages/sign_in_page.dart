import 'package:currency_converter/core/utils/snack_bar.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_up_page.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_button.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_field.dart';
import 'package:currency_converter/features/auth/presentation/widgets/rich_text.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:currency_converter/features/blog/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formState = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              showSnackBar(
                message: "Sign In Successful, Welcome ${state.user.name}",
                context: context,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage(state.user)),
              );
            } else if (state is AuthFailure) {
              showSnackBar(
                message: "Sign In Failed : ${state.message}",
                context: context,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Sign In", style: AppTextStyle.h1),
                    const SizedBox(height: 32),
                    AuthField(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validationMessage: 'Please enter a valid email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    AuthField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.visiblePassword,
                      validationMessage: 'Please enter a password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    AuthButton(
                      onPressed: () {
                        if (formState.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            AuthSignIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        } else {
                          print('Validation Error');
                        }
                      },
                      buttonText: 'Sign In',
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 16.0),
                    AuthRichText(
                      firstText: "Don't Have An Account? ",
                      secondText: "Sign Up",
                      ontap: () {
                        Navigator.push(context, SignUpPage.route());
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
