import 'package:flutter/material.dart';
import 'package:password_manager/pages/addItem/add_card.dart';
import 'package:password_manager/pages/addItem/add_login.dart';
import 'package:password_manager/pages/addItem/add_note.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class TabAppBar extends StatelessWidget {
  static final String routeName = 'TabAppBarRoute';

  final List<ShiftingTab> shiftingBarTabs = <ShiftingTab>[
    ShiftingTab(
      icon: const Icon(
        Icons.login_outlined,
        color: Colors.white,
      ),
      text: 'Add Login',
    ),
    ShiftingTab(
      icon: const Icon(
        Icons.credit_card,
        color: Colors.white,
      ),
      text: 'Add Card',
    ),
    ShiftingTab(
      icon: const Icon(
        Icons.note_add_outlined,
        color: Colors.white,
      ),
      text: 'Add Note',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: buildShiftingTabBar(),
          body: buildScaffoldBody(),
        ),
      ),
    );
  }

  Widget buildScaffoldBody() {
    return TabBarView(
      children: [
        AddLoginPage(),
        AddCardPage(),
        AddNotePage(),
      ],
    );
  }

  ShiftingTabBar buildShiftingTabBar() {
    return ShiftingTabBar(
      labelStyle: TextStyle(color: Colors.white),
      tabs: shiftingBarTabs,
    );
  }
}
