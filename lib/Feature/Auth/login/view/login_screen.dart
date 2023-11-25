import 'package:chat_app/Feature/Auth/login/view/widget/custom_elevated_button.dart';
import 'package:chat_app/Feature/Auth/login/view/widget/custom_text_forgetpassword.dart';
import 'package:chat_app/Feature/Auth/register/view/register.dart';
import 'package:chat_app/Feature/profile/view/profile_screen.dart';
import 'package:chat_app/core/function/snak_bar.dart';
import 'package:chat_app/core/function/vaildator_function.dart';
import 'package:chat_app/core/utils/app_string.dart';
import 'package:chat_app/core/widget/custom_auth_title.dart';
import 'package:chat_app/core/widget/custom_image.dart';
import 'package:chat_app/core/widget/custom_row_text.dart';
import 'package:chat_app/core/widget/custom_text_form_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const routName = "/LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFouceNode;
  late FocusNode passwordFouceNode;

  bool? isCheck = false;
  bool obsecure = false;

  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  bool isloading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFouceNode = FocusNode();
    passwordFouceNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFouceNode.dispose();
    passwordFouceNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final isVaild = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVaild) {
      setState(() {});
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        showSnakBar(context, "Success");
        Navigator.pushNamed(context, ProfileScreen.routName,
            arguments: emailController.text);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'user-not-found') {
          showSnakBar(context, "User Not Found");
        } else if (error.code == 'wrong-password') {
          showSnakBar(context, "Wrong Password");
        }
      } catch (error) {
        showSnakBar(context, "There Was an Error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomImageWidget(),
                const CustomAuthTitle(
                  title: AppString.loginTitle,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Email Filed
                        CustomTextFromFiled(
                          validator: (value) {
                            return AppValidator.emailValidator(value);
                          },
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                          text: "email",
                          focusNode: emailFouceNode,
                          icon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.clear),
                          ),
                          onFieldSubmitted: (vlaue) {
                            FocusScope.of(context)
                                .requestFocus(passwordFouceNode);
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        // Password Filed
                        CustomTextFromFiled(
                          validator: (value) {
                            return AppValidator.passwordValidator(value);
                          },
                          obscureText: obsecure,
                          onFieldSubmitted: (val) {
                            login();
                          },
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          text: "Password",
                          focusNode: passwordFouceNode,
                          icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obsecure = !obsecure;
                                });
                              },
                              icon: obsecure
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                        const CustomTextForgetPassword(),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomElevatedButton(
                          text: "Login",
                          onPressed: () {
                            login();
                          },
                        ),
                        CustomRowText(
                            text: AppString.accountDontHave,
                            authText: "Register",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routName);
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
