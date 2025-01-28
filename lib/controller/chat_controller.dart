import 'dart:typed_data';

import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/services/colud_firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/image_upload_Api_server.dart';


class ChatController extends GetxController{

  RxString receiverEmail = "".obs;
  RxString receiverName = "".obs;
  RxString imgUrl = "".obs;
  var time= Timestamp.now().obs;

  // SEND I,AGE IN FIRE STORE
  Future<void> sendImage(ChatModel chat)
  async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List image = await xFile!.readAsBytes() ;
   chat.message= await  ApiHelper.apiHelper.uploadImage(image) ?? "";
   await CloudFireStoreService.cloudFireStoreService.addChatInFireStore(chat);
  }

  TextEditingController txtMessage = TextEditingController();
  TextEditingController txtUpdateMessage = TextEditingController();

  void getReceiver(String email, String name)
  {
    receiverName.value= name;
    receiverEmail.value= email;
  }

}