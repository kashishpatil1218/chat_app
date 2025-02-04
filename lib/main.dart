import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/view/auth/sign_in.dart';
import 'package:chat_app/view/auth/sign_up.dart';
import 'package:chat_app/view/home/chat_page.dart';
import 'package:chat_app/view/home/home_page.dart';
import 'package:chat_app/view/home/simple_page.dart';
import 'package:chat_app/view/setting_page/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => simplePage()),
        GetPage(name: '/', page: () => (AuthService.authService.getCurrentUser() == null) ? SignIn() : HomePage(),),
        GetPage(
          name: '/signup',
          page: () => SignUp(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => ChatPage(),
        ),
        GetPage(
          name: '/set',
          page: () => SettingsPage(),
        ),
      ],
    );
  }
}
