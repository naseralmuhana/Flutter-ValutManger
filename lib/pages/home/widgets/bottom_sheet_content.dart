import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:password_manager/pages/editItem/edit_item.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';

class BottomSheetCentent extends StatefulWidget {
  final item;
  BottomSheetCentent({required this.item});

  @override
  _BottomSheetCententState createState() => _BottomSheetCententState();
}

class _BottomSheetCententState extends State<BottomSheetCentent> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    String _decryptedPassword = MyEncryptionDecryption.decrypt64Fernet(widget.item['password']);
    String _obscurePassword = '●' * _decryptedPassword.length;
    return StatefulBuilder(
      builder: (context, setState) => SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBottomSheetCloseEditIcon(context, widget.item),
              widget.item['url'].isEmpty ? Container() : buildBottomSheetData('Url', widget.item['url']),
              buildBottomSheetData('Name', widget.item['name']),
              widget.item['username'].isEmpty ? Container() : buildBottomSheetData('Username', widget.item['username']),
              widget.item['email'].isEmpty ? Container() : buildBottomSheetData('Email', widget.item['email']),
              buildBottomSheetPasswordField(_obscurePassword, _decryptedPassword),
              widget.item['note'].isEmpty ? Container() : buildBottomSheetData('Note', widget.item['note']),
              SizedBox(height: 30.0)
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildBottomSheetPasswordField(String _obscurePassword, String _decryptedPassword) {
    return ListTile(
      title: buildListTileTitle(
        label: 'Password',
        style: TextStyle(
          fontSize: 13,
          letterSpacing: 1.5,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      subtitle: buildListTileTitle(
        label: obscurePassword ? _obscurePassword : _decryptedPassword,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildPasswordVisibility(),
          buildCopyClipboard(
            value: _decryptedPassword,
          ),
        ],
      ),
    );
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16.0,
    );
  }

  /// widgets

  Widget buildBottomSheetData(String label, String content) {
    return ListTile(
      title: buildListTileTitle(
        label: label,
        style: TextStyle(
          fontSize: 13,
          letterSpacing: 1.5,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      subtitle: buildListTileTitle(
        label: content,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: buildCopyClipboard(value: content),
    );
  }

  IconButton buildPasswordVisibility() {
    return IconButton(
      icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
      splashRadius: 20.0,
      onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
    );
  }

  ListTile buildBottomSheetCloseEditIcon(BuildContext context, item) {
    return ListTile(
      trailing: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      leading: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).pushNamed(
          EditItemPage.routeName,
          arguments: item,
        ),
      ),
    );
  }

  IconButton buildCopyClipboard({required String value}) {
    return IconButton(
      tooltip: 'Copy',
      icon: Icon(Icons.content_copy_rounded),
      splashRadius: 20.0,
      onPressed: () async {
        await FlutterClipboard.copy(value);
        showToast(message: 'Copy to clipboard');
      },
    );
  }

  Icon buildListTileLeading({required IconData icon}) {
    return Icon(
      icon,
    );
  }

  Text buildListTileTitle({required String label, required TextStyle style}) {
    return Text(
      label,
      style: style,
    );
  }
}
