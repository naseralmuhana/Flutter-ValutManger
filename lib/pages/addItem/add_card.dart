import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';
import 'package:password_manager/widgets/clipBoard/clip_board.dart';
import 'package:password_manager/widgets/form/custom_card_form.dart';
import 'package:password_manager/widgets/form/components/custom_elevated_button.dart';

import 'package:password_manager/widgets/toast/toast.dart';

class AddCardPage extends StatefulWidget {
  static final String routeName = 'AddCardPageRoute';

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String? _cardNumber = '';
  String? _cardHolderName = '';
  String? _cvvNumber = '';
  String? _expiryDate = '';
  bool showBackView = false;
  late TextEditingController _bankName;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _atmPasswordController;
  late TextEditingController _noteController;
  GlobalKey<FormState> _creditCardFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> _extraFormKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _bankName = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _atmPasswordController = TextEditingController();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _bankName.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _atmPasswordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber = creditCardModel.cardNumber;
      _cardHolderName = creditCardModel.cardHolderName;
      _expiryDate = creditCardModel.expiryDate;
      _cvvNumber = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CreditCardWidget(
            cardNumber: _cardNumber!,
            expiryDate: _expiryDate!,
            cardHolderName: _cardHolderName!,
            cvvCode: _cvvNumber!,
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
          Column(
            children: [
              buildCarditCardForm(),
              CustomCardForm(
                extraFormKey: _extraFormKey,
                bankName: _bankName,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
                noteController: _noteController,
                atmPasswordController: _atmPasswordController,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.5,
                  vertical: kDefaultPadding * 0.5,
                ),
                child: CustomElevatedButton(
                  buttonLabel: 'Save',
                  onPressed: _trySubmitForm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _trySubmitForm() async {
    final isCreditCardValid = _creditCardFormKey.currentState!.validate();
    final isCustomCardValid = _extraFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isCreditCardValid && isCustomCardValid) {
      try {
        await _firestore.collection('CardItems').add({
          'cardNumber': MyEncryptionDecryption.encryptFernet(_cardNumber).base64,
          'expiryData': MyEncryptionDecryption.encryptFernet(_expiryDate).base64,
          'cvvNumber': MyEncryptionDecryption.encryptFernet(_cvvNumber).base64,
          'cardHolderName': _cardHolderName,
          'bankName': _bankName.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': MyEncryptionDecryption.encryptFernet(_passwordController.text).base64,
          'atmPassword': MyEncryptionDecryption.encryptFernet(_atmPasswordController.text).base64,
          'note': _noteController.text,
        }).then((value) {
          _cardNumber = null;
          _expiryDate = null;
          _cvvNumber = null;
          _cardHolderName = null;
          _usernameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _atmPasswordController.clear();
          _noteController.clear();
        });
        CustomToast.showToast(message: '${_bankName.text} has been Added Successfully.');
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomBarWidget.routeName,
          (route) => false,
        );
        _bankName.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  CreditCardForm buildCarditCardForm() {
    return CreditCardForm(
      cardNumber: _cardNumber!,
      expiryDate: _expiryDate!,
      cardHolderName: _cardHolderName!,
      cvvCode: _cvvNumber!,
      onCreditCardModelChange: onCreditCardModelChange,
      themeColor: Colors.blue,
      formKey: _creditCardFormKey,
      textColor: Colors.white,
      cardNumberDecoration: buildCardDecoration(
        labelText: 'Number *',
        hintText: 'xxxx xxxx xxxx xxxx',
        value: _cardNumber!,
      ),
      expiryDateDecoration: buildCardDecoration(
        labelText: 'Expiry Date *',
        hintText: 'xx/xx',
        value: _expiryDate!,
      ),
      cvvCodeDecoration: buildCardDecoration(
        labelText: 'CVV *',
        hintText: 'xxx',
        value: _cvvNumber!,
      ),
      cardHolderDecoration: buildCardDecoration(
        labelText: 'Card Holder Name *',
        value: _cardHolderName!,
      ),
    );
  }

  InputDecoration buildCardDecoration({
    required String labelText,
    String? hintText,
    required String value,
  }) {
    return InputDecoration(
      border: fOutlineInputBorder,
      suffixIcon: CustomClipBoard.buildCopyClipboard(value: value),
      enabledBorder: fOutlineInputEnabledBorder,
      labelText: labelText,
      labelStyle: kDecorationlabelStyle,
      hintText: hintText ?? null,
      hintStyle: kDecorationlabelStyle,
    );
  }
}
