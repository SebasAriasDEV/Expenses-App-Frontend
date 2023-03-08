import 'package:flutter/material.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';

class CustomThemes {
  static double horizontalPadding = 24.0;

  static ThemeData mainTheme = ThemeData.light().copyWith(
    //Colors
    primaryColor: kPrimaryColor,
    canvasColor: Colors.transparent,

    //Scaffold
    scaffoldBackgroundColor: kGreyColorShade4,

    //Appbar
    appBarTheme: const AppBarTheme().copyWith(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        iconTheme: const IconThemeData().copyWith(color: kPrimaryColor)),

    //TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kWhiteColor,
      hintStyle: paragraph2.copyWith(color: kGreyColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
  );
}
