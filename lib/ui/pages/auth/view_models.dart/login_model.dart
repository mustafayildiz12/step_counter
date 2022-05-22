import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/texts.dart';
import 'package:translator/translator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/routes/route_class.dart';
import '../../home/bottom_navigation_page.dart';
import '../login_page.dart';

abstract class LoginModel extends State<LoginPage> {
  final AppColors appColors = AppColors();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();
  final AppTexts appTexts = AppTexts();

  Future signIn() async {
    final translator = GoogleTranslator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      await routes.navigateToFuture(context, const BottomNavigationPage());
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.ERROR);
    }
  }
}
