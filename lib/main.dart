import 'package:coffeemachine/data/theme/custom_theme.dart';
import 'package:coffeemachine/modules/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: FlutterCoffemachine()));
}

// on line 27 of coffeemachine_state_mgmt.dart you can turn the demo mode on/off!

class FlutterCoffemachine extends StatelessWidget {
  const FlutterCoffemachine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttercoffeemachine',
      theme: buildCustomThemeData(context),
      home: const MainScreen(),
    );
  }
}
