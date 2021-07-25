import 'package:flutter/material.dart';
import 'package:password_manager/pages/addItem/add_item.dart';
import 'package:password_manager/pages/authenticate/finger_print_auth.dart';
import 'package:password_manager/pages/authenticate/pin_code_auth.dart';
import 'package:password_manager/pages/authenticate/sms_autofill_auth.dart';
import 'package:password_manager/pages/editItem/edit_item.dart';
import 'package:password_manager/pages/home/home.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomePage.routeName: (context) => HomePage(),
  AddItemPage.routeName: (context) => AddItemPage(),
  EditItemPage.routeName: (context) => EditItemPage(),
  FingerPrintAuthPage.routeName: (context) => FingerPrintAuthPage(),
  PinCodeAuthPage.routeName: (context) => PinCodeAuthPage(),
  SMSAutoFillAuthPage.routeName: (context) => SMSAutoFillAuthPage(),
};
