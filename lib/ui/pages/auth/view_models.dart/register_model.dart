import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/manager/cache_manager.dart';
import 'package:translator/translator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/routes/route_class.dart';
import '../views/register_page.dart';
import '../views/verify_page.dart';

abstract class RegisterModel extends State<RegisterPage> {
  final AppColors appColors = AppColors();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  late final UserCacheManager userCacheManager;

  final NavigationRoutes routes = NavigationRoutes();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register() async {
    final translator = GoogleTranslator();
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((_) {
        firebaseFirestore
            .collection("users")
            .doc(firebaseAuth.currentUser?.uid)
            .set({
          "email": firebaseAuth.currentUser?.email,
          "name": name.text,
          "uid": firebaseAuth.currentUser?.uid,
          "date": DateTime.now(),
          "pass": password.text.trim(),
          "step": 0
        });
      });

      await awesomeDialogWithNavigation(context, "BAŞARILI", "Kayıt Başarılı",
          () {
        routes.navigateToFuture(context, const VerifyPage());
      }).show();

      await routes.navigateToFuture(context, const VerifyPage());
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.ERROR);
    }
  }
}
