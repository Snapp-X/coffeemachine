import 'package:coffeemachine/data/constants/colors.dart';
import 'package:flutter/material.dart';

class StatusDisplay extends StatelessWidget {
  const StatusDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 20,
              child: Text(
                'Connection',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Container(
                color: CoffeemachineColors.primary,
                height: 35,
                width: 120,
                child: Center(
                  child: Text('Online',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
