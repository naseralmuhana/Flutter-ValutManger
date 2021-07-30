import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

Center buildCenteredCircularIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kPrimaryColor,
        color: Colors.black,
      ),
    );
  }