import 'package:chat_app/Feature/Auth/login/view/login_screen.dart';
import 'package:chat_app/Feature/Auth/register/view/register.dart';
import 'package:chat_app/Feature/Chat/view/chat.dart';
import 'package:chat_app/Feature/profile/view/profile_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const path = "/";
  static const register = "/regiter";
  static const profile = "/profile";
  static const forgetPassword = "/forgetPassword";
  static const chats = "/chats";

  static final goRouter = GoRouter(routes: [
    GoRoute(
      path: path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: chats,
      builder: (context, state) => ChatScreen(),
    ),
  ]);
}
