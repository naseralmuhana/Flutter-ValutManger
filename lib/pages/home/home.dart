import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/addItem/add_item.dart';
import 'package:password_manager/pages/home/services/item_stream.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'HomePageRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ItemsStream(),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text('Passwords'),
    );
  }

  Padding buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding * 0.4),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        tooltip: 'Add New Item',
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(AddItemPage.routeName),
      ),
    );
  }
}
