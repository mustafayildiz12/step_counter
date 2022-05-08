import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Profile Page",
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: appColors.whiteColor),
      )),
    );
  }
}
