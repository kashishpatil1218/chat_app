import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              AuthService.authService.signOutUser();
              Get.offAll(
                SignIn(),
                transition: Transition.upToDown,
                duration: Duration(milliseconds: 600),
              );
            },/// kem lage mast
            icon: Icon(Icons.exit_to_app),
          ),
        ],
        title: Text('HomePage'),
      ),
    );
  }
}
