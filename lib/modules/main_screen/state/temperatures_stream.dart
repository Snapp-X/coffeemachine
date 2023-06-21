import 'package:coffeemachine/modules/main_screen/state/coffeemachine_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final temperaturesStreamProvider =
    StreamProvider.autoDispose<Temperatures>((ref) async* {
  final coffeemachineState = ref.watch(coffeemachineStateProvider);
  final currentTemperature = coffeemachineState.currentTemperature;
  final targetTemperature = coffeemachineState.targetTemperature;

  yield* Stream.periodic(const Duration(seconds: 1), (count) {
    return Temperatures(currentTemperature, targetTemperature);
  });
});

class Temperatures {
  final double? currentTemperature;
  final double? targetTemperature;

  Temperatures(this.currentTemperature, this.targetTemperature);
}
