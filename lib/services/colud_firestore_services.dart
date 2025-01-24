import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CloudFirestroreService
{

  CloudFirestroreService._();
  static CloudFirestroreService cloudFirestroreService = CloudFirestroreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user)
  async {
    await fireStore.collection("users").doc(user.email).set({
      'email': user.email,
      'name':user.name,
      'phone':user.phone,
      'token':user.token,
      'Image':user.Image,
    });
  }
  // READ DATA FOR CURFuture<DocumentSnapshot<Map<String, dynamic>>>PROFILE
    Future<DocumentSnapshot<Map<String, dynamic>>> readCurrentUserFromFireStore()
    async {
    User? user = AuthService.authService.getCurrentUser();
      return await fireStore.collection("users").doc(user!.email).get();
    }
    //READ ALL USER FROM FORE STORE
Future<QuerySnapshot<Map<String, dynamic>>> readAllUserFromCloudFireStore()
async {
 return await fireStore.collection("users").get();
}


}