import 'package:flutter/material.dart';
import 'package:password_manager/pages/addItem/add_card.dart';
import 'package:password_manager/pages/editItem/edit_login.dart';
import 'package:password_manager/pages/editItem/edit_note.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/clipBoard/clip_board.dart';

class BottomSheetCentent extends StatefulWidget {
  final item;
  final String itemType;
  BottomSheetCentent({
    required this.item,
    required this.itemType,
  });

  @override
  _BottomSheetCententState createState() => _BottomSheetCententState();
}

class _BottomSheetCententState extends State<BottomSheetCentent> {
  bool checkObscurePassword = true;
  bool checkObscureCardNumber = true;
  bool checkObscureCVVNumber = true;
  late String routeName;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: itemContentList(),
          ),
        ),
      ),
    );
  }

  /// widgets

  ListTile buildBottomSheetObscureListTile(
    String _obscure,
    String _decrypted,
    String label,
    bool obscureField,
  ) {
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
        label: obscureField ? _obscure : _decrypted,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: buildListTileTrailing(_decrypted, obscureField, label),
    );
  }

  ListTile buildBottomSheetListTile(String label, String content) {
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
      trailing: CustomClipBoard.buildCopyClipboard(value: content),
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
          routeName,
          arguments: item,
        ),
      ),
    );
  }

  Row buildListTileTrailing(String _decrypted, bool _obscure, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomClipBoard.buildPasswordVisibility(
          obscureText: _obscure,
          onPressed: () {
            setState(() {
              if (label == 'CardNumber') {
                checkObscureCardNumber = !checkObscureCardNumber;
              } else if (label == 'Password') {
                checkObscurePassword = !checkObscurePassword;
              } else if (label == 'CVVNumber') {
                checkObscureCVVNumber = !checkObscureCVVNumber;
              }
            });
          },
        ),
        CustomClipBoard.buildCopyClipboard(
          value: _decrypted,
        ),
      ],
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

  List<Widget> itemContentList() {
    if (widget.itemType == 'Logins') {
      String _decryptedPassword = MyEncryptionDecryption.decrypt64Fernet(widget.item['password']);
      String _obscurePassword = '●' * _decryptedPassword.length;
      routeName = EditLoginPage.routeName;
      return [
        buildBottomSheetCloseEditIcon(context, widget.item),
        widget.item['url'].isEmpty ? Container() : buildBottomSheetListTile('Url', widget.item['url']),
        buildBottomSheetListTile('Name', widget.item['name']),
        widget.item['username'].isEmpty ? Container() : buildBottomSheetListTile('Username', widget.item['username']),
        widget.item['email'].isEmpty ? Container() : buildBottomSheetListTile('Email', widget.item['email']),
        buildBottomSheetObscureListTile(_obscurePassword, _decryptedPassword, 'Password', checkObscurePassword),
        widget.item['note'].isEmpty ? Container() : buildBottomSheetListTile('Note', widget.item['note']),
        SizedBox(height: 30.0)
      ];
    } else if (widget.itemType == 'Cards') {
      routeName = AddCardPage.routeName;
      String _decryptedPassword = MyEncryptionDecryption.decrypt64Fernet(widget.item['password']);
      String _obscurePassword = '●' * _decryptedPassword.length;
      String _decryptedCardNumber = MyEncryptionDecryption.decrypt64Fernet(widget.item['cardNumber']);
      String _obscureCardNumber = '●' * _decryptedCardNumber.length;
      String _decryptedCVVNumber = MyEncryptionDecryption.decrypt64Fernet(widget.item['cvvNumber']);
      String _obscureCVVNumber = '●' * _decryptedCVVNumber.length;
      String _decryptedExpiryDate = MyEncryptionDecryption.decrypt64Fernet(widget.item['expiryDate']);

      return [
        buildBottomSheetCloseEditIcon(context, widget.item),
        buildBottomSheetListTile('title', widget.item['title']),
        buildBottomSheetObscureListTile(_obscureCardNumber, _decryptedCardNumber, 'CardNumber', checkObscureCardNumber),
        buildBottomSheetListTile('ExpiryDate', _decryptedExpiryDate),
        buildBottomSheetObscureListTile(_obscureCVVNumber, _decryptedCVVNumber, 'CVVNumber', checkObscureCVVNumber),
        buildBottomSheetListTile('CardHolderName', widget.item['cardHolderName']),
        buildBottomSheetListTile('bankName', widget.item['bankName']),
        widget.item['password'].isEmpty
            ? Container()
            : buildBottomSheetObscureListTile(_obscurePassword, _decryptedPassword, 'Password', checkObscurePassword),
        widget.item['note'].isEmpty ? Container() : buildBottomSheetListTile('Note', widget.item['note']),
        SizedBox(height: 30.0)
      ];
    } else {
      String _decryptedNote = MyEncryptionDecryption.decrypt64Fernet(widget.item['note']);
      routeName = EditNotePage.routeName;
      return [
        buildBottomSheetCloseEditIcon(context, widget.item),
        buildBottomSheetListTile('title', widget.item['title']),
        buildBottomSheetListTile('note', _decryptedNote),
        SizedBox(height: 30.0)
      ];
    }
  }
}
