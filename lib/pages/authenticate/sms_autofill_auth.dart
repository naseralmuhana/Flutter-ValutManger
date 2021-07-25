import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/pages/authenticate/pin_code_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony/telephony.dart';

const String signCode = 'egW8syn8yWl';
const String _phoneNumber = '962787828021';

class SMSAutoFillAuthPage extends StatefulWidget {
  static final String routeName = 'SMSAutoFillAuthPageRoute';

  @override
  _SMSAutoFillAuthPageState createState() => _SMSAutoFillAuthPageState();
}

class _SMSAutoFillAuthPageState extends State<SMSAutoFillAuthPage> {
  final Telephony telephony = Telephony.instance;

  late String _message;
  late String _codeNumber;

  @override
  void initState() {
    _codeNumber = _createRandomNumber();
    _message = '<#>Your code is $_codeNumber\n $signCode';
    _sendSMS();
    _listenOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SMS AutoFill'),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  colorBuilder: FixedColorBuilder(kPrimaryColor),
                ),
                cursor: Cursor(
                  enabled: true,
                  color: kPrimaryColor,
                ),
                codeLength: 4,
                onCodeChanged: (value) {
                  if (value == _codeNumber) Navigator.pushReplacementNamed(context, PinCodeAuthPage.routeName);
                },
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text(
                'Resend Code',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                final sign = await SmsAutoFill().getAppSignature;
                print(sign);
                _codeNumber = _createRandomNumber();
                _message = '<#>Your code is $_codeNumber\n $signCode';
                _sendSMS();
                _listenOtp();
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("SMS AutoFill Auth"),
    );
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  String _createRandomNumber() {
    String randomNumber = '';
    Random random = new Random();
    for (int i = 0; i < 4; i++) {
      randomNumber += random.nextInt(10).toString();
    }

    return randomNumber;
  }

  Future<void> _sendSMS() async {
    await telephony.sendSms(
      to: _phoneNumber,
      message: _message,
    );
  }
}
