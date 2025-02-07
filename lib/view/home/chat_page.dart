import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/colud_firestore_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      true,
      AuthService.authService.getCurrentUser()!.email.toString(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CloudFireStoreService.cloudFireStoreService.editOnline(
      false,
      AuthService.authService.getCurrentUser()!.email.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFF0B111D),
      appBar: AppBar(
        backgroundColor: Color(0xFF101010),
        // backgroundColor: Color(0xFF0B111D),
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
            SizedBox(
              width: 81,
            ),
            Icon(
              Icons.call_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.video_call,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
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
                          mainAxisAlignment: (AuthService.authService.getCurrentUser()!.email == chatList[index].sender)
                              ? MainAxisAlignment.end  // Align to the right for sender
                              : MainAxisAlignment.start, // Align to the left for receiver
                          children: [
                            GestureDetector(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: (chatList[index].sender! == AuthService.authService.getCurrentUser()!.email)
                                      ? BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                                      : BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                color: (chatList[index].sender! == AuthService.authService.getCurrentUser()!.email)
                                    ? Color(0xFF3E4757) // Sender color (right)
                                    : Color(0xFF6C7C8B), // Receiver color (left)
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: (chatList[index].sender! == AuthService.authService.getCurrentUser()!.email)
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      (chatList[index].isImage)
                                          ? SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            fit: BoxFit.cover,
                                            chatList[index].message ?? "",
                                          ),
                                        ),
                                      )
                                          : Text(
                                        chatList[index].message.toString(),
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
                                            (chatList[index].time.toDate().hour <= 12) ? ('AM') : ('PM'),
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
                                CloudFireStoreService.cloudFireStoreService.deleteMessage(
                                  chatList[index].receiver!,
                                  docIdList[index],
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      "Update",
                                      style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.bold),
                                    ),
                                    content: TextField(
                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                      controller: chatController.txtUpdateMessage,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          CloudFireStoreService.cloudFireStoreService.updateChat(
                                            chatList[index].receiver!,
                                            docIdList[index],
                                            chatController.txtUpdateMessage.text,
                                          );
                                          Get.back();
                                        },
                                        child: Text("Update"),
                                      ),
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
                // Message input section at the bottom
                Container(
                  height: 90,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: chatController.txtMessage,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(color: Colors.grey.shade900),
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Icon(
                          Icons.emoji_emotions,
                          size: 28,
                          color: Colors.grey.shade900,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                ChatModel chat = ChatModel(
                                  sender: AuthService.authService.getCurrentUser()!.email,
                                  receiver: chatController.receiverEmail.value,
                                  message: "",
                                  time: Timestamp.now(),
                                  isImage: true,
                                );
                                await chatController.sendImage(chat);
                              },
                              icon: Icon(
                                Icons.attach_file_outlined,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(color: Colors.grey.shade900, shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () async {
                                  ChatModel chat = ChatModel(
                                    sender: AuthService.authService.getCurrentUser()!.email,
                                    receiver: chatController.receiverEmail.value,
                                    message: chatController.txtMessage.text,
                                    time: Timestamp.now(),
                                    isImage: false,
                                  );
                                  await CloudFireStoreService.cloudFireStoreService.addChatInFireStore(chat);
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
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
