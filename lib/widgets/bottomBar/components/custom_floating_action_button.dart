import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const CustomFloatingActionButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: kPrimaryColor,
      tooltip: 'Add item',
      elevation: 5.0,
      child: Icon(Icons.add),
    );
  }
}
