import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/routes/route_class.dart';
import '../views/forgot_password.dart';
import '../views/login_page.dart';

abstract class ForgotModel extends State<ForgotPassword> {
  final AppColors appColors = AppColors();
  final TextEditingController email = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();

  Future resetPassword() async {
    final translator = GoogleTranslator();
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      await awesomeDialogWithNavigation(
          context, "Success", "Sıfırlama linki gönderildi", () {
        routes.navigateToWidget(context, const LoginPage());
      }).show();
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(context, "Error", translation.text, DialogType.ERROR);
    }
  }
}
