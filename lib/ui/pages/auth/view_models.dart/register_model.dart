import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/routes/route_class.dart';
import '../register_page.dart';
import '../verify_page.dart';

abstract class RegisterModel extends State<RegisterPage> {
  final AppColors appColors = AppColors();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  final NavigationRoutes routes = NavigationRoutes();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future register() async {
    final translator = GoogleTranslator();

    final uid = const Uuid().v4();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      await firebaseFirestore.collection("users").doc(email.text.trim()).set({
        "email": email.text.trim(),
        "name": name.text,
        "uid": uid,
        "date": DateTime.now(),
        "pass": password.text
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