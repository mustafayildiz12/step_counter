import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

import 'ui/pages/auth/login_page.dart';
import 'ui/pages/home/bottom_navigation_page.dart';
import 'ui/pages/widgets/main_gradient_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: appColors.scaffoldBack,
            primarySwatch: Colors.blue,
          ),
          home: const LoginPage(),
        );
      }),
    );
  }
}
