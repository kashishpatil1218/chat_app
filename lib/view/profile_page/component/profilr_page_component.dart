import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget optionProfile(
    {required String title,
      required IconData icon,
      required IconData trailingIcon}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
    child: Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        trailing: Icon(
          trailingIcon,
          color: Colors.grey.shade900,
        ),
        leading: Icon(
          icon,
          size: 30,
          color: Colors.grey.shade900,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
      ),
    ),
  );
}
