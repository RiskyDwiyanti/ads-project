import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F7F7),
    cardColor: Colors.white,
    dividerColor: const Color(0xFFF0F0F0),
    colorScheme:  ColorScheme.light(
      background: Color(0xFFF7F7F7),
      onBackground: Color(0xFF1A1A1A),
      primary: Color(0xFF0B0C4F),
      secondary: Color(0xFFFE8400),
      surface: Colors.white,
      onSurface: Color(0xFF1A1A1A),
      onPrimary: Color(0xFFFFFFFF),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: Color(0xFF2A2A2A),
    dividerColor: Color(0xFF2A2A2A),
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF121312),
      onBackground: Color(0xFFF5F5F5),
      primary: Color(0xFFFE8400),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFF5F5F5),
      onPrimary: Color(0xFF1E1E1E),
    ),
  );
}