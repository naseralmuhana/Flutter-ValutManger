import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

class GradientConatiner {
  static Container buildGradientContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
          colors: <Color>[
            kSecondaryColor,
            kPrimaryColor,
          ], // red to yellow
          // tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    );
  }
}
