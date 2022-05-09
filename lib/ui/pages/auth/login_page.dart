import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/routes/route_class.dart';
import 'package:step_counter/ui/pages/auth/forgot_password.dart';
import 'package:step_counter/ui/pages/auth/register_page.dart';
import 'package:translator/translator.dart';

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/30/59/8d/30598d2d0ecff7884fe04fdece3bf6e6.jpg'),
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
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom == 0
                              ? 40.h
                              : 25.h),
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
                            routes.navigateToWidget(
                                context, const ForgotPassword());
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
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    final translator = GoogleTranslator();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      await routes.navigateToFuture(context, const BottomNavigationPage());
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.ERROR);
    }
  }
}
