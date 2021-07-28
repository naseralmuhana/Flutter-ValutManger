import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/validation.dart';
import 'package:password_manager/widgets/form/components/custom_text_form_field.dart';

Validation _validation = Validation();

class CustomCardForm extends StatelessWidget {
  CustomCardForm({
    Key? key,
    required GlobalKey<FormState> extraFormKey,
    required TextEditingController bankName,
    required TextEditingController usernameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController atmPasswordController,
    required TextEditingController noteController,
  })  : _extraFormKey = extraFormKey,
        _bankName = bankName,
        _usernameController = usernameController,
        _emailController = emailController,
        _passwordController = passwordController,
        _atmPasswordController = atmPasswordController,
        _noteController = noteController,
        super(key: key);

  final GlobalKey<FormState> _extraFormKey;
  final TextEditingController _bankName;
  final TextEditingController _usernameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _atmPasswordController;
  final TextEditingController _noteController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _extraFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.8),
        child: Column(
          children: [
            SizedBox(height: 18),
            CustomTextFormField(
              controller: _bankName,
              label: 'Bank Name *',
              validator: _validation.isEmptyValidation,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _usernameController,
              label: 'Username',
              autofillHints: [AutofillHints.name],
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _emailController,
              label: 'Email',
              validator: _validation.emailValidator,
              autofillHints: [AutofillHints.email],
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _passwordController,
              label: 'Password *',
              validator: _validation.isEmptyValidation,
              obscureText: true,
              autofillHints: [AutofillHints.password],
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _atmPasswordController,
              label: 'ATM Password',
              // validator: _validation.isEmptyValidation,
              obscureText: true,
              autofillHints: [AutofillHints.password],
              textInputType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _noteController,
              label: 'Note',
              maxLines: 6,
              textInputType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
