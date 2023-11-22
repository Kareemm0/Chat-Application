import 'package:chat_app/core/utils/app_router.dart';
import 'package:chat_app/core/utils/app_string.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTextForgetPassword extends StatelessWidget {
  const CustomTextForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).push(AppRouter.forgetPassword);
      },
      child: const Text(
        AppString.forgetPassword,
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
