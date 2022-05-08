import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<AwesomeDialog> showMyDialog(
    BuildContext context, String title, String content, DialogType type) async {
  return AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: content,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {}
      // padding: EdgeInsets.symmetric(horizontal: context.width * 15),
      )
    ..show();
}

AwesomeDialog awesomeDialogWithNavigation(
    BuildContext context, String title, String desc, Function function) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        function();
      });
}
