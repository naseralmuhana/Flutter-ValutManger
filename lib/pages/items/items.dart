import 'package:flutter/material.dart';
import 'package:password_manager/pages/items/services/items_stream.dart';
import 'package:password_manager/widgets/appBar/custom_app_bar.dart';
import 'package:password_manager/widgets/appBar/custom_search_bar.dart';

class ItemsPage extends StatefulWidget {
  static final String routeName = 'ItemsPageRoute';

  final String? itemsType;
  const ItemsPage({this.itemsType});

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  bool isSearching = false;
  String? searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        label: widget.itemsType ?? 'Items',
        child: isSearching
            ? buildSearchTextField(
                context,
                searchBarOnChanged: searchBarOnChanged,
                searchIconOnPressed: searchIconOnPressed,
              )
            : Container(),
        icon: isSearching ? Icon(Icons.cancel_outlined) : Icon(Icons.search),
        preferredSize: Size.fromHeight(isSearching ? 56 : 0),
        iconButtonOnPressed: iconButtonOnPressed,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ItemsStream(searchString: searchString, itemType: widget.itemsType!),
            ),
          ],
        ),
      ),
    );
  }

  void iconButtonOnPressed() {
    setState(() {
      isSearching = !isSearching;
      searchString = null;
    });
  }

  void searchBarOnChanged(value) {
    setState(() {
      searchString = value;
    });
  }

  void searchIconOnPressed() {
    setState(() {
      FocusScope.of(context).unfocus();
    });
  }
}
