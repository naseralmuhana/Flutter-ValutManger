import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:password_manager/constants/variables.dart';

import 'package:password_manager/services/validation.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';

import 'package:password_manager/widgets/custom_elevated_button.dart';
import 'package:password_manager/widgets/custom_text_form_field.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class EditItemPage extends StatefulWidget {
  static final String routeName = 'EditItemPageRoute';

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  Validation _validation = Validation();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlController;
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _noteController;
  var item;

  @override
  void initState() {
    _urlController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    item = ModalRoute.of(context)!.settings.arguments;

    _urlController.text = item['url'];
    _nameController.text = item['name'];
    _usernameController.text = item['username'];
    _emailController.text = item['email'];
    String _decryptedPassword = MyEncryptionDecryption.decrypt64Fernet(item['password']);
    _passwordController.text = _decryptedPassword;
    _noteController.text = item['note'];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _urlController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Item'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * 1.5,
            horizontal: kDefaultPadding * 0.5,
          ),
          child: Form(
            key: _formKey,
            child: AutofillGroup(
              child: Column(
                children: [
                  /// Url
                  CustomTextFormField(
                    controller: _urlController,
                    label: 'Url',
                    textInputType: TextInputType.url,
                    autofillHints: [AutofillHints.url],
                  ),
                  SizedBox(height: 15.0),

                  /// Name
                  CustomTextFormField(
                    controller: _nameController,
                    label: 'Name',
                    validator: _validation.isEmptyValidation,
                    textInputType: TextInputType.name,
                    autofillHints: [AutofillHints.url],
                  ),
                  SizedBox(height: 15.0),

                  /// Username
                  CustomTextFormField(
                    controller: _usernameController,
                    label: 'Username',
                    autofillHints: [AutofillHints.name],
                  ),
                  SizedBox(height: 15.0),

                  /// Email
                  CustomTextFormField(
                    controller: _emailController,
                    label: 'Email',
                    validator: _validation.emailValidator,
                    autofillHints: [AutofillHints.email],
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 15.0),

                  /// Password
                  CustomTextFormField(
                    controller: _passwordController,
                    label: 'Password',
                    validator: _validation.isEmptyValidation,
                    obscureText: true,
                    autofillHints: [AutofillHints.password],
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 15.0),

                  /// Note
                  CustomTextFormField(
                    controller: _noteController,
                    label: 'Note',
                    maxLines: 6,
                    textInputType: TextInputType.multiline,
                  ),
                  SizedBox(height: 15.0),

                  /// add item button
                  CustomElevatedButton(
                    buttonLabel: 'Save',
                    onPressed: _trySubmitForm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Methods
  void _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        await _firestore.collection('items').doc(item.id).update({
          'url': _urlController.text,
          'name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': MyEncryptionDecryption.encryptFernet(_passwordController.text).base64,
          'note': _noteController.text,
        }).then((value) {
          _urlController.clear();
          _usernameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _noteController.clear();
        });
        CustomToast.showToast(message: '${_nameController.text} has been Updated Successfully.');
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomBarWidget.routeName,
          (route) => false,
        );
        _nameController.clear();
      } catch (e) {
        print(e);
      }
    }
  }
}
