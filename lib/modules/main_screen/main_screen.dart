import 'package:coffeemachine/data/constants/colors.dart';
import 'package:coffeemachine/data/constants/spacings.dart';
import 'package:coffeemachine/modules/main_screen/state/coffeemachine_state.dart';
import 'package:coffeemachine/modules/main_screen/widgets/pid_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'modules/coffeemachine_chart/coffeemachine_chart.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coffeemachineStateProvider);
    return Container(
      color: AppColors.background,
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
                      ref.read(coffeemachineStateProvider.notifier).changeValue,
                ),
              ),
            ),
            const Expanded(
              flex: 440,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacings.m,
                ),
                child: CoffeemachineChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
