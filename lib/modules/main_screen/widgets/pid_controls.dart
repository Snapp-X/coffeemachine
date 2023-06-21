import 'package:coffeemachine/data/repositories/mqtt_client.dart';
import 'package:coffeemachine/modules/main_screen/widgets/single_control.dart';
import 'package:coffeemachine/modules/main_screen/widgets/status_display.dart';
import 'package:flutter/material.dart';

class PidControls extends StatelessWidget {
  const PidControls({
    super.key,
    required this.currentTemperature,
    required this.targetTemperature,
    required this.varP,
    required this.varI,
    required this.varD,
    required this.changeValue,
    required this.isOnline,
  });

  final double? currentTemperature;
  final double? targetTemperature;
  final double? varP;
  final double? varI;
  final double? varD;
  final bool isOnline;
  final Function(MqttValue value, bool isIncrease) changeValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatusDisplay(
          isOnline: isOnline,
        ),
        const SizedBox(
          height: 35,
        ),
        SingleControl(
          label: 'CURRENT TEMPERATURE',
          value: '${currentTemperature ?? '--'} °C',
          isOnline: isOnline,
        ),
        const SizedBox(height: 7),
        SingleControl(
          label: 'TARGET TEMPERATURE',
          value: '${targetTemperature ?? '--'} °C',
          onDecrease: () => changeValue(MqttValue.targetTemperature, false),
          onIncrease: () => changeValue(MqttValue.targetTemperature, true),
          isOnline: isOnline,
        ),
        const SizedBox(height: 25),
        SingleControl(
          label: 'P',
          value: '${varP ?? '--'}',
          onDecrease: () => changeValue(MqttValue.varP, false),
          onIncrease: () => changeValue(MqttValue.varP, true),
          isOnline: isOnline,
        ),
        const SizedBox(height: 7),
        SingleControl(
          label: 'I',
          value: '${varI ?? '--'}',
          onDecrease: () => changeValue(MqttValue.varI, false),
          onIncrease: () => changeValue(MqttValue.varI, true),
          isOnline: isOnline,
        ),
        const SizedBox(height: 7),
        SingleControl(
          label: 'D',
          value: '${varD ?? '--'}',
          onDecrease: () => changeValue(MqttValue.varD, false),
          onIncrease: () => changeValue(MqttValue.varD, true),
          isOnline: isOnline,
        )
      ],
    );
  }
}
