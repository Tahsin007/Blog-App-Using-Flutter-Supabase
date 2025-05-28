import 'package:currency_converter/core/utils/snack_bar.dart';
import 'package:currency_converter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_button.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_field.dart';
import 'package:currency_converter/features/auth/presentation/widgets/rich_text.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formState = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(message: "Sign Up Failed : ${state.message}", context: context);
            } else if (state is AuthSuccess) {
              showSnackBar(message: "Sign Up Successful, Welcome ${state.user.name}", context: context);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Form(
              key: formState,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 32),
                    Text("Sign Up", style: AppTextStyle.h1),
                    const SizedBox(height: 32),
                    AuthField(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      keyboardType: TextInputType.name,
                      validationMessage: 'Please enter your name',
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
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
                            AuthSignUp(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                          if (kDebugMode) {
                            print('Sign Up Successful');
                          }
                          // print('Sign Up');
                        } else {
                          // Handle validation error
                          print('Validation Error');
                        }
                      },
                      buttonText: 'Sign Up',
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 16),
                    AuthRichText(
                      firstText: "Already Have An Account? ",
                      secondText: "Sign In",
                      ontap: () {
                        Navigator.push(context, SignInPage.route());
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
