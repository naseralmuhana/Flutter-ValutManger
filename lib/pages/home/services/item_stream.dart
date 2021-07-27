import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/home/widgets/bottom_sheet.dart';

import 'package:password_manager/pages/home/widgets/item_card.dart';
import 'package:password_manager/pages/home/widgets/slidable_widget.dart';

class ItemsStream extends StatelessWidget {
  final String? searchString;

  const ItemsStream({this.searchString});
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: _firestore.collection('items').orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return (searchString == null || searchString!.trim() == '')
              ? ListView(
                  children: snapshot.data!.docs.map(
                    (item) {
                      return GestureDetector(
                        child: SlidableWidget(
                          child: ItemCard(item: item),
                          item: item,
                        ),
                        onTap: () {
                          customBottomSheet(context, item);
                        },
                      );
                    },
                  ).toList(),
                )
              : ListView(
                  children: snapshot.data!.docs.map(
                    (item) {
                      return item['name'].toString().toLowerCase().contains(searchString!.toLowerCase())
                          ? GestureDetector(
                              child: SlidableWidget(
                                child: ItemCard(item: item),
                                item: item,
                              ),
                              onTap: () {
                                customBottomSheet(context, item);
                              },
                            )
                          : Container();
                    },
                  ).toList(),
                );
        }
        return buildCenteredCircularIndicator();
      },
    );
  }

  Center buildCenteredCircularIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: kPrimaryColor,
        color: Colors.black,
      ),
    );
  }
}
