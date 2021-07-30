import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';

Padding buildSearchTextField(
  context, {
  required Function(String)? searchBarOnChanged,
  required VoidCallback searchIconOnPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: kDefaultPadding * 0.5,
      vertical: kDefaultPadding * 0.3,
    ),
    child: TextField(
      onChanged: searchBarOnChanged,
      autofocus: true,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: searchIconOnPressed,
        ),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).bottomAppBarColor,
      ),
    ),
  );
}
