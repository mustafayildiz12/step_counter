import 'package:flutter/material.dart';

import '../../widgets/main_gradient_button.dart';
import '../../widgets/radial_step_bar.dart';
import '../view_models.dart/work_page_model.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends WorkPageModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.scaffoldBack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RadialStepBar(
              startStep: steps.toDouble(),
            ),
            Icon(
              status == 'walking'
                  ? Icons.directions_walk
                  : status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
              color: appColors.whiteColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MainGradientButton(
                  text: "PUANLARI TOPLA",
                  onpressed: () {
                    updateUserStep();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
