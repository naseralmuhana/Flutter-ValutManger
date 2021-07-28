import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:password_manager/constants/variables.dart';

import 'package:password_manager/services/validation.dart';
import 'package:password_manager/pages/home/home.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/clipBoard/clip_board.dart';

import 'package:password_manager/widgets/custom_elevated_button.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class AddItemPage extends StatefulWidget {
  static final String routeName = 'AddItemPageRoute';

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Validation _validation = Validation();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool obscureText = true;
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
            child: Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  children: [
                    /// Url
                    buildTextFormField(
                      controller: _urlController,
                      label: 'Url',
                      textInputType: TextInputType.url,
                      autofillHints: [AutofillHints.url],
                    ),
                    SizedBox(height: 15.0),

                    /// Name
                    buildTextFormField(
                      controller: _nameController,
                      label: 'Name',
                      validator: _validation.isEmptyValidation,
                      textInputType: TextInputType.name,
                      autofillHints: [AutofillHints.url],
                    ),
                    SizedBox(height: 15.0),

                    /// Username
                    buildTextFormField(
                      controller: _usernameController,
                      label: 'Username',
                      autofillHints: [AutofillHints.name],
                    ),
                    SizedBox(height: 15.0),

                    /// Email
                    buildTextFormField(
                      controller: _emailController,
                      label: 'Email',
                      validator: _validation.emailValidator,
                      autofillHints: [AutofillHints.email],
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 15.0),

                    /// Password
                    buildTextFormField(
                      controller: _passwordController,
                      label: 'Password',
                      validator: _validation.isEmptyValidation,
                      obscureText: obscureText,
                      autofillHints: [AutofillHints.password],
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 15.0),

                    /// Note
                    buildTextFormField(
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
          HomePage.routeName,
          (route) => false,
        );
        _nameController.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  /// Widget
  Widget buildTextFormField({
    required controller,
    required String label,
    String? Function(String?)? validator,
    List<String>? autofillHints,
    TextInputType? textInputType,
    int? maxLines,
    bool? obscureText,
  }) {
    return TextFormField(
      controller: controller,
      autofillHints: autofillHints,
      keyboardType: textInputType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      // autofocus: true,
      validator: validator ?? null,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        suffixIcon: maxLines == null
            ? buildRowClipboard(
                controller: controller,
                obscureTextField: obscureText,
              )
            : buildColumnClipboard(
                controller: controller,
              ),
      ),
    );
  }

  Column buildColumnClipboard({controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomClipBoard.buildPasteClipboard(onPressedState: (val) {
          setState(() {
            controller.text += val;
          });
        }),
        CustomClipBoard.buildControllerCopyClipboard(controller: controller),
        CustomClipBoard.buildClearTextField(onPressed: () {
          setState(() {
            controller.clear();
          });
        }),
      ],
    );
  }

  Row buildRowClipboard({controller, obscureTextField}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        obscureTextField != null
            ? CustomClipBoard.buildPasswordVisibility(
                obscureText: obscureText,
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : Container(),
        CustomClipBoard.buildPasteClipboard(onPressedState: (val) {
          setState(() {
            controller.text += val;
          });
        }),
        CustomClipBoard.buildControllerCopyClipboard(controller: controller),
        CustomClipBoard.buildClearTextField(onPressed: () {
          setState(() {
            controller.clear();
          });
        }),
      ],
    );
  }
}
