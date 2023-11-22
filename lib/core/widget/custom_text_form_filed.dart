import 'package:flutter/material.dart';

class CustomTextFromFiled extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final FocusNode? focusNode;
  final IconButton icon;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?) validator;
  final bool obscureText;
  const CustomTextFromFiled({
    super.key,
    required this.controller,
    required this.text,
    this.focusNode,
    required this.icon,
    required this.textInputAction,
    this.onFieldSubmitted,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: text,
        suffixIcon: icon,
      ),
    );
  }
}
