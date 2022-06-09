import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/auth/views/login_page.dart';

import '../../widgets/form_area.dart';
import '../../widgets/form_password_area.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/oval_icons.dart';
import '../../widgets/text_buttons.dart';
import '../view_models.dart/register_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends RegisterModel {
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
              height: 3.h,
            ),
            OvalIcons(color: appColors.endBlue, size: 125.sp),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom == 0 ? 9.h : 5.h,
            ),
            FormArea(
              controller: name,
              labelText: 'İsim',
              prefixIcon: const Icon(Icons.person_add),
            ),
            SizedBox(
              height: 3.h,
            ),
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
              labelText: 'Şifre',
              prefixIcon: const Icon(Icons.lock),
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 3.h,
            ),
            LoadingButton(
                title: "KAYIT OL",
                onPressed: () async {
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
}
