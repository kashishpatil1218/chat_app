import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  GoogleAuth._();

  static GoogleAuth googleAuth = GoogleAuth._();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<Future<UserCredential>> signInWithGoogle() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication? authentication =
        await account!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
   // UserCredential userCredential = await FirebaseAuth.signInWithGoogle(credential)

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  void googleSignOut() {
    googleSignIn.signOut();
  }

  Future<void> signOutFromGoogle()
  async {
    await googleSignIn.signOut();
  }
}
