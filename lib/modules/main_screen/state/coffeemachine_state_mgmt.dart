import 'dart:async';
import 'dart:developer';

import 'package:coffeemachine/data/repositories/mqtt_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffeemachine_state_mgmt.freezed.dart';

@freezed
class CoffeemachineState with _$CoffeemachineState {
  const factory CoffeemachineState({
    required bool machineOnline,
    required bool isErrorState,
    required bool isInitial,
    required double? currentTemperature,
    required double? targetTemperature,
    required double? varP,
    required double? varD,
    required double? varI,
  }) = _CoffeemachineState;
}

final coffeemachineStateProvider = StateNotifierProvider.autoDispose<
        CoffeemachineStateMgmt, CoffeemachineState>(
    (ref) => CoffeemachineStateMgmt(ref.read(mqttClientProvider))..init());

class CoffeemachineStateMgmt extends StateNotifier<CoffeemachineState> {
  final MqttClient _mqttClient;
  bool isFirstRun = true;
  DateTime _lastUpdate = DateTime.now();
  CoffeemachineStateMgmt(this._mqttClient)
      : super(const CoffeemachineState(
          machineOnline: false,
          isErrorState: false,
          isInitial: true,
          currentTemperature: null,
          targetTemperature: null,
          varP: null,
          varD: null,
          varI: null,
        )) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (DateTime.now().difference(_lastUpdate) > const Duration(seconds: 5)) {
        state = state.copyWith(machineOnline: false);
      }
    });
  }

  Future<void> init() async {
    if (!state.isInitial) {
      return;
    }
    final subscriptionTopics = [
      MqttValue.currentTemperature,
      MqttValue.targetTemperature,
      MqttValue.varP,
      MqttValue.varI,
      MqttValue.varD,
    ];
    try {
      await _mqttClient.connect();
      await _mqttClient.subscribeTo(subscriptionTopics, subscriptionCallback);
      state = state.copyWith(isInitial: false);
    } catch (e) {
      state = state.copyWith(isErrorState: true);
    }
  }

  void changeValue(MqttValue mqttValue, bool isIncrease) {
    final value = isIncrease ? 1 : -1;
    final topic = mqttValue;
    double? currentValue;
    switch (mqttValue) {
      case MqttValue.currentTemperature:
        return;
      case MqttValue.targetTemperature:
        currentValue = state.targetTemperature;
        break;
      case MqttValue.varP:
        currentValue = state.varP;
        break;
      case MqttValue.varI:
        currentValue = state.varI;
        break;
      case MqttValue.varD:
        currentValue = state.varD;
        break;
    }

    if (currentValue != null) {
      final newValue = (currentValue + value).toStringAsFixed(0);
      _mqttClient.publish(newValue, topic);
    }
  }

  void subscriptionCallback(String messageValue, String topic) {
    final topicSuffix = topic.split('/').last;

    ///When starting for the first time, the last known values will be received, even if the machine is offline,
    ///We can use that behaviour for our PID values, but we don't want to read the last known temperature

    if (isFirstRun && topicSuffix == MqttClient.currentTemperature) {
      isFirstRun = false;
      return;
    }
    switch (topicSuffix) {
      case MqttClient.currentTemperature:
        currentTemperatureCallback(messageValue);
        break;
      case MqttClient.targetTemperature:
        targetTemperatureCallback(messageValue);
        break;
      case MqttClient.varP:
        varPCallback(messageValue);
        break;
      case MqttClient.varI:
        varICallback(messageValue);
        break;
      case MqttClient.varD:
        varDCallback(messageValue);
        break;
      default:
        log('MainScreenState::Subscription Callback not set');
    }
  }

  void currentTemperatureCallback(String temperature) {
    _lastUpdate = DateTime.now();
    state = state.copyWith(
        currentTemperature: double.tryParse(temperature), machineOnline: true);
  }

  void targetTemperatureCallback(String temperature) {
    state = state.copyWith(targetTemperature: double.tryParse(temperature));
  }

  void varPCallback(String varP) {
    state = state.copyWith(varP: double.tryParse(varP));
  }

  void varICallback(String varI) {
    state = state.copyWith(varI: double.tryParse(varI));
  }

  void varDCallback(String varD) {
    state = state.copyWith(varD: double.tryParse(varD));
  }
}
