import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: ThemeConfig.primary,
    fontFamily: 'lufga',
    
    scaffoldBackgroundColor: const Color.fromARGB(255, 244, 244, 183),
    colorScheme: ColorScheme.light(
      primaryFixed: Colors.black,
      onPrimary: AppColors.lightBackground,
      primary: ThemeConfig.primary,
      primaryContainer: ThemeConfig.primarySoft,
      secondary: ThemeConfig.accent,
      secondaryContainer: Colors.white,
      tertiaryContainer: ThemeConfig.purpleGlow,
      surface: ThemeConfig.lightSurface,
      onSurface: ThemeConfig.lightText,
      scrim: Colors.black12,
      onSecondary: Colors.grey.shade100,
      error: ThemeConfig.error,
    ),
     cardColor:  Color(0xFFF4F4B7),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: ThemeConfig.lightBackground,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: ThemeConfig.lightText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: ThemeConfig.lightText),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: ThemeConfig.lightText,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: ThemeConfig.lightText, fontSize: 16),
      bodyMedium: TextStyle(
        color: ThemeConfig.lightSecondaryText,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeConfig.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
