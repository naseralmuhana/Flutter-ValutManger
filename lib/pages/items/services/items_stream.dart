import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/pages/items/widgets/bottom_sheet.dart';
import 'package:password_manager/pages/items/widgets/item_card.dart';
import 'package:password_manager/pages/items/widgets/slidable_widget.dart';
import 'package:password_manager/widgets/indicator/centered_circular_indicator.dart';

class ItemsStream extends StatefulWidget {
  final String? searchString;
  final String itemType;

  ItemsStream({
    this.searchString,
    required this.itemType,
  });

  @override
  _ItemsStreamState createState() => _ItemsStreamState();
}

class _ItemsStreamState extends State<ItemsStream> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? collectionName;
  String? orderByField;
  String? searchField;

  @override
  Widget build(BuildContext context) {
    fillInfo();
    return StreamBuilder(
      stream: _firestore.collection(collectionName!).orderBy(orderByField!).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildCenteredCircularIndicator();
        } else if (snapshot.hasData) {
          return buildStreamListView(snapshot, context);
        }
        return buildCenteredCircularIndicator();
      },
    );
  }

  ListView buildStreamListView(snapshot, context) {
    return ListView(
      children: snapshot.data!.docs.map<Widget>(
        (item) {
          if ((widget.searchString == null || widget.searchString!.trim() == '')) {
            return buildListViewElement(item, context);
          }
          if (item[searchField!].toString().toLowerCase().contains(widget.searchString!.toLowerCase())) {
            return buildListViewElement(item, context);
          }
          return Container();
        },
      ).toList(),
    );
  }

  GestureDetector buildListViewElement(item, context) {
    return GestureDetector(
      child: SlidableWidget(
        child: ItemCard(
          item: item,
          itemType: widget.itemType,
        ),
        item: item,
        itemType: widget.itemType,
      ),
      onTap: () => customBottomSheet(context, item, widget.itemType),
    );
  }

  void fillInfo() {
    if (widget.itemType == 'Cards') {
      collectionName = 'CardItems';
      orderByField = 'bankName';
      searchField = 'bankName';
    } else if (widget.itemType == 'Logins') {
      collectionName = 'LoginItems';
      orderByField = 'name';
      searchField = 'name';
    }
  }
}
