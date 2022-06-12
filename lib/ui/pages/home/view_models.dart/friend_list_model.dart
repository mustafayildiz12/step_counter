import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/ui/pages/home/views/friend_list_page.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/routes/route_class.dart';

abstract class FriendListModel extends State<FriendListPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  final NavigationRoutes routes = NavigationRoutes();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String?> lastMessages = [];
  String last = '';

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
          .collection("users")
          .where("uid", isNotEqualTo: user.uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList();
      });

  Future<String> getLastMessage(id) {
    Completer<String> completer = Completer();

    firebaseFirestore
        .collection("chats")
        .doc(id)
        .collection('messages')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        completer.complete((value.data() as Map)["last_msg"]);
      }
    });

    return completer.future;
  }

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    String msg = await getLastMessage();
    setState(() {
      last = msg;
    });
  }*/
}
