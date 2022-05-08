import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OvalIcons extends StatelessWidget {
  OvalIcons({required this.color, required this.size, Key? key})
      : super(key: key);

  Color color;
  double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.run_circle_sharp,
      size: size,
      color: color,
    );
  }
}
