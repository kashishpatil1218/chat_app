// sign in - log in -- allready have an account
//sign up -- register - nwe user

import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
                onPressed: ()async  {
                  // user null
                  await AuthService.authService.signInWithEmailAndPassword(
                      controller.txtEmail.text, controller.txtPassword.text);
                  //user
                  User? user = AuthService.authService.getCurrentUser();
                  if(user!=null)
                    {
                       Navigator.of(context).pushNamed('/home');
                    }
                  else{
                    Get.snackbar('Sign In Failed !', 'Email or password may be wrong !');
                  }
                },
                child: Text('Sign In'))
          ],
        ),
      ),
    );
  }
}
