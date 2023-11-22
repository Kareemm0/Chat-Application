import 'package:chat_app/Feature/Auth/login/view/widget/custom_elevated_button.dart';
import 'package:chat_app/Feature/profile/view/profile_screen.dart';
import 'package:chat_app/core/function/snak_bar.dart';
import 'package:chat_app/core/function/vaildator_function.dart';
import 'package:chat_app/core/utils/app_router.dart';
import 'package:chat_app/core/utils/app_string.dart';
import 'package:chat_app/core/widget/custom_row_text.dart';
import 'package:chat_app/core/widget/custom_text_form_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomTextFormFiledSection extends StatefulWidget {
  const CustomTextFormFiledSection({super.key});

  @override
  State<CustomTextFormFiledSection> createState() =>
      _CustomTextFormFiledSectionState();
}

class _CustomTextFormFiledSectionState
    extends State<CustomTextFormFiledSection> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late FocusNode userNameFouceNode;
  late FocusNode emailFouceNode;
  late FocusNode passwordFouceNode;

  bool? isCheck = false;
  final formKey = GlobalKey<FormState>();
  bool isObsecure = true;

  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    // Controller
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // FoucsNode
    userNameFouceNode = FocusNode();
    emailFouceNode = FocusNode();
    passwordFouceNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    userNameFouceNode.dispose();
    emailFouceNode.dispose();
    passwordFouceNode.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final isVaild = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {
      isLoading = true;
      setState(() {});
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        showSnakBar(context, "Success");
        Navigator.pushNamed(context, ProfileScreen.routName,
            arguments: emailController.text);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          showSnakBar(context, "Weak Password");
        } else if (error.code == 'email-already-in-use') {
          showSnakBar(context, "Email Already in Use");
        }
      } catch (error) {
        showSnakBar(context, "There Was an Error");
        isLoading = false;
        setState(() {});
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // UserName Filed
                    CustomTextFromFiled(
                      controller: userNameController,
                      text: "UserName",
                      icon: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.clear)),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return AppValidator.displayNamevalidator(value);
                      },
                      focusNode: userNameFouceNode,
                      onFieldSubmitted: (vlaue) {
                        FocusScope.of(context).requestFocus(emailFouceNode);
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // email
                    CustomTextFromFiled(
                      validator: (value) {
                        return AppValidator.emailValidator(value);
                      },
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      text: "Email",
                      focusNode: emailFouceNode,
                      icon: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.clear)),
                      onFieldSubmitted: (vlaue) {
                        FocusScope.of(context).requestFocus(passwordFouceNode);
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomTextFromFiled(
                        validator: (value) {
                          return AppValidator.passwordValidator(value);
                        },
                        obscureText: isObsecure,
                        onFieldSubmitted: (val) {},
                        textInputAction: TextInputAction.done,
                        controller: passwordController,
                        text: "Password",
                        focusNode: passwordFouceNode,
                        icon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: isObsecure
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility))),

                    const SizedBox(
                      height: 30,
                    ),
                    CustomElevatedButton(
                      text: "Register",
                      onPressed: () {
                        register();
                      },
                    ),
                    CustomRowText(
                      authText: "Login",
                      text: AppString.haveAccount,
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.path);
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
