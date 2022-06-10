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

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .where("uid", isNotEqualTo: user.uid)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
}
