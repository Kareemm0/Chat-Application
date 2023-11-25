import 'package:chat_app/Feature/Chat/view/chat.dart';
import 'package:chat_app/Feature/profile/notifications/notification.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = "/ProfileScreen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routName,
                  arguments: email);
            },
            leading: const Icon(Icons.chat_outlined),
            title: const Text("Chats"),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                NotificationScreen.routeName,
              );
            },
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
          )
        ],
      ),
    );
  }
}
