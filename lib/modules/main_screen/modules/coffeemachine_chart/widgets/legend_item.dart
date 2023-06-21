import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  const LegendItem({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('-',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: color)),
        Text(
          ' $text',
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
