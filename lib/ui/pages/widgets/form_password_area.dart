import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class PasswordFormField extends StatefulWidget {
  PasswordFormField(
      {required this.passwordController,
      required this.labelText,
      this.prefixIcon,
      Key? key})
      : super(key: key);
  TextEditingController passwordController;
  Widget? prefixIcon;
  String labelText;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isVisible = false;
  final AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w500),
      obscureText: isVisible ? false : true,
      controller: widget.passwordController,
      decoration: textFormDecorationPassword(widget.labelText),
    );
  }

  InputDecoration textFormDecorationPassword(String labelText) {
    return InputDecoration(
      fillColor: appColors.whiteColor,
      filled: true,
      labelStyle: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(color: appColors.startBlue),
      contentPadding: EdgeInsets.zero,
      prefixIcon: widget.prefixIcon,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        icon: Icon(
          !isVisible ? Icons.visibility_off : Icons.visibility,
          size: 14.sp,
          color: AppColors().righturple,
        ),
      ),
      isDense: true,
      labelText: labelText,
      hintStyle: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500),
      enabledBorder: outlineBorderForTextForm(),
      focusedBorder: outlineBorderForTextForm(),
      border: outlineBorderForTextForm(),
    );
  }

  OutlineInputBorder outlineBorderForTextForm() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4.w));
  }
}
