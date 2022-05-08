import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SampleDataExample extends StatelessWidget {
  const SampleDataExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = AppColors();
    return SfCartesianChart(
      legend: Legend(
        isVisible: true,
      ),
      plotAreaBorderWidth: 0,
      primaryYAxis: NumericAxis(isVisible: false),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      series: <ChartSeries<SampleData, String>>[
        ColumnSeries(
            name: 'Gold',
            dataSource: <SampleData>[
              SampleData('USA', 46),
              SampleData('GBR', 27),
              SampleData('CHN', 26),
            ],
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
            xValueMapper: (SampleData data, _) => data.x,
            yValueMapper: (SampleData data, _) => data.y,
            color: appColors.darkGreen),
        ColumnSeries(
            name: 'Silver',
            dataSource: <SampleData>[
              SampleData('USA', 37),
              SampleData('GBR', 23),
              SampleData('CHN', 18),
            ],
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
            xValueMapper: (SampleData data, _) => data.x,
            yValueMapper: (SampleData data, _) => data.y,
            color: appColors.ovalRed),
        ColumnSeries(
            name: 'Bronze',
            dataSource: <SampleData>[
              SampleData('USA', 38),
              SampleData('GBR', 17),
              SampleData('CHN', 26),
            ],
            dataLabelSettings: const DataLabelSettings(
                isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
            xValueMapper: (SampleData data, _) => data.x,
            yValueMapper: (SampleData data, _) => data.y,
            color: appColors.endBlue),
      ],
    );
  }
}

class SampleData {
  SampleData(this.x, this.y);
  final String x;
  final num y;
}
