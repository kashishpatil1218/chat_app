


import 'dart:typed_data';

import 'package:chat_app/services/image_upload_Api_server.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class simplePage extends StatefulWidget {
  const simplePage({super.key});

  @override
  State<simplePage> createState() => _simplePageState();
}

class _simplePageState extends State<simplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Upload'),),
      body: Center(
        child:Image.network(url ?? "https://thumbs.dreamstime.com/b/planet-earth-space-night-some-elements-image-furnished-nasa-52734504.jpg"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        ImagePicker imagePicker = ImagePicker();
       XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
       Uint8List image = await xFile!.readAsBytes();
        url = await ApiHelper.apiHelper.uploadImage(image);
     setState(()  {

     });

      },child: Icon(Icons.camera_alt_outlined),)
    );
  }
}
String? url ;