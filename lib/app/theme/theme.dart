import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F7F7),
    cardColor: Colors.white,
    dividerColor: const Color(0xFFF0F0F0),
    indicatorColor: const Color(0xFFE6E6E6),
    colorScheme:  ColorScheme.light(
      background: Color(0xFFF7F7F7),
      onBackground: Color(0xFF1A1A1A),
      primary: Color(0xFF0B0C4F),
      secondary: Color(0xFF0B0C4F),
      tertiary: Color(0xFFFFFFFF), 
      surface: Color(0xFFE6E6E6),
      onSurface: Color(0xFF000000),
      onPrimary: Color(0xFFFFFFFF),
      onTertiary: Color(0xFF6C6C6C),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: Color(0xFF2A2A2A),
    dividerColor: Color(0xFF2A2A2A),
    indicatorColor: const Color(0xFF2A2B2A),
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF121312),
      onBackground: Color(0xFFF5F5F5),
      primary: Color(0xFFFE8400),
      secondary: Color(0xFF0052B4),
      tertiary: Color(0xFF2A2A2A), 
      surface: Color(0xFF2A2B2A),
      onSurface: Color(0xFFFFFFFF),
      onPrimary: Color(0xFF1E1E1E),
      onTertiary: Color(0xFFBFBFBF),
    ),
  );
}