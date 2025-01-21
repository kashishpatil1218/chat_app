// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ACCOUNT CREATE - SIGN UP
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

// LOGIN SIGN IN
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return "error";
    }
    return "patil";
  }

// SIGN OUT
  void signOutUser() async {
    await _firebaseAuth.signOut();
  }

  //GET CURRENT USER
  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user;
  }
}
