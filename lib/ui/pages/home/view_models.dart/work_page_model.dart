import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/constants/service/notofication_service.dart';
import '../views/work_page.dart';

abstract class WorkPageModel extends State<WorkPage> {
  late Stream<StepCount> _stepCountStream;
  final user = FirebaseAuth.instance.currentUser!;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String status = '?';
  int steps = 0;
  final AppColors appColors = AppColors();
  Box<int> stepsBox = Hive.box('steps');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    NotificationService()
        .showNotification(
          123456,
          "Yürüme zamanı",
          "Hedefe çok yakınsın",
        )
        .onError((error, stackTrace) => print(error));
    print("Bildirim atıldı");
  }

  updateUserStep() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({"step": steps});
    showMyDialog(context, "BŞARILI", "Puanınız Güncellendi", DialogType.SUCCES);
  }

  void onStepCount(StepCount event) {
    print(event);

    setState(() {
      steps = event.steps;
      getTodaySteps(steps);
    });
  }

  void refreshData() {
    setState(() {
      steps = 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      status = 'Pedestrian Status not available';
    });
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 404;
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<int> getTodaySteps(int value) async {
    print(value);
    int savedStepsCountKey = 999999;
    int? savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);

    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    if (value < savedStepsCount!) {
      savedStepsCount = 0;
      stepsBox.put(savedStepsCountKey, savedStepsCount);
    }

    int lastDaySavedKey = 888888;
    int? lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);

    if (lastDaySaved! < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = value;

      stepsBox
        ..put(lastDaySavedKey, lastDaySaved)
        ..put(savedStepsCountKey, savedStepsCount);
    }

    setState(() {
      steps = value - savedStepsCount!;
    });
    stepsBox.put(todayDayNo, steps);
    return steps; // this is your daily steps value.
  }
}
