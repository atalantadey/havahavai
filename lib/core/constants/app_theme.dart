import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6200EA); // Deep purple
  static const Color accentColor = Color(0xFF03DAC6); // Teal
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light grey
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF212121); // Dark grey
  static const Color secondaryTextColor = Color(0xFF757575); // Medium grey

  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyStyle = TextStyle(fontSize: 16, color: textColor);

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: secondaryTextColor,
  );
}
