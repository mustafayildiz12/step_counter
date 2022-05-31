import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({Key? key, required this.onPressed, required this.title})
      : super(key: key);
  final String title;
  final Future<void> Function() onPressed;
  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;
  final appColors = AppColors();

  void changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        changeLoading();
        await widget.onPressed.call();
        changeLoading();
      },
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
        child: _isLoading
            ? CircularProgressIndicator(
                color: appColors.whiteColor,
              )
            : Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: appColors.whiteColor, fontSize: 15.sp),
              ),
      ),
    );
  }
}
