import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/user_model.dart';
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
      backgroundColor: Color(0xFF0B111D),
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Color(0xFF0B111D),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text(
          chatController.receiverName.value,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: CloudFireStoreService.cloudFireStoreService
            .readChatFromFireStore(chatController.receiverEmail.value),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // List data = snapshot.data!.docs;
          // List<ChatModel> chatList = [];
          // List<String> docIdList = [];
          // for (QueryDocumentSnapshot snap in data) {
          //   docIdList.add(snap.id);
          //   chatList.add(
          //     ChatModel.fromMap(snap.data() as Map),
          //   );
          // }

          List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
              snapshot.data!.docs;
          List dataList = data
              .map(
                (e) => e.data(),
              )
              .toList();
          List<ChatModel> chatList = dataList
              .map(
                (e) => ChatModel.fromMap(e),
              )
              .toList();
          List docIdList = data
              .map(
                (e) => e.id,
              )
              .toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      chatList.length,
                      (index) => Row(
                        mainAxisAlignment:
                            (AuthService.authService.getCurrentUser()!.email ==
                                    chatList[index].sender)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: (chatList[index].isImage)
                                    ? SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          chatList[index].message ?? "",
                                        ),
                                      )
                                    : Text(
                                        chatList[index].message.toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                              ),
                            ),
                            onDoubleTap: () {
                              CloudFireStoreService.cloudFireStoreService
                                  .deleteMessage(
                                chatList[index].receiver!,
                                docIdList[index],
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Update"),
                                  content: TextField(
                                    controller: chatController.txtUpdateMessage,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        CloudFireStoreService
                                            .cloudFireStoreService
                                            .updateChat(
                                                chatList[index].receiver!,
                                                docIdList[index],
                                                chatController
                                                    .txtUpdateMessage.text);
                                      },
                                      child: Text("update"),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: chatController.txtMessage,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            ChatModel chat = ChatModel(
                              sender: AuthService.authService
                                  .getCurrentUser()!
                                  .email,
                              receiver: chatController.receiverEmail.value,
                              message: "",
                              time: Timestamp.now(),
                              isImage: true,
                            );
                            await chatController.sendImage(chat);
                          },
                          icon: Icon(
                            Icons.attach_file_outlined,
                            color: Colors.blueAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            ChatModel chat = ChatModel(
                              sender: AuthService.authService
                                  .getCurrentUser()!
                                  .email,
                              receiver: chatController.receiverEmail.value,
                              message: chatController.txtMessage.text,
                              time: Timestamp.now(),
                              isImage: false,
                            );
                            await CloudFireStoreService.cloudFireStoreService
                                .addChatInFireStore(chat);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
