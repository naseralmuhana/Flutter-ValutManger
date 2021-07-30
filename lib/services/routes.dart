import 'package:flutter/material.dart';
import 'package:password_manager/pages/addItem/add_card.dart';
import 'package:password_manager/pages/addItem/add_login.dart';
import 'package:password_manager/pages/addItem/add_note.dart';
import 'package:password_manager/pages/authenticate/finger_print_auth.dart';
import 'package:password_manager/pages/authenticate/pin_code_auth.dart';
import 'package:password_manager/pages/authenticate/sms_autofill_auth.dart';
import 'package:password_manager/pages/editItem/edit_login.dart';
import 'package:password_manager/pages/items/items.dart';

import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';
import 'package:password_manager/widgets/tabAppBar/tab_app_bar.dart';

Map<String, Widget Function(BuildContext)> routes = {
  BottomBarWidget.routeName: (context) => BottomBarWidget(),
  TabAppBar.routeName: (context) => TabAppBar(),
  ItemsPage.routeName: (context) => ItemsPage(),
  AddLoginPage.routeName: (context) => AddLoginPage(),
  AddCardPage.routeName: (context) => AddCardPage(),
  AddNotePage.routeName: (context) => AddNotePage(),
  EditLoginPage.routeName: (context) => EditLoginPage(),
  FingerPrintAuthPage.routeName: (context) => FingerPrintAuthPage(),
  PinCodeAuthPage.routeName: (context) => PinCodeAuthPage(),
  SMSAutoFillAuthPage.routeName: (context) => SMSAutoFillAuthPage(),
};
