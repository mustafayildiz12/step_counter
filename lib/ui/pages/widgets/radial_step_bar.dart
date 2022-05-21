import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialStepBar extends StatelessWidget {
  RadialStepBar({required this.startStep, Key? key}) : super(key: key);

  double startStep;

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();

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

          showLabels: false,
          showTicks: true,
          minimum: 0,
          maximum: 10000,
          radiusFactor: 1,
          // ticksPosition: ElementsPosition.outside,
          axisLineStyle: const AxisLineStyle(
            thickness: 35,
          ),
          ranges: [
            GaugeRange(
              startWidth: 35,
              endWidth: 35,
              startValue: 0,
              endValue: startStep,
              gradient: SweepGradient(
                  colors: [appColors.startBlue, appColors.endBlue]),
            ),
          ],
          annotations: [
            GaugeAnnotation(
              //axisValue: -1,
              positionFactor: 0.1,
              horizontalAlignment: GaugeAlignment.center,
              verticalAlignment: GaugeAlignment.center,
              widget: Container(
                color: AppColors().ovalRed,
                child: Text(
                  '${startStep.toInt()}',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: AppColors().whiteColor),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
