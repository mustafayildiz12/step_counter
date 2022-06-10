import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/ui/pages/home/views/chat_page.dart';

import '../../../../core/routes/route_class.dart';

abstract class ChatPageModel extends State<ChatPage> {
  TextEditingController t1 = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final NavigationRoutes routes = NavigationRoutes();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    initImage();
  }

  Future<String> getProfileImage() {
    Completer<String> completer = Completer();
    firebaseFirestore.collection("users").doc(widget.uid).get().then((value) {
      if (value.exists) {
        completer.complete((value.data() as Map)["profileUrl"]);
      }
    });

    return completer.future;
  }

  initImage() async {
    String getProfileUrl = await getProfileImage();
    setState(() {
      profileUrl = getProfileUrl;
    });
  }

  sendOldMessage() async {
    await firebaseFirestore
        .collection("chats")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("messages")
        .doc(widget.uid)
        .collection("chats")
        .add({
      "senderId": firebaseAuth.currentUser?.uid,
      "receiverId": widget.uid,
      "message": t1.text,
      "type": "text",
      "date": DateTime.now()
    }).then((value) => {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(firebaseAuth.currentUser?.uid)
                  .collection("messages")
                  .doc(widget.uid)
                  .set({
                "last_msg": t1.text,
              })
            });
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(widget.uid)
        .collection("messages")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("chats")
        .add({
      "senderId": firebaseAuth.currentUser?.uid,
      "receiverId": widget.uid,
      "message": t1.text,
      "type": "text",
      "date": DateTime.now()
    }).then((value) => {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.uid)
                  .collection("messages")
                  .doc(firebaseAuth.currentUser?.uid)
                  .set({
                "last_msg": t1.text,
              })
            });
    t1.clear();
  }
}
