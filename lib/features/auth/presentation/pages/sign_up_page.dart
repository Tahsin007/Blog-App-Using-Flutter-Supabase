import 'package:currency_converter/features/auth/presentation/pages/sign_in_page.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_button.dart';
import 'package:currency_converter/features/auth/presentation/widgets/auth_field.dart';
import 'package:currency_converter/features/auth/presentation/widgets/rich_text.dart';
import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: Material(
        child: Form(
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
                      // Handle sign up logic
                      print('Sign Up');
                    } else {
                      // Handle validation error
                      print('Validation Error');
                    }
                  },
                  buttonText: 'Sign Up',
                ),
                const SizedBox(height: 16),
                AuthRichText(
                  firstText: "Already Have An Account? ",
                  secondText: "Sign In",
                  ontap: () {
                    Navigator.push(context, SignInPage.route());
                  },
                ),
                // RichText(
                //   textAlign: TextAlign.center,
                //   text: TextSpan(
                //     text: "Already have an account? ",
                //     style: AppTextStyle.bodySmall,
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: 'Login here',
                //         style: AppTextStyle.bodySmall.copyWith(
                //           color: AppPallete.primaryColor,
                //         ),
                //         recognizer:
                //             TapGestureRecognizer()
                //               ..onTap = () {
                //                 // Handle login tap
                //               },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
