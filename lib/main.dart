import 'package:chat_app/Feature/Auth/login/view/login_screen.dart';
import 'package:chat_app/Feature/Auth/register/view/register.dart';
import 'package:chat_app/Feature/Chat/view/chat.dart';
import 'package:chat_app/Feature/profile/view/profile_screen.dart';
import 'package:chat_app/core/utils/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: const LoginScreen(),
          routes: {
            LoginScreen.routName: (context) => const LoginScreen(),
            RegisterScreen.routName: (context) => const RegisterScreen(),
            ChatScreen.routName: (context) => ChatScreen(),
            ProfileScreen.routName: (context) => const ProfileScreen(),
          },
        );
      },
    );
  }
}
