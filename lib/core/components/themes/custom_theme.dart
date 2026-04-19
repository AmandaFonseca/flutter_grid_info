import 'package:flutter/material.dart';
import 'package:flutter_grid_info/core/components/themes/custom_colors.dart';

ThemeData customTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: CustomColors.blueCiano,
    primary: CustomColors.blueCiano,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: CustomColors.blueCiano,
    iconTheme: IconThemeData(color: CustomColors.white),
  ),

  brightness: Brightness.light,
);
