import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:step_counter/core/constants/texts.dart';
import 'package:step_counter/ui/pages/splash/controller_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../core/routes/route_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NavigationRoutes routes = NavigationRoutes();
  final AppTexts appTexts = AppTexts();
  Future checkFirstSeen() async {
    routes.navigateToWidget(context, const ControllerScreen());
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4))
          .then((value) => checkFirstSeen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Lottie.network(appTexts.lottiUrl2)],
    ));
  }
}
