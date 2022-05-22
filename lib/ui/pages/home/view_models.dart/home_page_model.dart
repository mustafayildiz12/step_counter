import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/routes/route_class.dart';
import '../home_page.dart';

abstract class HomePageModel extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  final NavigationRoutes routes = NavigationRoutes();

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .orderBy("step", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
}
