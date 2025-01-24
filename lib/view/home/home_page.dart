import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/google_auth_services.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/colud_firestore_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: CloudFirestroreService.cloudFirestroreService
              .readCurrentUserFromFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.hasError.toString()));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Map? data = snapshot.data!.data();
            UserModel userModel = UserModel.fromMap(data!);
            return Column(
              children: [
                DrawerHeader(
                    child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userModel.Image!),
                )),
                Text(userModel.name!),
                Text(userModel.email!),
                Text(userModel.phone!),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
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

            /// kem lage mast
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text('HomePage'),
      ),
      body: FutureBuilder(
        future: CloudFirestroreService.cloudFirestroreService
            .readCurrentUserFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        List usersList = snapshot.data!.docs;

        },
      ),
    );
  }
}
