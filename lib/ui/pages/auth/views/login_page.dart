import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/views/forgot_password.dart';
import 'package:step_counter/ui/pages/auth/views/register_page.dart';
import 'package:step_counter/ui/pages/widgets/loading_widget.dart';

import '../../widgets/form_area.dart';
import '../../widgets/form_password_area.dart';
import '../../widgets/text_buttons.dart';

import '../view_models.dart/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends LoginModel {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(appTexts.backImage), fit: BoxFit.cover)),
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
                        controller: email,
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      PasswordFormField(
                        passwordController: password,
                        labelText: '??ifre',
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
                          text: "??ifremi Unuttum ?",
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      LoadingButton(
                          title: "Giri?? Yap",
                          onPressed: () async {
                            await signIn();
                          }),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesab??m yok ?",
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
                              text: "Kay??t ol"),
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
}
