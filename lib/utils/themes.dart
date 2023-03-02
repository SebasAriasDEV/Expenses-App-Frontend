import 'package:flutter/material.dart';
import 'package:i_budget_app/utils/colors.dart';

class CustomThemes {
  static double horizontalPadding = 24.0;

  static ThemeData mainTheme = ThemeData.light().copyWith(
    //Colors
    primaryColor: kPrimaryColor,

    //Scaffold
    scaffoldBackgroundColor: kGreyColorShade4,

    //Appbar
    appBarTheme: const AppBarTheme().copyWith(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    ),
  );
}
