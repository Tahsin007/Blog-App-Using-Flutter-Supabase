import 'package:currency_converter/core/common/widgets/loader.dart';
import 'package:currency_converter/core/theme/app_pallete.dart';
import 'package:currency_converter/core/theme/app_textstyles.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool isLoading;
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLoading) {
          null;
        } else {
          onPressed();
        }
        // Handle button tap
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPallete.primaryColor, AppPallete.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: AppPallete.primaryColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: isLoading ? AppLoader() : 
        Center(
          child: Text(
            buttonText,
            style: AppTextStyle.buttonMedium.copyWith(color: AppPallete.white),
          ),
        ),
      ),
    );
  }
}
