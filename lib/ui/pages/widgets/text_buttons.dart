import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';

class AppTextButton extends StatelessWidget {
  AppTextButton({required this.onpressed, required this.text, Key? key})
      : super(key: key);

  String text;
  VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: TextDecoration.underline, color: appColors.whiteColor),
      ),
    );
  }
}
