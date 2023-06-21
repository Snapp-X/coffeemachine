import 'package:coffeemachine/data/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData buildCustomThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: AppColors.headlineColor,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Clash Grotesk Display',
        fontWeight: FontWeight.w600,
        fontSize: 47,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
        color: AppColors.fontColorLight,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        color: AppColors.fontColorDark,
      ),
      labelLarge: TextStyle(
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
