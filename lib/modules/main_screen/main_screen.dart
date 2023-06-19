import 'package:coffeemachine/data/constants/colors.dart';
import 'package:coffeemachine/data/constants/spacings.dart';
import 'package:coffeemachine/modules/main_screen/state/main_screen_state.dart';
import 'package:coffeemachine/modules/main_screen/widgets/pid_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainScreenStateProvider);
    return Container(
      color: CoffeemachineColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacings.m,
          vertical: Spacings.xl,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 360,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.m,
                ),
                child: PidControls(
                  currentTemperature: state.currentTemperature,
                  targetTemperature: state.targetTemperature,
                  varP: state.varP,
                  varI: state.varI,
                  varD: state.varD,
                  changeValue:
                      ref.read(mainScreenStateProvider.notifier).changeValue,
                ),
              ),
            ),
            Expanded(
              flex: 440,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.m,
                ),
                child: Column(
                  children: [
                    Text(
                      'Temperature: ${state.targetTemperature}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'varP: ${state.varP}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'varI: ${state.varI}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'varD: ${state.varD}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
