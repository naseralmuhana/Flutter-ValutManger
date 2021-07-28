import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';
import 'package:password_manager/widgets/form/custom_form.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class AddItemPage extends StatefulWidget {
  static final String routeName = 'AddItemPageRoute';

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlController;
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _noteController;

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add New Item'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: kDefaultPadding * 1.5,
              horizontal: kDefaultPadding * 0.5,
            ),
            child: CustomForm(
              formKey: _formKey,
              urlController: _urlController,
              nameController: _nameController,
              usernameController: _usernameController,
              emailController: _emailController,
              passwordController: _passwordController,
              noteController: _noteController,
              onPressed: _trySubmitForm,
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
        await _firestore.collection('items').add({
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
        CustomToast.showToast(message: '${_nameController.text} has been Added Successfully.');
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
