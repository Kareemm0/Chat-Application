import 'package:chat_app/Feature/Chat/models/message_model.dart';
import 'package:chat_app/Feature/Chat/view/widget/custom_chat_widget.dart';
import 'package:chat_app/core/function/notification_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const routName = "/ChatScreen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text("Chats"),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? CustomChatWidget(
                                messageModel: messagesList[index],
                              )
                            : CustomChatWidgetSecondPerson(
                                messageModel: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onTap: () {
                        notification(context);
                      },
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          'message': data,
                          'createAt': DateTime.now(),
                          'id': email,
                        });
                        controller.clear();
                        scrollController.animateTo(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Send",
                        suffixIcon: Icon(
                          Icons.send,
                          color: Colors.green[200],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text("Loading.........");
          }
        });
  }
}
