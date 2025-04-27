import 'package:flutter/material.dart';

const _primaryColor = Colors.white;
const _secondaryColor = Colors.black87;
const _backgroundColor = Colors.white70;
const _surfaceColor = Colors.white;
const _textColor = Colors.black87;
const _hintColor = Colors.grey;

final theme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _backgroundColor,
  appBarTheme: AppBarTheme(
    color: _primaryColor,
    titleTextStyle: TextStyle(
      color: _textColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: _textColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
  ),

  colorScheme: ColorScheme.fromSeed(
    seedColor: _primaryColor,
    brightness: Brightness.light,
    primary: _textColor,
    secondary: _secondaryColor,
    surface: _surfaceColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: _hintColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: _secondaryColor),
    ),
  ),
);
