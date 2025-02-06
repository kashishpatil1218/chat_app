import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/google_auth_services.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import '../../services/colud_firestore_services.dart';
import '../setting_page/component/user_drawer.dart';

var chatController = Get.put(ChatController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: userDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.authService.signOutUser();
              await GoogleAuth.googleAuth.signOutFromGoogle();
              Get.offAll(
                SignIn(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 600),
              );
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: CloudFireStoreService.cloudFireStoreService
            .readAllUserFromCloudFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List data = snapshot.data!.docs;
          List<UserModel> userList = [];
          for (var user in data) {
            userList.add(UserModel.fromMap(user.data()));
          }

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  chatController.getReceiver(
                    userList[index].email!,
                    userList[index].name!,
                  );
                  chatController.img(
                    userList[index].Image!,
                  );
                  Get.toNamed('/chat');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].Image!),
                ),
                title: Text(
                  userList[index].name!,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(userList[index].email!,
                    style: TextStyle(color: Colors.grey)),
              );
            },
          );
        },
      ),
    );
  }
}
