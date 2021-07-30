import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomCreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String cvvNumber;
  final String expiryDate;
  // bool showBackView = false;

  CustomCreditCardWidget(
      {Key? key,
      required this.cardNumber,
      required this.cardHolderName,
      required this.cvvNumber,
      required this.expiryDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvNumber,
      showBackView: false,
      obscureCardCvv: true,
      obscureCardNumber: true,
      height: 210,
      cardBgColor: Colors.blueAccent,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      animationDuration: Duration(milliseconds: 1200),
    );
  }
}
