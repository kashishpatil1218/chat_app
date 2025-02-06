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
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(chatController.image),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              chatController.receiverName.value,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 81,),
            Icon(Icons.call_outlined,color: Colors.white,),
            SizedBox(width: 20,),
            Icon(Icons.video_call,color: Colors.white,),
            SizedBox(width: 20,),
            Icon(Icons.more_vert,color: Colors.white,),
          ],
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        chatList.length,
                        (index) => Row(
                          mainAxisAlignment: (AuthService.authService
                                      .getCurrentUser()!
                                      .email ==
                                  chatList[index].sender)
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Card(

                                shape: RoundedRectangleBorder(

                                  borderRadius:(chatList[index].sender! ==
                            AuthService.authService
                            .getCurrentUser()!
                            .email)? BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ):BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                color: Color(0xFF2E7587),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        (chatList[index].sender! ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email)
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      (chatList[index].isImage)
                                          ? SizedBox(
                                              height: 200,
                                              width: 150,
                                              child: Image.network(
                                                chatList[index].message ?? "",
                                              ),
                                            )
                                          : Text(
                                              chatList[index]
                                                  .message
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: .2,
                                              ),
                                            ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '''${(chatList[index].time.toDate().hour > 12) ? (chatList[index].time.toDate().hour % 12).toString().padLeft(2, '0') : (chatList[index].time.toDate().hour).toString().padLeft(2, '0')} : ${chatList[index].time.toDate().minute.toString().padLeft(2, '0')}''',
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white60,
                                              fontSize: 11,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            (chatList[index]
                                                        .time
                                                        .toDate()
                                                        .hour <=
                                                    12)
                                                ? ('AM')
                                                : ('PM'),
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white60,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
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
                                    backgroundColor: Color(0xFF103550),
                                    title: Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: TextField(
                                      style: TextStyle(color: Colors.white),
                                      controller:
                                          chatController.txtUpdateMessage,
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
                                          Get.back();
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
                ),
                TextField(
                  
                  controller: chatController.txtMessage,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    prefixIcon: Icon(Icons.emoji_emotions,size: 28,color: Colors.amber,),
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
