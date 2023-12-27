import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Insert_King {
  Insert_King({required this.pic, required this.Location});
  var pic;
  String Location;
  void putFile() async {
    final storage_ref = await FirebaseStorage.instance
        .ref()
        .child('King_Details')
        .child('${FirebaseAuth.instance.currentUser!.email}.jpg');
    await storage_ref.putFile(pic);
    final Image_url = await storage_ref.getDownloadURL();
    final cloud_ref =
        await FirebaseFirestore.instance.collection('King details');
    await cloud_ref.add({
      'UserName': FirebaseAuth.instance.currentUser!.displayName,
      'User_email': FirebaseAuth.instance.currentUser!.email,
      'King_url': Image_url,
      'Address': Location,
      'Launched_at': Timestamp.now()
    });
  }
}
