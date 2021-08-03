import 'package:awesome_card/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/gradient/gradient_container.dart';

class CustomCreditCardWidget extends StatefulWidget {
  final String cardNumber;
  final String cardHolderName;
  final String cvvNumber;
  final String expiryDate;
  final String bankName;

  CustomCreditCardWidget(
      {Key? key,
      required this.cardNumber,
      required this.cardHolderName,
      required this.cvvNumber,
      required this.expiryDate,
      required this.bankName})
      : super(key: key);

  @override
  _CustomCreditCardWidgetState createState() => _CustomCreditCardWidgetState();
}

class _CustomCreditCardWidgetState extends State<CustomCreditCardWidget> {
  bool showBackSide = false;

  @override
  Widget build(BuildContext context) {
    String _decryptedCardNumber = MyEncryptionDecryption.decrypt64Fernet(widget.cardNumber);
    String _decryptedCVVNumber = MyEncryptionDecryption.decrypt64Fernet(widget.cvvNumber);
    String _decryptedExpiryDate = MyEncryptionDecryption.decrypt64Fernet(widget.expiryDate);
    return GestureDetector(
      onTap: () {
        setState(() {
          showBackSide = !showBackSide;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        child: CreditCard(
          cardNumber: _decryptedCardNumber,
          cardExpiry: _decryptedExpiryDate,
          cardHolderName: widget.cardHolderName,
          cvv: _decryptedCVVNumber,
          bankName: widget.bankName,
          showBackSide: showBackSide,
          backTextColor: Colors.white,
          frontBackground: GradientConatiner.buildGradientContainer(),
          backBackground: GradientConatiner.buildGradientContainer(),
          showShadow: true,
          textExpDate: 'Exp. Date',
          textName: 'Name',
          textExpiry: 'MM/YY',
        ),
      ),
    );
  }
}
