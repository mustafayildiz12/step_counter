import 'package:flutter/material.dart';

class NavigationRoutes {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
