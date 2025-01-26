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
      appBar: AppBar(
        title: Text(chatController.receiverName.value),
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
          List data = snapshot.data!.docs;
          List<ChatModel> chatList = [];
          List<String> docIdList = [];
          for (QueryDocumentSnapshot snap in data) {
            docIdList.add(snap.id);
            chatList.add(
              ChatModel.fromMap(snap.data() as Map),
            );
          }

          // List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
          //     snapshot.data!.docs;
          // List dataList = data
          //     .map(
          //       (e) => e.data(),
          //     )
          //     .toList();
          // List<ChatModel> chatList = dataList
          //     .map(
          //       (e) => ChatModel.fromMap(e),
          //     )
          //     .toList();

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
                            onLongPress:(){
                              if(chatList[index].sender==AuthService.authService.getCurrentUser()!.email!)
                                {
                                  chatController.txtUpdateMessage= TextEditingController(text: chatList[index].message);
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text('Update'),
                                      content: TextField(controller: chatController.txtUpdateMessage,),
                                      actions: [
                                        TextButton(onPressed: () {
                                          String dcId = docIdList[index];
                                          CloudFireStoreService.cloudFireStoreService.updateChat(chatController.receiverEmail.value,chatController.txtUpdateMessage.text, dcId);
                                          Get.back();
                                        }, child: Text('Update')),
                                      ],
                                    );
                                  },);
                                }


                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  chatList[index].message.toString(),style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          time: Timestamp.now(),
                        );

                        await CloudFireStoreService.cloudFireStoreService
                            .addChatInFireStore(chat);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueAccent,
                      ),
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
