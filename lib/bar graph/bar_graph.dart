import 'package:expense_buddy/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    //initialize the bar graph
    BarData myBarData = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );

    myBarData.iniatilizeBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitle,
            ),
          ),
        ),
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.teal.shade900,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.teal.shade100,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitle(double value, TitleMeta meta) {
  final style = TextStyle(
    color: Colors.teal.shade900,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(
        'S',
        style: style,
      );
      break;
    case 1:
      text = Text(
        'M',
        style: style,
      );
      break;
    case 2:
      text = Text(
        'T',
        style: style,
      );
      break;
    case 3:
      text = Text(
        'W',
        style: style,
      );
      break;
    case 4:
      text = Text(
        'T',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'F',
        style: style,
      );
      break;
    case 6:
      text = Text(
        'S',
        style: style,
      );
      break;
    default:
      text = Text(
        '',
        style: style,
      );
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
