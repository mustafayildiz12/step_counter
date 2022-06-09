import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController t1 = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: t1,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  send();
                },
              )
            ],
          )
        ],
      ),
    );
  }

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
    String uid = FirebaseAuth.instance.currentUser!.email!;

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
  }
}
