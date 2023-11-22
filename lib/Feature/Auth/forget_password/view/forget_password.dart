import 'package:chat_app/Feature/Auth/login/view/widget/custom_elevated_button.dart';
import 'package:chat_app/core/function/vaildator_function.dart';
import 'package:chat_app/core/utils/app_router.dart';
import 'package:chat_app/core/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController forgetPasswordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    forgetPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    forgetPasswordController.dispose();
    super.dispose();
  }

  Future<void> fogetPassword() async {
    final isvalid = formKey.currentState!.validate();
    if (isvalid) {
      GoRouter.of(context).push(AppRouter.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Forget Password",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFromFiled(
                  controller: forgetPasswordController,
                  text: "Enter Your Email Address",
                  icon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.clear,
                      )),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return AppValidator.emailValidator(value);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomElevatedButton(
                  text: "Confirm",
                  onPressed: () {
                    fogetPassword();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
