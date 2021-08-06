import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  accentColor: Colors.purpleAccent,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        kPrimaryColor,
      ),
    ),
  ),
  scaffoldBackgroundColor: Color(0xff151515),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontFamily: "Hahmlet",
    ),
    subtitle1: TextStyle(
      fontFamily: "Hahmlet",
    ),
  ),
);
