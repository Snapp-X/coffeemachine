import 'package:coffeemachine/data/constants/colors.dart';
import 'package:flutter/material.dart';

class StatusDisplay extends StatelessWidget {
  const StatusDisplay({super.key, required this.isOnline});

  final bool isOnline;

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
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: Container(
                color: isOnline
                    ? AppColors.primary
                    : AppColors.singleControlBackground,
                height: 35,
                width: 120,
                child: Center(
                    child: isOnline
                        ? Text('Online',
                            style: Theme.of(context).textTheme.labelMedium)
                        : Text('Offline',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        AppColors.singleControlLabelOpaque))),
              ),
            ),
          ],
        )
      ],
    );
  }
}
