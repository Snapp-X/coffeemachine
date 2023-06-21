import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coffeemachine_chart_state_mgmt.freezed.dart';

@freezed
class CoffeemachineChartState with _$CoffeemachineChartState {
  const factory CoffeemachineChartState({
    required List<double> currentTemperature,
    required List<double> targetTemperature,
  }) = _CoffeemachineChartState;
}

final coffeemachineChartStateProvider = StateNotifierProvider.autoDispose<
    CoffeemachineChartStateMgmt,
    CoffeemachineChartState>((ref) => CoffeemachineChartStateMgmt());

class CoffeemachineChartStateMgmt
    extends StateNotifier<CoffeemachineChartState> {
  CoffeemachineChartStateMgmt()
      : super(CoffeemachineChartState(
          currentTemperature: List<double>.generate(30, (index) => 0.0),
          targetTemperature: List<double>.generate(30, (index) => 0.0),
        ));

  Future<void> addNewValues(
    double? currentTemperature,
    double? targetTemperature,
  ) async {
    if (currentTemperature != null) {
      final newCurrentTemperature = [...state.currentTemperature];
      newCurrentTemperature.removeAt(0);
      newCurrentTemperature.add(currentTemperature);
      state = state.copyWith(
        currentTemperature: newCurrentTemperature,
      );
    }
    if (targetTemperature != null) {
      final newTargetTemperature = [...state.targetTemperature];
      newTargetTemperature.removeAt(0);
      newTargetTemperature.add(targetTemperature);
      state = state.copyWith(
        targetTemperature: newTargetTemperature,
      );
    }
  }
}
