import 'package:flutter/material.dart';
import 'package:password_manager/pages/authenticate/sms_autofill_auth.dart';
import 'package:password_manager/services/local_auth/local_auth_api.dart';

class FingerPrintAuthPage extends StatefulWidget {
  static final String routeName = 'FingerPrintAuthPageRoute';

  @override
  _FingerPrintAuthPageState createState() => _FingerPrintAuthPageState();
}

class _FingerPrintAuthPageState extends State<FingerPrintAuthPage> {
  @override
  void initState() {
    fingerAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildFingerPrintIcon(context),
            SizedBox(
              height: 40.0,
            ),
            buildFingerPrintError(context),
          ],
        ),
      ),
    );
  }

  void fingerAuthenticate() async {
    final isAuthenticated = await LocalAuthApi.fingerPrintAuthenticate();

    if (isAuthenticated) Navigator.pushReplacementNamed(context, SMSAutoFillAuthPage.routeName);
  }

  Column buildFingerPrintError(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Oh Snap ! You Need to authenticate to move forward.",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        //
        SizedBox(
          height: 15.0,
        ),
        //
        TextButton(
          onPressed: () {
            fingerAuthenticate();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Try Again",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              //
              SizedBox(
                width: 5.0,
              ),
              //
              Icon(
                Icons.replay_rounded,
                color: Colors.white,
              ),
            ],
          ),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Container buildFingerPrintIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.black54,
      ),
      child: Icon(
        Icons.fingerprint_rounded,
        color: Theme.of(context).primaryColor,
        size: 140.0,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Finger Print Auth"),
    );
  }
}
