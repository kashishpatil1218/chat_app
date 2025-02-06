import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/user_model.dart';
import '../../../services/auth_services.dart';
import '../../../services/colud_firestore_services.dart';
import '../../../services/google_auth_services.dart';
import '../../auth/sign_in.dart';

Widget userDrawer() {
  return Drawer(
    backgroundColor: Colors.black,
    child: FutureBuilder(
      future: CloudFireStoreService.cloudFireStoreService
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header with User Info
            SizedBox(
              height: 250,
              child: DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userModel.Image!),
                    ),
                    SizedBox(height: 10),
                    Text(
                      userModel.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userModel.email!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider(),
            // Navigation Options
            ListTile(
              leading: Icon(Icons.chat, color: Colors.blue),
              title: Text(
                "Chats",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Get.toNamed('/chats'); // Navigate to Chats
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/set');
                },
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text(
                "Profile",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onTap: () {
                Get.toNamed('/pro'); // Navigate to Profile
              },
            ),
            Divider(),
            Spacer(),
            // Logout Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () async {
                  await AuthService.authService.signOutUser();
                  await GoogleAuth.googleAuth.signOutFromGoogle();
                  Get.offAll(
                    SignIn(),
                    transition: Transition.upToDown,
                    duration: Duration(milliseconds: 600),
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}
