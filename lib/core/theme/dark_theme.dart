// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'theme.dart';

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,

    fontFamily: 'lufga',
    scaffoldBackgroundColor: const Color.fromARGB(95, 48, 46, 5),
    colorScheme:  ColorScheme.dark(
      primaryFixed: Colors.white,
      onPrimary: AppColors.darkBackground,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
      secondaryContainer: Colors.black,
      shadow: Colors.white,
      onSecondary: AppColors.lightSecondaryText.withValues(alpha: 0.2),
      scrim: AppColors.primary,
      error: AppColors.error,
      background: AppColors.darkBackground,
      
    ),
    cardColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.darkText),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.darkText,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.darkSecondaryText, fontSize: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
