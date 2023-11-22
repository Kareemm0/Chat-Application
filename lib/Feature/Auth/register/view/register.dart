import 'package:chat_app/Feature/Auth/register/view/widget/custom_text_form_filed_section.dart';
import 'package:chat_app/core/utils/app_string.dart';
import 'package:chat_app/core/widget/custom_auth_title.dart';
import 'package:chat_app/core/widget/custom_image.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = "/RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageWidget(),
            CustomAuthTitle(
              title: AppString.registerTitle,
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextFormFiledSection(),
          ],
        ),
      ),
    );
  }
}
