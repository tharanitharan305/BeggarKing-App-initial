import 'dart:io';

import 'package:beggarking/Firebase/Insert_King.dart';
import 'package:beggarking/Widgets/Kingpicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreviewKing extends StatefulWidget {
  State<PreviewKing> createState() {
    return _PreviewKing();
  }
}

class _PreviewKing extends State<PreviewKing> {
  final form_key = GlobalKey<FormState>();

  File? King;
  var Address;
  void onClick() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 50);
    if (image == null) return;
    setState(() {
      King = File(image.path);
    });
  }

  void onLaunch() {
    if (form_key.currentState!.validate()) {
      form_key.currentState!.save();
      Insert_King(pic: King, Location: Address).putFile();
      Navigator.pop(context);
    }
  }

  Widget build(context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: King == null
                  ? IconButton(
                      onPressed: onClick, icon: Icon(Icons.camera_alt_rounded))
                  : Image(image: FileImage(King!), fit: BoxFit.contain),
              height: 350,
            ),
            Form(
              key: form_key,
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText:
                        "Where is the King...[Streetname,post or taluk,district,state]"),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length < 15 ||
                      !value.contains(",")) return "Enter a valid Address ";
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    Address = value;
                  });
                },
              ),
            ),
            if (King != null)
              TextButton.icon(
                onPressed: onLaunch,
                icon: Icon(Icons.rocket_rounded),
                label: Text('Launch King...'),
              ),
            TextButton(
              onPressed: () {
                setState(() {
                  King = null;
                });
              },
              child: Text('Reset King...'),
            ),
          ],
        ));
  }
}
