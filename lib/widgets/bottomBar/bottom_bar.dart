import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/generatePassword/generate_password_page.dart';

import 'package:password_manager/pages/items/items.dart';

import 'package:password_manager/widgets/bottomBar/components/custom_floating_action_button.dart';
import 'package:password_manager/widgets/tabAppBar/tab_app_bar.dart';

class BottomBarWidget extends StatefulWidget {
  static final String routeName = 'BottomBarWidgetRoute';
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  late List<Map<String, dynamic>> _pages;
  late String routeArgs;

  @override
  void initState() {
    _pages = [
      {'page': ItemsPage(itemsType: 'Logins')},
      {'page': ItemsPage(itemsType: 'Cards')},
      {'page': ItemsPage(itemsType: 'Cards')},
      {'page': ItemsPage(itemsType: 'Notes')},
      {'page': GeneratePasswordPage()},
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    try {
      _selectedIndex = int.parse(
        routeArgs.substring(1, 2),
      );
    } catch (e) {
      _selectedIndex = 0;
    }

    super.didChangeDependencies();
  }

  void _selectedPage(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(TabAppBar.routeName),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 20.0,
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColorLight,
          selectedItemColor: kPrimaryColor,
          onTap: _selectedPage,
          items: bottomNavigationBarItems,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.login_outlined),
      label: 'Logins',
      tooltip: 'Logins',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.credit_card_outlined),
      label: 'Cards',
      tooltip: 'Cards',
    ),
    BottomNavigationBarItem(
      icon: Icon(null),
      label: '',
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Notes',
      tooltip: 'Notes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.password_outlined),
      label: 'Password',
      tooltip: 'Generate Password',
    ),
  ];
}
