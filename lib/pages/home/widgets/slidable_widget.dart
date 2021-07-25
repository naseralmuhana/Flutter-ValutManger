import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/editItem/edit_item.dart';

class SlidableWidget extends StatefulWidget {
  final Widget child;
  final item;

  SlidableWidget({Key? key, required this.child, this.item}) : super(key: key);

  @override
  _SlidableWidgetState createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: widget.child,
      secondaryActions: [
        buildCustomIconSliderAction(
          color: Colors.black87,
          label: 'Delete',
          icon: Icons.delete,
          onTap: () {
            deleteItem(id: widget.item.id);
            showToast(message: '${widget.item['name']} has been Deleted Successfully.');
          },
        ),
        buildCustomIconSliderAction(
          color: kPrimaryColor,
          label: 'Edit',
          icon: Icons.edit,
          onTap: () => Navigator.of(context).pushNamed(
            EditItemPage.routeName,
            arguments: widget.item,
          ),
        ),
      ],
    );
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16.0,
    );
  }

  Future<void> deleteItem({required String id}) async {
    try {
      await _firestore.collection('items').doc(id).delete();
    } catch (e) {}
  }

  Padding buildCustomIconSliderAction({
    required Color color,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.1,
        vertical: kDefaultPadding * 0.4,
      ),
      child: IconSlideAction(
        caption: label,
        color: color,
        icon: icon,
        onTap: onTap,
      ),
    );
  }
}
