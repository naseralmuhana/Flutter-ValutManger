import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/addItem/add_card.dart';
import 'package:password_manager/pages/addItem/add_login.dart';
import 'package:password_manager/pages/addItem/add_note.dart';

class TabAppBar extends StatelessWidget {
  static final String routeName = 'TabAppBarRoute';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // length: 3,
      length: 2,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: buildAppBar(),
          body: buildScaffoldBody(),
        ),
      ),
    );
  }

  TabBarView buildScaffoldBody() {
    return TabBarView(
      children: [
        AddLoginPage(),
        AddCardPage(),
        // AddNotePage(),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Add New Item'),
      bottom: TabBar(
        indicatorColor: kPrimaryColor,
        tabs: [
          Tab(icon: Icon(Icons.login_outlined), text: 'Login'),
          Tab(icon: Icon(Icons.credit_card_outlined), text: 'Card'),
          // Tab(icon: Icon(Icons.note_add_outlined), text: 'Note'),
        ],
      ),
    );
  }
}
