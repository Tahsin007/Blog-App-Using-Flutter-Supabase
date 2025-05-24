import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback ontap;
  const AuthRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: firstText,
        style: AppTextStyle.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: AppTextStyle.bodyMedium.copyWith(
              color: AppPallete.primaryColor,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    ontap();
                  },
          ),
        ],
      ),
    );
  }
}
