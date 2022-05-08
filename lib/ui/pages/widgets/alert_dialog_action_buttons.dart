import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class AlertDialogActionButtons extends StatelessWidget {
  AlertDialogActionButtons(
      {required this.text, required this.onpressed, Key? key})
      : super(key: key);

  String text;
  VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: appColors.darkGreen,
      ),
      onPressed: onpressed,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: appColors.whiteColor, fontSize: 12.sp),
      ),
    );
  }
}
