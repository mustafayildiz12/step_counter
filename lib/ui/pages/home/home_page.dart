import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/constants/dialogs.dart';
import 'package:step_counter/core/routes/route_class.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';
import 'package:step_counter/ui/pages/widgets/main_gradient_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainGradientButton(
                text: "ÇIKIŞ YAP",
                onpressed: () {
                  FirebaseAuth.instance.signOut();
                  awesomeDialogWithNavigation(
                      context, "BAŞARILI", "Çıkış yapıldı", () {
                    NavigationRoutes()
                        .navigateToWidget(context, const LoginPage());
                  }).show();
                }),
            Text(
              user.email.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: appColors.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
