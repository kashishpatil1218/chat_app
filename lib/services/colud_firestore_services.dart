import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CloudFireStoreService {
  CloudFireStoreService._();

  static CloudFireStoreService cloudFireStoreService =
      CloudFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user) async {
    await fireStore.collection("users").doc(user.email).set({
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'token': user.token,
      'Image': user.Image,
    });
  }

  // READ DATA FOR CURFuture<DocumentSnapshot<Map<String, dynamic>>>PROFILE
  Future<DocumentSnapshot<Map<String, dynamic>>>
      readCurrentUserFromFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore.collection("users").doc(user!.email).get();
  }

  //READ ALL USER FROM FORE STORE
  Future<QuerySnapshot<Map<String, dynamic>>>
      readAllUserFromCloudFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireStore
        .collection("users")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

  //ADD CHAT IN FIRE STORE
  Future<void> addChatInFireStore(ChatModel chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    await fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.toMap(chat));
  }

  //  DISPLAY THE CHAT FROM FIRE STORE
  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    return fireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  // UPDATE TEH DATA FROM FIRE STORE
  Future<void> updateChat(String receiver, var dcId, String message) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");
    fireStore
        .collection('chatroom')
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({
      'message': message,
    });
  }

  Future<void> deleteMessage(String receiver, var dcId) async {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireStore
        .collection('chatroom')
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .delete();
  }
}
