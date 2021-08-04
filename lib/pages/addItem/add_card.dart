import 'package:awesome_card/awesome_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/services/formatter/field_formatter.dart';
import 'package:password_manager/services/validation.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';
import 'package:password_manager/widgets/form/components/custom_elevated_button.dart';
import 'package:password_manager/widgets/form/components/custom_text_form_field.dart';
import 'package:password_manager/widgets/gradient/gradient_container.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class AddCardPage extends StatefulWidget {
  static final String routeName = 'AddCardPageRoute';

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final Validation _validation = Validation();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? cardNumber = '';
  String? cardHolderName = '';
  String? cvvNumber = '';
  String? expiryDate = '';
  String? bankName;
  bool showBackSide = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController cardNumberController;
  late TextEditingController cardHolderNameController;
  late TextEditingController cvvNumberController;
  late TextEditingController expiryDateController;
  late TextEditingController bankNameController;
  late TextEditingController titleController;
  late TextEditingController passwordController;
  late TextEditingController noteController;
  late FocusNode _focusNode;

  @override
  void initState() {
    cardNumberController = TextEditingController();
    cardHolderNameController = TextEditingController();
    cvvNumberController = TextEditingController();
    expiryDateController = TextEditingController();
    bankNameController = TextEditingController();
    titleController = TextEditingController();
    passwordController = TextEditingController();
    noteController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBackSide = true : showBackSide = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    cvvNumberController.dispose();
    expiryDateController.dispose();
    bankNameController.dispose();
    titleController.dispose();
    passwordController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildCreditCard(),
            buildCreditCardForm(),
          ],
        ),
      ),
    );
  }

  Form buildCreditCardForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultPadding * 1.5,
          horizontal: kDefaultPadding * 0.5,
        ),
        child: Column(
          children: <Widget>[
            CustomTextFormField(
              controller: cardNumberController,
              label: 'Card Number *',
              validator: _validation.isEmptyValidation,
              inputFormatters: [FieldFormatter.cardNumberFormatter],
              textInputType: TextInputType.number,
              onChanged: (value) => setState(() => cardNumber = value),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: expiryDateController,
                    label: 'Expiry Date *',
                    validator: _validation.isEmptyValidation,
                    inputFormatters: [FieldFormatter.expiryDateFormatter],
                    textInputType: TextInputType.number,
                    onChanged: (value) => setState(() => expiryDate = value),
                    noSuffixIcon: true,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomTextFormField(
                    controller: cvvNumberController,
                    label: 'CVV *',
                    validator: _validation.isEmptyValidation,
                    inputFormatters: [FieldFormatter.cvvNumberFormatter],
                    textInputType: TextInputType.number,
                    onChanged: (value) => setState(() => cvvNumber = value),
                    focusNode: _focusNode,
                    noSuffixIcon: true,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            CustomTextFormField(
              controller: cardHolderNameController,
              label: 'Card Holder Name *',
              validator: _validation.isEmptyValidation,
              onChanged: (value) => setState(() => cardHolderName = value),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: bankNameController,
              validator: _validation.isEmptyValidation,
              label: 'Bank Name *',
              onChanged: (value) => setState(() => bankName = value),
            ),
            SizedBox(height: 20),

            CustomTextFormField(
              controller: titleController,
              validator: _validation.isEmptyValidation,
              label: 'Title',
            ),
            SizedBox(height: 20),

            /// Password
            CustomTextFormField(
              controller: passwordController,
              label: 'Password *',
              validator: _validation.isEmptyValidation,
              obscureText: true,
              autofillHints: [AutofillHints.password],
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 15.0),

            /// Note
            CustomTextFormField(
              controller: noteController,
              label: 'Note',
              maxLines: 6,
              textInputType: TextInputType.multiline,
            ),
            SizedBox(height: 15.0),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCreditCard() {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: CreditCard(
        cardNumber: this.cardNumber,
        cardExpiry: this.expiryDate,
        cardHolderName: this.cardHolderName,
        cvv: this.cvvNumber,
        bankName: bankName ?? 'Bank Name',
        showBackSide: showBackSide,
        frontBackground: GradientConatiner.buildGradientContainer(),
        backBackground: GradientConatiner.buildGradientContainer(),
        showShadow: true,
        textExpDate: 'Exp. Date',
        textName: 'Card Holder Name',
        textExpiry: 'MM/YY',
      ),
    );
  }

  Widget buildSaveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.5,
        vertical: kDefaultPadding * 0.5,
      ),
      child: CustomElevatedButton(
        buttonLabel: 'Save',
        onPressed: _trySubmitForm,
      ),
    );
  }

  void _trySubmitForm() async {
    final isCreditCardValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isCreditCardValid) {
      try {
        await _firestore.collection('CardItems').add({
          'cardNumber': MyEncryptionDecryption.encryptFernet(cardNumber).base64,
          'expiryDate': MyEncryptionDecryption.encryptFernet(expiryDate).base64,
          'cvvNumber': MyEncryptionDecryption.encryptFernet(cvvNumber).base64,
          'cardHolderName': cardHolderName,
          'bankName': bankName,
          'title': titleController.text,
          'password': MyEncryptionDecryption.encryptFernet(passwordController.text).base64,
          'note': noteController.text,
        }).then((value) {
          cardNumber = null;
          expiryDate = null;
          cvvNumber = null;
          cardHolderName = null;
          bankName = null;
          cardNumberController.clear();
          cardHolderNameController.clear();
          cvvNumberController.clear();
          expiryDateController.clear();
          bankNameController.clear();
          passwordController.clear();
          noteController.clear();
        });
        CustomToast.showToast(message: '${titleController.text} has been Added Successfully.');
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomBarWidget.routeName,
          (route) => false,
          arguments: {1},
        );
        titleController.clear();
      } catch (e) {
        print(e);
      }
    }
  }
}
