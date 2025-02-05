// import 'package:chat_app/controller/chat_controller.dart';
// import 'package:chat_app/model/user_model.dart';
// import 'package:chat_app/services/auth_services.dart';
// import 'package:chat_app/services/google_auth_services.dart';
// import 'package:chat_app/view/auth/sign_in.dart';
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../services/colud_firestore_services.dart';
//
// var chatController = Get.put(ChatController());
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: FutureBuilder(
//           future: CloudFireStoreService.cloudFireStoreService
//               .readCurrentUserFromFireStore(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(child: Text(snapshot.hasError.toString()));
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//
//             Map? data = snapshot.data!.data();
//             UserModel userModel = UserModel.fromMap(data!);
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 DrawerHeader(
//                     child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(userModel.Image!),
//                 )),
//
//                 Text(userModel.name!,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),SizedBox(height: 10,),
//                 Text(userModel.email!,style: TextStyle(color: Colors.black,fontSize: 15),),SizedBox(height: 5,),
//                 Text(userModel.phone!,style: TextStyle(color: Colors.black,fontSize: 15)),
//               ],
//             );
//           },
//         ),
//       ),
//
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await AuthService.authService.signOutUser();
//               await GoogleAuth.googleAuth.signOutFromGoogle();
//               Get.offAll(
//                 SignIn(),
//                 transition: Transition.upToDown,
//                 duration: Duration(milliseconds: 600),
//               );
//             },
//
//             /// kem lage mast
//             icon: Icon(Icons.exit_to_app),
//           ),
//         ],
//         title: Text('HomePage'),
//       ),
//       body: FutureBuilder(
//         future: CloudFireStoreService.cloudFireStoreService
//             .readAllUserFromCloudFireStore(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.hasError.toString()),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           List data = snapshot.data!.docs;
//           List<UserModel> userList = [];
//           for (var user in data) {
//             userList.add(UserModel.fromMap(user.data()));
//           }
//
//           return ListView.builder(
//             itemCount: userList.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 onTap: () {
//                   chatController.getReceiver(
//                       userList[index].email!, userList[index].name!);
//                   Get.toNamed('/chat');
//                 },
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(userList[index].Image!),
//                 ),
//                 title: Text(userList[index].name!),
//                 subtitle: Text(userList[index].email!),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/google_auth_services.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import '../../services/colud_firestore_services.dart';

var chatController = Get.put(ChatController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xFF0B111D),
      drawer: Drawer(
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

                  height:250,
                  child: DrawerHeader(


                    // decoration: BoxDecoration(
                    //
                    //   gradient: LinearGradient(
                    //     colors: [Colors.blue, Colors.lightBlueAccent,],
                    //   ),
                    // ),
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
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          userModel.email!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.teal),
                  title: Text(
                    "Profile",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.toNamed('/profile'); // Navigate to Profile
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
      ),
      appBar: AppBar(
       backgroundColor: Color(0xFF1F2B41),
        title: Text("Chats",style: TextStyle(color: Colors.white,fontSize: 28),),
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
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
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
                      userList[index].email!, userList[index].name!);
                  Get.toNamed('/chat');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userList[index].Image!),
                ),
                title: Text(userList[index].name!,style: TextStyle(color: Colors.white),),
                subtitle: Text(userList[index].email!,style: TextStyle(color: Colors.grey)),
              );
            },
          );
        },
      ),

    );
  }
}
