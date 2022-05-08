import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes/route_class.dart';
import '../home/bottom_navigation_page.dart';
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
              height: 9.h,
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
                text: "ONAYLA",
                onpressed: () {
                  routes.navigateToWidget(
                      context, const BottomNavigationPage());
                }),
          ],
        ),
      ),
    );
  }
}
