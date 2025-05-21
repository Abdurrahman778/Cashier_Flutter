import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const Color goldYellow = Color(0xFFFCBF49);
  static const Color vibrantOrange = Color(0xFFF77F00);
  static const Color deepRed = Color(0xFFD62828);
  static const Color darkBlue = Color(0xFF003049);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkBlue,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: darkBlue,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: darkBlue,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: vibrantOrange,
  );

  // Button styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: vibrantOrange,
    foregroundColor: white,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Card decoration
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Theme data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: vibrantOrange,
      scaffoldBackgroundColor: lightGrey,
      colorScheme: ColorScheme.light(
        primary: vibrantOrange,
        secondary: goldYellow,
        error: deepRed,
        background: lightGrey,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBlue,
        foregroundColor: white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: primaryButtonStyle,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: headingStyle,
        displayMedium: subheadingStyle,
        bodyLarge: bodyStyle,
      ),
    );
  }
}
