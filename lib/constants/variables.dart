import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;

const Color kPrimaryColor = Color(0xff892cdc);

const ShapeBorder kBottomSheetShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  ),
);

final OutlineInputBorder fOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(25.0),
  borderSide: BorderSide(),
);

final OutlineInputBorder fOutlineInputEnabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(25.0),
  borderSide: BorderSide(
    color: Color(0x99ffffff),
    width: 0.5,
  ),
);

const kDecorationlabelStyle = TextStyle(color: Colors.grey);
