import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/routes/route_class.dart';
import 'package:step_counter/ui/pages/auth/login_page.dart';
import 'package:step_counter/ui/pages/widgets/main_gradient_button.dart';
import 'package:step_counter/ui/pages/widgets/radial_step_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  final NavigationRoutes routes = NavigationRoutes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RadialStepBar(),
            MainGradientButton(
                text: "ÇIKIŞ YAP",
                onpressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await routes.navigateToFuture(context, const LoginPage());
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
