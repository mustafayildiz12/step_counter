import 'package:flutter/material.dart';

class NavigationRoutes {
  void navigateToWidget(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  Future<void> navigateToFuture(BuildContext context, Widget widget) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
