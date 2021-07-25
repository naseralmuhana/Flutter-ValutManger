import 'dart:async';
import 'package:flutter/material.dart';
import 'package:password_manager/pages/home/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeAuthPage extends StatefulWidget {
  static final String routeName = 'PinCodeAuthPageRoute';

  @override
  _PinCodeAuthPageState createState() => _PinCodeAuthPageState();
}

class _PinCodeAuthPageState extends State<PinCodeAuthPage> {
  final String _requiredNumber = '261097';
  late StreamController<ErrorAnimationType> _errorController;
  TextEditingController _pinCodeTextEditingController = TextEditingController();
  bool hasError = false;

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPinCodeIcon(context),
                  SizedBox(
                    height: 40.0,
                  ),
                  buildPinCodeTitle(),
                  SizedBox(height: 48),
                  _buildPinCodeTextField(context),
                  buildPinCodeErrorMessage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildPinCodeErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        hasError ? "*Please Enter the Pin Code" : "",
        style: TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Text buildPinCodeTitle() {
    return Text(
      'Enter Pin Code',
      style: TextStyle(fontSize: 40),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('PinCode Auth'),
      centerTitle: true,
    );
  }

  Container buildPinCodeIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.black54,
      ),
      child: Icon(
        Icons.lock_outline_rounded,
        color: Theme.of(context).primaryColor,
        size: 140.0,
      ),
    );
  }

  PinCodeTextField _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: _pinCodeTextEditingController,
      autoFocus: true,
      length: 6,
      obscureText: true,
      errorAnimationController: _errorController,
      autoDismissKeyboard: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      enablePinAutofill: false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        selectedColor: Colors.black,
        activeColor: Theme.of(context).primaryColor,
      ),
      onChanged: (value) {},
      onCompleted: (value) {
        if (value == _requiredNumber) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else {
          _errorController.add(ErrorAnimationType.shake);
          setState(
            () {
              hasError = true;
              _pinCodeTextEditingController.clear();
            },
          );
        }
      },
    );
  }
}
