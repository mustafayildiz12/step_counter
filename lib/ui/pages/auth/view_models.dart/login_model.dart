import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/texts.dart';
import 'package:translator/translator.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/manager/cache_manager.dart';
import '../../../../core/manager/local_manager.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/routes/route_class.dart';
import '../../home/bottom_navigation_page.dart';
import '../login_page.dart';

abstract class LoginModel extends State<LoginPage> {
  final AppColors appColors = AppColors();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();
  final AppTexts appTexts = AppTexts();
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final UserCacheManager userCacheManager;

  Future signIn() async {
    final translator = GoogleTranslator();
    final SharedManager manager = SharedManager();
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      await manager.init().whenComplete(() {
        userCacheManager = UserCacheManager(manager);
      });

      await userCacheManager.saveUserData([
        UserModel(
            name: auth.currentUser?.displayName,
            email: email.text.trim(),
            uid: auth.currentUser?.uid,
            // date: Timestamp.now(),
            pass: password.text.trim())
      ]);
      await routes.navigateToFuture(context, const BottomNavigationPage());
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.ERROR);
    }
  }
}
