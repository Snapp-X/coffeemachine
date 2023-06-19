import 'package:coffeemachine/data/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData buildCustomThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: CoffeemachineColors.background,
    colorScheme: ColorScheme.dark(
      primary: CoffeemachineColors.primary,
      secondary: CoffeemachineColors.primary,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w500,
        fontSize: MediaQuery.of(context).size.height * 0.013,
        color: Colors.white.withOpacity(0.5),
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w300,
        fontSize: 18,
        color: Colors.white.withOpacity(0.3),
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w500,
        fontSize: MediaQuery.of(context).size.width * 0.013,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Colors.white.withOpacity(0.5),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w300,
        fontSize: MediaQuery.of(context).size.width * 0.013,
        color: Colors.white.withOpacity(0.3),
      ),
      displayMedium: TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w500,
        fontSize: 35,
        color: Colors.white,
      ),
      displaySmall: const TextStyle(
        fontFamily: 'Switzer',
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        color: Colors.white,
      ),
      displayLarge: const TextStyle(
        fontFamily: 'Clash Grotesk Display',
        fontWeight: FontWeight.w600,
        fontSize: 47,
        color: Colors.white,
      ),
      labelSmall: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
        color: CoffeemachineColors.fontColorLight,
      ),
      labelMedium: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        color: CoffeemachineColors.fontColorDark,
      ),
      labelLarge: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 24.0,
        color: Colors.white,
      ),
    ),
    dividerColor: const Color(0xFF36343B).withOpacity(0.5),
    scrollbarTheme: ScrollbarThemeData(
      trackVisibility: MaterialStateProperty.all<bool>(false),
      thumbVisibility: MaterialStateProperty.all<bool>(true),
      interactive: true,
      radius: const Radius.circular(10.0),
      thumbColor: MaterialStateProperty.all<Color>(
        const Color(0xFF36343B),
      ),
      thickness: MaterialStateProperty.all(5.0),
      minThumbLength: 10,
      trackColor: MaterialStateProperty.all<Color>(
        const Color(0xFF36343B).withOpacity(0.5),
      ),
      trackBorderColor: MaterialStateProperty.all<Color>(
        const Color(0xFF36343B),
      ),
    ),
  );
}
