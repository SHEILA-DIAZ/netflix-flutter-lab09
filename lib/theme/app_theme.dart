import 'package:flutter/material.dart';

ThemeData get appTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'DMSans',
  scaffoldBackgroundColor: const Color(0xFF080808),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFE50914),
    onPrimary: Colors.white,
    secondary: Color(0xFFE50914),
    surface: Color(0xFF171717),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF080808),
    surfaceTintColor: Colors.transparent,
  ),
  navigationBarTheme: NavigationBarThemeData(
    iconTheme: const WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
    backgroundColor: const Color(0xFF121212),
    indicatorColor: const Color(0xFF49070A),
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(fontSize: 12, color: Colors.white),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Outfit',
      fontSize: 23,
      fontWeight: FontWeight.w700,
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF171717),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
