import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Settings"),
    //   ),
    //   body: ListView(
    //     padding: EdgeInsets.all(10),
    //     children: [
    //       // Profile Settings
    //       ListTile(
    //         leading: Icon(Icons.person, color: Colors.blue),
    //         title: Text("Edit Profile"),
    //         subtitle: Text("Change your name, picture, etc."),
    //         onTap: () {
    //           Get.toNamed('/edit-profile'); // Navigate to edit profile page
    //         },
    //       ),
    //       Divider(),
    //
    //       // Notification Settings
    //       ListTile(
    //         leading: Icon(Icons.notifications, color: Colors.orange),
    //         title: Text("Notifications"),
    //         subtitle: Text("Manage notification preferences"),
    //         onTap: () {
    //           Get.toNamed('/notifications'); // Navigate to notifications page
    //         },
    //       ),
    //       Divider(),
    //
    //       // Privacy Settings
    //       ListTile(
    //         leading: Icon(Icons.lock, color: Colors.red),
    //         title: Text("Privacy"),
    //         subtitle: Text("Manage privacy settings"),
    //         onTap: () {
    //           Get.toNamed('/privacy'); // Navigate to privacy settings page
    //         },
    //       ),
    //       Divider(),
    //
    //       // Appearance Settings
    //       ListTile(
    //         leading: Icon(Icons.palette, color: Colors.green),
    //         title: Text("Appearance"),
    //         subtitle: Text("Change app theme and layout"),
    //         onTap: () {
    //           Get.toNamed('/appearance'); // Navigate to appearance settings page
    //         },
    //       ),
    //       Divider(),
    //
    //       // Help and Support
    //       ListTile(
    //         leading: Icon(Icons.help_outline, color: Colors.purple),
    //         title: Text("Help & Support"),
    //         subtitle: Text("Get help or report issues"),
    //         onTap: () {
    //           Get.toNamed('/help'); // Navigate to help & support page
    //         },
    //       ),
    //       Divider(),
    //
    //       // About
    //       ListTile(
    //         leading: Icon(Icons.info_outline, color: Colors.grey),
    //         title: Text("About"),
    //         subtitle: Text("Learn more about the app"),
    //         onTap: () {
    //           Get.toNamed('/about'); // Navigate to about page
    //         },
    //       ),
    //       Divider(),
    //
    //       // Logout
    //       ListTile(
    //         leading: Icon(Icons.logout, color: Colors.black),
    //         title: Text("Logout"),
    //         onTap: () async {
    //           await AuthService.authService.signOutUser();
    //           await GoogleAuth.googleAuth.signOutFromGoogle();
    //           Get.offAll(
    //             SignIn(),
    //             transition: Transition.upToDown,
    //             duration: Duration(milliseconds: 600),
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        shadowColor: Colors.black38,
        elevation: 8,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 30, letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: CircleAvatar(
                    radius: 40,
                  ),
                ),
                Text(
                  'Kashish patil',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade900,
            ),
            settingOptions(
              icon: Icons.key,
              title: ('Account'),
              subtitle: ('Security,notification,change number'),
            ),
            settingOptions(
              icon: Icons.lock_open_sharp,
              title: ('Privacy'),
              subtitle: ('Block contacts,disappearing messages'),
            ),
            settingOptions(
              icon: Icons.file_copy_outlined,
              title: ('Lists'),
              subtitle: ('Manage people and groups'),
            ),
            settingOptions(
              icon: Icons.chat_outlined,
              title: ('Chats'),
              subtitle: ('Theme, wallpapers, chat history'),
            ),
            settingOptions(
              icon: Icons.notifications_none_outlined,
              title: ('Notifications'),
              subtitle: ('Message, group & call tones'),
            ),
            settingOptions(
              icon: Icons.language,
              title: ('Language'),
              subtitle: ('English(device language'),
            ),
            settingOptions(
              icon: Icons.help_outline,
              title: ('Help'),
              subtitle: ('Help center, contact us, privacy policy'),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingOptions(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 5),
          child: Icon(icon, color: Colors.grey, size: 25),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ),
    );
  }
}
