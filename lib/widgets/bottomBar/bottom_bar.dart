import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/addItem/add_item.dart';
import 'package:password_manager/pages/home/home.dart';
import 'package:password_manager/widgets/bottomBar/components/custom_floating_action_button.dart';

class BottomBarWidget extends StatefulWidget {
  static final String routeName = 'BottomBarWidget';
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  late List<Map<String, dynamic>> _pages;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      tooltip: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.rss_feed),
      label: 'Feed',
      tooltip: 'Feed',
    ),
    BottomNavigationBarItem(
      icon: Icon(null),
      label: '',
      tooltip: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag),
      label: 'Cart',
      tooltip: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'User',
      tooltip: 'User',
    ),
  ];
  @override
  void initState() {
    _pages = [
      {'page': HomePage(), 'title': 'Home'},
      {'page': HomePage(), 'title': 'Home'},
      {'page': HomePage(), 'title': 'Home'},
      {'page': HomePage(), 'title': 'Home'},
      {'page': HomePage(), 'title': 'Home'},

      // {'page': FeedsScreens(), 'title': 'Feed'},
      // {'page': SearchScreen(), 'title': 'Search'},
      // {'page': CartScreen(), 'title': 'Cart'},
      // {'page': UserScreen(), 'title': 'User'},
    ];
    super.initState();
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
        onPressed: () => Navigator.of(context).pushNamed(AddItemPage.routeName),
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
}
