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
    required bool isLoading,
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
  CoffeemachineStateMgmt(this._mqttClient)
      : super(const CoffeemachineState(
          machineOnline: false,
          isErrorState: false,
          isLoading: true,
          currentTemperature: null,
          targetTemperature: null,
          varP: null,
          varD: null,
          varI: null,
        ));

  Future<void> init() async {
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
      state = state.copyWith(isLoading: false);
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
    state = state.copyWith(
        currentTemperature: double.tryParse(temperature), machineOnline: true);
  }

  void targetTemperatureCallback(String temperature) {
    state = state.copyWith(
        targetTemperature: double.tryParse(temperature), machineOnline: true);
  }

  void varPCallback(String varP) {
    state = state.copyWith(varP: double.tryParse(varP), machineOnline: true);
  }

  void varICallback(String varI) {
    state = state.copyWith(varI: double.tryParse(varI), machineOnline: true);
  }

  void varDCallback(String varD) {
    state = state.copyWith(varD: double.tryParse(varD), machineOnline: true);
  }
}
