import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.blueCiano800,
    primary: CustomColors.blueCiano800,
    secondary: CustomColors.blueMediunCiano,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: CustomColors.blueCiano800,
    iconTheme: IconThemeData(color: CustomColors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: CustomColors.blueCiano600,
    foregroundColor: CustomColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CustomColors.blueCiano600,
      foregroundColor: CustomColors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    TextTheme(
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff3E3030),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xff3E3030),
      ),
    ),
  ),

  brightness: Brightness.light,
);
