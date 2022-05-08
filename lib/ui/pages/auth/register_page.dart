import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';
import 'package:step_counter/ui/pages/auth/verify_page.dart';
import 'package:translator/translator.dart';

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
  final TextEditingController _age = TextEditingController();

  final NavigationRoutes routes = NavigationRoutes();

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
              height: 9.h,
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
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      await awesomeDialogWithNavigation(context, "BAŞARILI", "Kayıt Başarılı",
          () {
        routes.navigateToWidget(context, const VerifyPage());
      }).show();
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.ERROR);
    }
  }
}