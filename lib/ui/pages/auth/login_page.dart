import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/routes/route_class.dart';
import 'package:step_counter/ui/pages/auth/forgot_password.dart';
import 'package:step_counter/ui/pages/auth/register_page.dart';

import '../../../core/constants/dialogs.dart';
import '../home/bottom_navigation_page.dart';
import '../widgets/form_area.dart';
import '../widgets/form_password_area.dart';
import '../widgets/main_gradient_button.dart';
import '../widgets/text_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AppColors appColors = AppColors();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://s1.1zoom.me/b3241/952/Blonde_girl_Workout_Run_527364_1080x1920.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black12, Colors.black87],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
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
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppTextButton(
                    onpressed: () {
                      routes.navigateToWidget(context, const ForgotPassword());
                    },
                    text: "Şifremi Unuttum ?",
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                MainGradientButton(
                    text: "GİRİŞ YAP",
                    onpressed: () async {
                      await signIn();
                    }),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hesabım yok ?",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: appColors.whiteColor),
                    ),
                    AppTextButton(
                        onpressed: () {
                          routes.navigateToWidget(
                              context, const RegisterPage());
                        },
                        text: "Kayıt ol"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      await awesomeDialogWithNavigation(context, "Success", "Login Succes", () {
        routes.navigateToWidget(context, const BottomNavigationPage());
      }).show();
    } on FirebaseException catch (e) {
      await showMyDialog(
          context, "Error", e.message.toString(), DialogType.ERROR);
    }
  }
}
