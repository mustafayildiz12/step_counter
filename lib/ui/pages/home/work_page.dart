import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dialogs.dart';

import '../widgets/radial_step_bar.dart';
import 'view_models.dart/work_page_model.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.email)
              .update({"step": steps});
          showMyDialog(
              context, "BŞARILI", "Puanınız Güncellendi", DialogType.SUCCES);
          //  stepsBox.delete('steps');
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RadialStepBar(
              startStep: steps.toDouble(),
            ),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30, color: appColors.whiteColor),
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
            Center(
              child: Text(
                status,
                style: status == 'walking' || status == 'stopped'
                    ? const TextStyle(fontSize: 30)
                    : const TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
