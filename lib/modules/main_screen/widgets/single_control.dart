import 'package:coffeemachine/data/constants/colors.dart';
import 'package:coffeemachine/data/constants/images.dart';
import 'package:flutter/material.dart';

class SingleControl extends StatelessWidget {
  const SingleControl({
    super.key,
    required this.value,
    required this.label,
    this.onIncrease,
    this.onDecrease,
  });

  final String value;
  final String label;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 20,
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    color: CoffeemachineColors.singleControlBackground,
                    height: 35,
                    width: 300,
                    child: Center(
                      child: Text(value,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: CoffeemachineColors
                                      .singleControlLabelOpaque)),
                    ),
                  ),
                ),
                if (onIncrease != null)
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: onIncrease,
                      child: Image.asset(
                        CoffeemachineImages.increaseButton,
                        fit: BoxFit.scaleDown,
                        height: 35,
                      ),
                    ),
                  ),
                if (onDecrease != null)
                  Positioned(
                    left: 0,
                    child: GestureDetector(
                      onTap: onDecrease,
                      child: Image.asset(
                        CoffeemachineImages.decreaseButton,
                        fit: BoxFit.scaleDown,
                        height: 35,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
