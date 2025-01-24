// sign in - log in -- allready have an account
//sign up -- register - nwe user

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../services/google_auth_services.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
                  Get.toNamed('/signup');
                },
                child: Text("Don't have account? Sign Up")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                String? error = await AuthService.authService
                    .signInWithEmailAndPassword(
                        controller.txtEmail.text, controller.txtPassword.text);

                if (error == "error") {
                  Get.snackbar(
                    "incorrect email and password!",
                    "please enter the correct email and password!",
                  );
                } else {
                  User? user = AuthService.authService.getCurrentUser();
                  if (user != null) {
                    Get.offAll(
                      const HomePage(),
                      duration: const Duration(milliseconds: 600),
                      transition: Transition.downToUp,
                    );
                    //123@gmail.com
                    //123456789
                    controller.txtEmail.clear();
                    controller.txtPassword.clear();
                  } else {
                    Get.snackbar("error", user!.toString());
                  }
                }
              },
              child: Text('Sign In'),
            ),
            SignInButton(Buttons.google, onPressed: () async {
             await GoogleAuth.googleAuth.signInWithGoogle();
               User? user = AuthService.authService.getCurrentUser();

              if(user!=null)
                {
                  Get.offAndToNamed('/home');
                }

            }),
          ],
        ),
      ),
    );
  }
}
