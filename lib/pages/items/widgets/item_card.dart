import 'package:flutter/material.dart';
import 'package:password_manager/widgets/form/components/custom_credit_card_widget.dart';
import 'package:password_manager/widgets/toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:password_manager/constants/variables.dart';

class ItemCard extends StatefulWidget {
  final item;
  final String itemType;
  ItemCard({
    required this.item,
    required this.itemType,
  });

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String? mainField;

  void fillInfo() {
    if (widget.itemType == 'Cards') {
      mainField = 'bankName';
    } else if (widget.itemType == 'Logins') {
      mainField = 'name';
    } else if (widget.itemType == 'Notes') {
      mainField = 'title';
    }
  }

  @override
  Widget build(BuildContext context) {
    fillInfo();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 0.1,
        horizontal: kDefaultPadding * 0.3,
      ),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * 0.3,
            horizontal: kDefaultPadding,
          ),
          leading: buildListTileLeading(),
          title: buildListTileTitle(),
          trailing: getListTileTrailing(),
        ),
      ),
    );
  }

  Widget getListTileTrailing() {
    if (mainField == 'name') {
      return buildLoginButton(
        iconData: Icons.open_in_browser,
        onPressed: () => _launchUrl(url: widget.item['url']),
      );
    } else if (mainField == 'bankName') {
      return buildLoginButton(
        iconData: Icons.credit_card,
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return CustomCreditCardWidget(
              cardNumber: widget.item['cardNumber'],
              cardHolderName: widget.item['cardHolderName'],
              cvvNumber: widget.item['cvvNumber'],
              expiryDate: widget.item['expiryDate'],
            );
          },
        ),
      );
    }
    return buildLoginButton(
      iconData: Icons.note_outlined,
      onPressed: () => null,
    );
  }

  Icon buildListTileLeading() {
    return Icon(
      Icons.verified_user_outlined,
    );
  }

  Text buildListTileTitle() {
    return Text(
      widget.item[mainField],
      style: TextStyle(
        fontSize: 24.0,
        fontFamily: "customFont",
      ),
    );
  }

  IconButton buildLoginButton({
    required IconData iconData,
    onPressed,
  }) {
    return IconButton(
      icon: Icon(iconData),
      splashRadius: 20.0,
      onPressed: onPressed,
    );
  }

  /// methods
  Future _launchUrl({String? url}) async {
    if (url!.isEmpty) {
      CustomToast.showToast(message: 'There is no Url.');
    } else if (await canLaunch('http://$url')) {
      await launch('http://$url');
    } else {
      CustomToast.showToast(message: 'Could not launch http://$url');
    }
  }
}
