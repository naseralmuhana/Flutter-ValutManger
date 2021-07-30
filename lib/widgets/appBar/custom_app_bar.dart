import 'package:flutter/material.dart';

AppBar buildAppBar(
  context, {
  required VoidCallback iconButtonOnPressed,
  required Icon icon,
  required Widget child,
  required Size preferredSize,
  required String label,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(label),
    actions: [
      IconButton(
        onPressed: iconButtonOnPressed,
        icon: icon,
      ),
    ],
    bottom: PreferredSize(
      preferredSize: preferredSize,
      child: child,
    ),
  );
}
