import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';
import 'package:step_counter/ui/pages/auth/verify_page.dart';
import 'package:translator/translator.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dialogs.dart';
import '../../../core/routes/route_class.dart';
import '../widgets/form_area.dart';
import '../widgets/form_password_area.dart';
import '../widgets/main_gradient_button.dart';
import '../widgets/oval_icons.dart';
import '../widgets/text_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AppColors appColors = AppColors();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();

  final NavigationRoutes routes = NavigationRoutes();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 9.h,
            ),
            OvalIcons(color: appColors.endBlue, size: 125.sp),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0 ? 9.h : 5.h,
            ),
            FormArea(
              controller: _name,
              labelText: 'İsim',
              prefixIcon: const Icon(Icons.person_add),
            ),
            SizedBox(
              height: 3.h,
            ),
            FormArea(
              controller: _email,
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            SizedBox(
              height: 3.h,
            ),
            PasswordFormField(
              passwordController: _password,
              labelText: 'Şifre',
              prefixIcon: const Icon(Icons.lock),
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 3.h,
            ),
            MainGradientButton(
                text: "KAYIT OL",
                onpressed: () async {
                  await register();
                }),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hesabım var ?",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: appColors.whiteColor),
                ),
                AppTextButton(
                    onpressed: () {
                      routes.navigateToWidget(context, const LoginPage());
                    },
                    text: "Giriş yap"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future register() async {
    final translator = GoogleTranslator();

    final uid = const Uuid().v4();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());

      await firebaseFirestore.collection("users").doc(_email.text.trim()).set({
        "email": _email.text.trim(),
        "name": _name.text,
        "uid": uid,
        "date": DateTime.now(),
        "pass": _password.text
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
