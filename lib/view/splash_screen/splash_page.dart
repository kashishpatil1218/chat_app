// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 3),(){
//       Navigator.of(context).pushNamed('/signin');
//
//     });
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 160),
//             child: Center(
//               child: Image(
//                 image: AssetImage('asset/img/Screenshot 2025-02-07 033616.png'),
//               ),
//
//             ),
//           ),
//           RichText(text: TextSpan(
//             text: '     Poptalk\n ',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),
//             children: [
//               TextSpan(
//                 text: '  Where Bonds are best...!',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 20)
//               ),
//             ]
//           )),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/services/auth_services.dart'; // Make sure you have access to AuthService
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:chat_app/view/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      if (AuthService.authService.getCurrentUser() != null) {
        Get.offAll(() => HomePage(),
            transition: Transition.fadeIn,
            duration: Duration(milliseconds: 800));
      } else {
        Get.offAll(() => SignIn(),
            transition: Transition.fadeIn,
            duration: Duration(milliseconds: 800));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: Center(
              child: Image(
                image: AssetImage('asset/img/Screenshot 2025-02-07 033616.png'),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: '     Poptalk\n ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '  Where Bonds are best...!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
