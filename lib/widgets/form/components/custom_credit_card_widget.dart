import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';

class CustomCreditCardWidget extends StatefulWidget {
  final String cardNumber;
  final String cardHolderName;
  final String cvvNumber;
  final String expiryDate;

  CustomCreditCardWidget(
      {Key? key,
      required this.cardNumber,
      required this.cardHolderName,
      required this.cvvNumber,
      required this.expiryDate})
      : super(key: key);

  @override
  _CustomCreditCardWidgetState createState() => _CustomCreditCardWidgetState();
}

class _CustomCreditCardWidgetState extends State<CustomCreditCardWidget> {
  bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    String _decryptedCardNumber = MyEncryptionDecryption.decrypt64Fernet(widget.cardNumber);
    String _decryptedCVVNumber = MyEncryptionDecryption.decrypt64Fernet(widget.cvvNumber);
    String _decryptedExpiryDate = MyEncryptionDecryption.decrypt64Fernet(widget.expiryDate);
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            showBackView = !showBackView;
          });
        },
        child: CreditCardWidget(
          cardNumber: _decryptedCardNumber,
          expiryDate: _decryptedExpiryDate,
          cardHolderName: widget.cardHolderName,
          cvvCode: _decryptedCVVNumber,
          showBackView: showBackView,
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
        ),
      ),
    );
  }
}
