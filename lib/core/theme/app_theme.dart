import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBgColor,
    primaryColor: AppColors.mainLightColor,
    cardColor: AppColors.whiteColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.mainLightColor,
    ),
  );

  static ThemeData dark = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBgColor,
    primaryColor: AppColors.mainDarkColor,
    cardColor: AppColors.darkInputColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.mainDarkColor,
    ),
  );
}