// sign in - log in -- allready have an account
//sign up -- register - nwe user

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/auth_services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtEmail,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: InputDecoration(
                labelText: 'password',
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Already have account? Sign In"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService.authService.createAccountWithEmailAndPassword(
                  controller.txtEmail.text,
                  controller.txtPassword.text,
                );
              },
              child: Text('Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}
