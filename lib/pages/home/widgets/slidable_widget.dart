import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/editItem/edit_item.dart';
import 'package:password_manager/widgets/toast/toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          onTap: () => buildDeleteAlert(context, itemName: widget.item['name']).show(),
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

  Alert buildDeleteAlert(BuildContext context, {itemName}) {
    return Alert(
      context: context,
      title: "Are you sure?",
      type: AlertType.error,
      desc: "You will not be able to recover this item ($itemName)",
      style: AlertStyle(
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 26.0,
        ),
        descStyle: TextStyle(
          color: Colors.white54,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      buttons: [
        buildDialogButton(
          context,
          buttonColor: Colors.grey,
          label: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        buildDialogButton(
          context,
          buttonColor: Colors.red.shade800,
          label: 'Yes, delete it!',
          onPressed: () {
            deleteItem(id: widget.item.id);
            CustomToast.showToast(message: '${widget.item['name']} has been Deleted Successfully.');
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  DialogButton buildDialogButton(
    BuildContext context, {
    required String label,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return DialogButton(
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: onPressed,
      color: buttonColor,
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
