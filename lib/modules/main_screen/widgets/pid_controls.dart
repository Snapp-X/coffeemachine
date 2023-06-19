import 'package:coffeemachine/modules/main_screen/widgets/single_control.dart';
import 'package:coffeemachine/modules/main_screen/widgets/status_display.dart';
import 'package:flutter/material.dart';

class PidControls extends StatelessWidget {
  const PidControls(
      {super.key,
      required this.currentTemperature,
      required this.targetTemperature,
      required this.varP,
      required this.varI,
      required this.varD});

  final double? currentTemperature;
  final double? targetTemperature;
  final double? varP;
  final double? varI;
  final double? varD;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const StatusDisplay(),
        const SizedBox(
          height: 35,
        ),
        SingleControl(
            label: 'CURRENT TEMPERATURE',
            value: '${currentTemperature ?? '--'} °C'),
        const SizedBox(height: 10),
        SingleControl(
            label: 'TARGET TEMPERATURE',
            value: '${targetTemperature ?? '--'} °C'),
        const SizedBox(height: 30),
        SingleControl(label: 'P', value: '${varP ?? '--'}'),
        const SizedBox(height: 10),
        SingleControl(label: 'I', value: '${varI ?? '--'}'),
        const SizedBox(height: 10),
        SingleControl(label: 'D', value: '${varD ?? '--'}'),
      ],
    );
  }
}
