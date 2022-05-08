import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class MainGradientButton extends StatelessWidget {
  MainGradientButton({required this.text, required this.onpressed, Key? key})
      : super(key: key);

  String text;
  VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        width: 100.w,
        height: 7.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [appColors.leftPurple, appColors.righturple])),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: appColors.whiteColor, fontSize: 15.sp),
        ),
      ),
    );
  }
}
