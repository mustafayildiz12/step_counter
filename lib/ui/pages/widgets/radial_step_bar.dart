import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'oval_icons.dart';

class RadialStepBar extends StatelessWidget {
  const RadialStepBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    const String url = 'https://cdn-icons-png.flaticon.com/512/32/32523.png';
    return SfRadialGauge(
      title: GaugeTitle(
        text: 'Speedometer',
        textStyle: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: appColors.whiteColor, fontSize: 15.sp),
      ),
      enableLoadingAnimation: true,
      animationDuration: 500,
      axes: [
        RadialAxis(
          centerY: 0.6,
          interval: 20,
          showLabels: false,
          showTicks: true,
          minimum: 0,
          maximum: 100,
          radiusFactor: 1,
          // ticksPosition: ElementsPosition.outside,
          axisLineStyle: const AxisLineStyle(
            thickness: 35,
          ),
          ranges: [
            GaugeRange(
              startWidth: 35,
              endWidth: 30,
              startValue: 0,
              endValue: 80,
              gradient: SweepGradient(
                  colors: [appColors.startBlue, appColors.endBlue]),
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: OvalIcons(
                color: appColors.dialogGreen,
                size: 70.sp,
              ),
            )
          ],
        )
      ],
    );
  }
}
