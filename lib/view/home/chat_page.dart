import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/colud_firestore_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatController.receiverName.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: CloudFireStoreService.cloudFireStoreService
                    .readChatFromFireStore(chatController.receiverName.value),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List data = snapshot.data!.docs;
                  List<ChatModel> chatList = [];
                  for (QueryDocumentSnapshot snap in data) {
                    chatList.add(ChatModel.fromMap(snap.data() as Map));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        Text(chatList[index].message!),
                    itemCount: chatList.length,
                  );
                },
              ),
            ),
            TextField(
              controller: chatController.txtMessage,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        ChatModel chat = ChatModel(
                            sender:
                                AuthService.authService.getCurrentUser()!.email,
                            receiver: chatController.receiverEmail.value,
                            message: chatController.txtMessage.text,
                            time: Timestamp.now());
                        await CloudFireStoreService.cloudFireStoreService
                            .addChatInFireStore(chat);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
