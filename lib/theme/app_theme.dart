import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF0F172A);
  static const Color accentColor = Color(0xFF4F46E5);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderColor = Color(0xFFE2E8F0);

  static const Color darkPrimaryColor = Colors.white;
  static const Color darkAccentColor = Color(0xFF818CF8); // Soft indigo
  static const Color darkBackgroundColor = Color(0xFF0F172A);
  static const Color darkSurfaceColor = Color(0xFF1E293B);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextLight = Color(0xFF64748B);
  static const Color darkBorderColor = Color(0xFF334155);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        outline: borderColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: textLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textLight, fontSize: 14),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimaryColor,
        secondary: darkAccentColor,
        surface: darkSurfaceColor,
        onPrimary: darkBackgroundColor,
        onSecondary: Colors.white,
        onSurface: darkTextPrimary,
        outline: darkBorderColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkTextPrimary),
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: darkTextSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: TextStyle(
          color: darkTextLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: darkBorderColor, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkAccentColor, width: 1.5),
        ),
        hintStyle: const TextStyle(color: darkTextLight, fontSize: 14),
      ),
    );
  }
}
