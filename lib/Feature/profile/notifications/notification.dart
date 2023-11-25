import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/NotificationScreen";
  const NotificationScreen({super.key, required this.title});

  final String title;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
      ),
    );
  }
}
