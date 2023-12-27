import 'package:beggarking/Widgets/CreateKing.dart';
import 'package:beggarking/Widgets/KingsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  State<ChatScreen> createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends State<ChatScreen> {
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.login_rounded))
            ],
          ),
          body: Column(
            children: [Expanded(child: KingsView()), CreateKing()],
          )),
    );
  }
}
