// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:coffeemachine/data/constants/colors.dart';
import 'package:coffeemachine/data/constants/spacings.dart';
import 'package:coffeemachine/modules/main_screen/modules/coffeemachine_chart/state/coffeemachine_chart_state.dart';
import 'package:coffeemachine/modules/main_screen/modules/coffeemachine_chart/widgets/legend_item.dart';
import 'package:coffeemachine/modules/main_screen/state/temperatures_stream.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeemachineChart extends ConsumerWidget {
  const CoffeemachineChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coffeemachineChartStateProvider);
    final model = ref.read(coffeemachineChartStateProvider.notifier);
    ref.listen(temperaturesStreamProvider, (previous, next) {
      next.whenData((temperatures) {
        model.addNewValues(
          temperatures.currentTemperature,
          temperatures.targetTemperature,
        );
      });
    });
    return AspectRatio(
      aspectRatio: 0.95,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Material(
          color: AppColors.chartBackground,
          child: Padding(
            padding: const EdgeInsets.all(Spacings.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: Spacings.m),
                    Text(
                      'Temperature Profile in °C',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(
                      state.currentTemperature,
                      state.targetTemperature,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: Spacings.m),
                    LegendItem(
                      text: 'CURRENT TEMPERATURE',
                      color: AppColors.primary,
                    ),
                    SizedBox(width: Spacings.s),
                    LegendItem(
                      text: 'TARGET TEMPERATURE',
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart(this.dataStream1, this.dataStream2);

  final List<double> dataStream1;
  final List<double> dataStream2;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 30,
        maxY: 110,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: bottomTitles,
      ),
      rightTitles: AxisTitles(
        sideTitles: rightTitles(),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ));

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles rightTitles() => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('30s ago', style: style);
        break;
      case 28:
        text = const Text('Now', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.fontColorLight, width: 1),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  List<FlSpot> getSpots(List<double> dataStream) {
    final spotList = List<FlSpot>.empty(growable: true);
    for (var i = 0; i < 30; i++) {
      spotList.add(FlSpot(i.toDouble(), dataStream[i]));
    }
    return spotList;
  }

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColors.primary,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: getSpots(dataStream1),
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.secondary,
        barWidth: 1.5,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.primary,
        ),
        spots: getSpots(dataStream2),
      );
}
