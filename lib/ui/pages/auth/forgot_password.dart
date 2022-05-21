import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dialogs.dart';
import '../../../core/routes/route_class.dart';
import '../widgets/form_area.dart';
import '../widgets/main_gradient_button.dart';
import '../widgets/oval_icons.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AppColors appColors = AppColors();
  final TextEditingController _email = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    routes.navigateToWidget(context, const LoginPage());
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: appColors.whiteColor,
                    size: 20.sp,
                  )),
            ),
            SizedBox(
              height: 4.h,
            ),
            OvalIcons(color: appColors.startBlue, size: 125.sp),
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
            MainGradientButton(
                text: "RESET PASSWORD",
                onpressed: () async {
                  await resetPassword();
                }),
          ],
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      await awesomeDialogWithNavigation(
          context, "Success", "Sıfırlama linki gönderildi", () {
        routes.navigateToWidget(context, const LoginPage());
      }).show();
    } on FirebaseException catch (e) {
      await showMyDialog(
          context, "Error", e.message.toString(), DialogType.ERROR);
    }
  }
}
