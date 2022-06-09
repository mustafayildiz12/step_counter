import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/constants/dialogs.dart';
import 'package:step_counter/ui/pages/home/views/bottom_navigation_page.dart';
import 'package:step_counter/ui/pages/widgets/main_gradient_button.dart';
import 'package:step_counter/ui/pages/widgets/oval_icons.dart';
import 'package:translator/translator.dart';

import '../../../../core/routes/route_class.dart';
import 'login_page.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isEmailVerified = false;
  Timer? timer;
  final AppColors appColors = AppColors();
  final translator = GoogleTranslator();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on FirebaseException catch (e) {
      var translation = await translator.translate(e.message.toString(),
          from: 'en', to: 'tr');
      await showMyDialog(
          context, "HATA", translation.toString(), DialogType.QUESTION);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const BottomNavigationPage()
      : Scaffold(
          appBar: AppBar(
            title: Text(
              'VERIFY EMAIL',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: appColors.whiteColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 13.h,
                ),
                OvalIcons(color: appColors.ovalRed, size: 120.sp),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'The link sended to your email please verify it',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: appColors.whiteColor),
                ),
                SizedBox(
                  height: 6.h,
                ),
                MainGradientButton(
                    text: "TEKRAR GÖNDER",
                    onpressed: () async {
                      await sendVerificationEmail();
                    }),
                SizedBox(
                  height: 6.h,
                ),
                MainGradientButton(
                    text: "ÇIKIŞ YAP",
                    onpressed: () async {
                      await FirebaseAuth.instance.signOut();
                      NavigationRoutes()
                          .navigateToFuture(context, const LoginPage());
                    })
              ],
            ),
          ),
        );
}
