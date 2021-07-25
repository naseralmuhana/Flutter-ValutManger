import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback? onPressed;

  CustomElevatedButton({
    required this.buttonLabel,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 0.5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50.0),
        ),
        onPressed: onPressed,
        child: Text(
          buttonLabel,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
