import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class FormArea extends StatelessWidget {
  FormArea(
      {required this.labelText,
      required this.controller,
      this.prefixIcon,
      this.type,
      Key? key})
      : super(key: key);

  String labelText;
  Widget? prefixIcon;
  TextEditingController controller;
  TextInputType? type;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          labelText: labelText,
          labelStyle: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: appColors.startBlue),
          enabledBorder: outlineBorderForTextForm(),
          focusedBorder: outlineBorderForTextForm(),
          border: outlineBorderForTextForm()),
    );
  }

  OutlineInputBorder outlineBorderForTextForm() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(4.w));
  }
}
