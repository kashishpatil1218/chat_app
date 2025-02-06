// // sign in - log in -- allready have an account
// //sign up -- register - nwe user
//
// import 'package:chat_app/controller/auth_controller.dart';
// import 'package:chat_app/services/auth_services.dart';
// import 'package:chat_app/view/home/home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sign_in_button/sign_in_button.dart';
//
// import '../../services/google_auth_services.dart';
//
// class SignIn extends StatelessWidget {
//   const SignIn({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Sign In',
//           style: TextStyle(
//               color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//
//             TextField(
//               controller: controller.txtEmail,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: controller.txtPassword,
//               decoration: InputDecoration(
//                 labelText: 'password',
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             TextButton(
//                 onPressed: () {
//                   Get.toNamed('/signup');
//                 },
//                 child: Text("Don't have account? Sign Up")),
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 String? error = await AuthService.authService
//                     .signInWithEmailAndPassword(
//                         controller.txtEmail.text, controller.txtPassword.text);
//
//                 if (error == "error") {
//                   Get.snackbar(
//                     "incorrect email and password!",
//                     "please enter the correct email and password!",
//                   );
//                 } else {
//                   User? user = AuthService.authService.getCurrentUser();
//                   if (user != null) {
//                     Get.offAll(
//                       const HomePage(),
//                       duration: const Duration(milliseconds: 600),
//                       transition: Transition.downToUp,
//                     );
//                     //123@gmail.com
//                     //123456789
//                     controller.txtEmail.clear();
//                     controller.txtPassword.clear();
//                   } else {
//                     Get.snackbar("error", user!.toString());
//                   }
//                 }
//               },
//               child: Text('Sign In'),
//             ),
//             SignInButton(Buttons.google, onPressed: () async {
//               await GoogleAuth.googleAuth.signInWithGoogle();
//               User? user = AuthService.authService.getCurrentUser();
//
//               if (user != null) {
//                 Get.offAndToNamed('/home');
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Sign In',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, right: 250),
              child: Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        controller: controller.txtEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: controller.txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 200),
                        child: Text('Forget Password',style: TextStyle(color: Colors.purple),),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          String? error = await AuthService.authService
                              .signInWithEmailAndPassword(
                                  controller.txtEmail.text,
                                  controller.txtPassword.text);

                          if (error == "error") {
                            Get.snackbar(
                              "Incorrect Email or Password",
                              "Please enter the correct email and password!",
                            );
                          } else {
                            User? user = AuthService.authService.getCurrentUser();
                            if (user != null) {
                              Get.offAll(
                                const HomePage(),
                                duration: const Duration(milliseconds: 600),
                                transition: Transition.downToUp,
                              );
                              controller.txtEmail.clear();
                              controller.txtPassword.clear();
                            } else {
                              Get.snackbar("Error", user!.toString());
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.grey.shade800,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/signup');
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      SizedBox(height: 20),
                      SignInButton(
                        Buttons.google,
                        onPressed: () async {
                          await GoogleAuth.googleAuth.signInWithGoogle();
                          User? user = AuthService.authService.getCurrentUser();

                          if (user != null) {
                            Get.offAndToNamed('/home');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
