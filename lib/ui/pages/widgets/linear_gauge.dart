import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LinearStepBar extends StatelessWidget {
  const LinearStepBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return Container(
      child: SfLinearGauge(
        ranges: [
          LinearGaugeRange(
            startWidth: 25,
            endWidth: 25,
            startValue: 0,
            endValue: 40,
            color: appColors.startBlue,
          ),
          LinearGaugeRange(
            startWidth: 25,
            endWidth: 25,
            startValue: 40,
            endValue: 66,
            color: appColors.endBlue,
          ),
        ],
        minimum: 0.0,
        maximum: 100.0,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: const LinearTickStyle(length: 20),
        axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.white),
      ),
      margin: const EdgeInsets.all(10),
    );
  }
}
