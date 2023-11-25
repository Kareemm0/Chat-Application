import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "/NotificationScreen";
  const NotificationScreen({super.key, required this.title});

  final String title;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String token = '';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    requestPermission();
    getToken();
    initInfo();
    super.initState();
  }

  onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Text('Second Screen'),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  initInfo() async {
    // Local Notification Setup
    const androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSIntialize = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSIntialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        debugPrint('${notificationResponse.notificationResponseType}.');

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            debugPrint('${notificationResponse.payload}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Taps')),
                ),
              ),
            );
            break;
          case NotificationResponseType.selectedNotificationAction:
            print(notificationResponse);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Scaffold(
                  body: Center(child: Text('Action')),
                ),
              ),
            );
            break;
        }
      },
    );
    FirebaseMessaging.onMessage.listen((event) async {
      debugPrint("--------Message-----------");
      debugPrint("1 onMessage: ${event.notification!.title}/${event.data}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        event.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: event.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      final http.Response response =
          await http.get(Uri.parse(event.data['image']));

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'basic',
        'messages',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
        largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(response.bodyBytes)),
        actions: [
          const AndroidNotificationAction('1', 'Done',
              allowGeneratedReplies: true)
        ],
      );

      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(
        0,
        event.notification!.title,
        event.notification!.body,
        platformChannelSpecifics,
        payload: event.data['body'],
      );
    });
  }

  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('provisional');
    } else {
      debugPrint("failed");
    }
  }

  getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (value) async {
        debugPrint(value!);
        token = value;
        setState(() {});
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .update(
        //   {'token': value},
        // );
      },
    );
  }

  sendNotification(String title, body, to, icon) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAzpXPElE:APA91bHe6dfcIAXAyb9VlXZLll1n0_RXU0pnmTTBJuTWw9hlXJGkZpckU42_OCHYAAe-ujZfS-Ussa-nW78FCysM6gpU9loqP8gKOdNa5PEmZHwo4-o9OGMcsJcHlQTjwhOsxTNNKhtj",
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            "to": to,
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "basic",
              'image': icon,
            },
            "data": <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
              'image': icon,
              "url": icon,
            }
          },
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

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
