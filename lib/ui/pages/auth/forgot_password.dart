import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';

import '../widgets/form_area.dart';
import '../widgets/loading_widget.dart';
import '../widgets/oval_icons.dart';
import 'view_models.dart/forgot_model.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ForgotModel {
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
              controller: email,
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            SizedBox(
              height: 3.h,
            ),
            LoadingButton(
                title: "SIFIRLA",
                onPressed: () async {
                  await resetPassword();
                }),
          ],
        ),
      ),
    );
  }
}
