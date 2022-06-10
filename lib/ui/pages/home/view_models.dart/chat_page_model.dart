import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/models/chat_model.dart';
import 'package:step_counter/ui/pages/home/views/chat_page.dart';

import '../../../../core/routes/route_class.dart';

abstract class ChatPageModel extends State<ChatPage> {
  TextEditingController t1 = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final NavigationRoutes routes = NavigationRoutes();

  Stream<List<ChatModel>> readMessages() => firebaseFirestore
      .collection("chats")
      .doc()
      .collection('messages')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());

  Future<String?> chatId(myId) {
    Completer<String?> completer = Completer();

    print(widget.uid + " *** " + myId);

    firebaseFirestore
        .collection('chats')
        .where("users", isEqualTo: [widget.uid, myId])
        .get()
        .then((value) {
          if (value.size > 0) {
            completer.complete(value.docs.first.id);
          } else {
            completer.complete(null);
          }
        })
        .catchError((err) {
          completer.complete(null);
        });

    return completer.future;
  }

  Future<String> getUserUUID() {
    Completer<String> completer = Completer();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    firebaseFirestore.collection("users").doc(uid).get().then((value) {
      if (value.exists) {
        completer.complete((value.data() as Map)["uid"]);
      }
    });

    return completer.future;
  }

  sendMessage(chat) async {
    await firebaseFirestore
        .collection('chats')
        .doc(chat)
        .collection('messages')
        .add({'uid': widget.uid, 'message': t1.text, 'date': DateTime.now()});
  }

  send() async {
    String myId = await getUserUUID();
    String? chat = await chatId(myId);

    if (chat == null) {
      await firebaseFirestore.collection('chats').doc().set({
        "users": [
          widget.uid,
          myId,
        ],
      }).then((value) {
        send();
      });
    } else {
      sendMessage(chat);
    }
    t1.clear();
  }
}
