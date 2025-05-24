import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  String labelText;
  String hintText;
  TextInputType keyboardType;
  String validationMessage;
  final TextEditingController? controller;
  bool obscureText;

  AuthField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.validationMessage,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, hintText: hintText),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
