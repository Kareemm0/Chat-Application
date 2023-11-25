import 'package:chat_app/Feature/Auth/login/view/login_screen.dart';
import 'package:chat_app/Feature/Auth/register/view/register.dart';
import 'package:chat_app/Feature/Chat/view/chat.dart';
import 'package:chat_app/Feature/profile/notifications/notification.dart';
import 'package:chat_app/Feature/profile/view/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgoundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  debugPrint(
    (await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestPermission())
        .toString(),
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgoundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routName: (context) => const LoginScreen(),
        RegisterScreen.routName: (context) => const RegisterScreen(),
        ChatScreen.routName: (context) => ChatScreen(),
        ProfileScreen.routName: (context) => const ProfileScreen(),
        NotificationScreen.routeName: (context) => const NotificationScreen(
              title: "Notifications",
            ),
      },
    );
  }
}
