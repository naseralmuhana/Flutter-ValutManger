import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:password_manager/constants/variables.dart';

class ItemCard extends StatelessWidget {
  final item;
  ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
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
          leading: Icon(
            Icons.verified_user_outlined,
          ),
          title: Text(
            item['name'],
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: "customFont",
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.open_in_browser),
            splashRadius: 20.0,
            onPressed: () => _launchUrl(url: item['url']),
          ),
        ),
      ),
    );
  }

  /// methods

  Future _launchUrl({String? url}) async {
    if (url!.isEmpty) {
      showToast(message: 'There is no Url.');
    } else if (await canLaunch('http://$url')) {
      await launch('http://$url');
    } else {
      showToast(message: 'Could not launch http://$url');
    }
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16.0,
    );
  }
}
