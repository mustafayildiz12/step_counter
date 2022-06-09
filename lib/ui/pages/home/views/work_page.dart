import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/dialogs.dart';

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
                  onpressed: () async {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.email)
                        .update({"step": steps});
                    showMyDialog(context, "BŞARILI", "Puanınız Güncellendi",
                        DialogType.SUCCES);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
