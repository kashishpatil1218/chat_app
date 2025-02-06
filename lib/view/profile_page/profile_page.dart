import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user_model.dart';
import '../../services/auth_services.dart';
import '../../services/colud_firestore_services.dart';
import '../../services/image_upload_Api_server.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: FutureBuilder(
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
            children: [
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    ///
                    ImagePicker imagePicker = ImagePicker();
                    XFile? xFile =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    Uint8List image = await xFile!.readAsBytes();
                    String userImage = await ApiHelper.apiHelper
                            .uploadImage(image) ??
                        "https://static.vecteezy.com/system/resources/thumbnails/005/129/844/small_2x/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg";
                    CloudFireStoreService.cloudFireStoreService.editImage(
                      userImage,
                      AuthService.authService
                          .getCurrentUser()!
                          .email
                          .toString(),
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(userModel.Image!),
                  ),
                ),
              ),
              optionProfile(
                title: 'My Account',
                icon: Icons.perm_identity,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              optionProfile(
                title: 'Notification',
                icon: Icons.notifications_none_outlined,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              optionProfile(
                title: 'Setting',
                icon: Icons.settings,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              optionProfile(
                title: 'Help center',
                icon: Icons.help_outline,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              optionProfile(
                title: 'Log Out',
                icon: Icons.logout,
                trailingIcon: Icons.arrow_forward_ios,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget optionProfile(
      {required String title,
      required IconData icon,
      required IconData trailingIcon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Card(
        color: Colors.white12,
        child: ListTile(
          trailing: Icon(
            trailingIcon,
            color: Colors.white70,
          ),
          leading: Icon(
            icon,
            size: 30,
            color: Colors.white54,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white70, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
