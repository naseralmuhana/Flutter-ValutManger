import 'package:flutter/material.dart';
import 'package:password_manager/services/validation.dart';
import 'package:password_manager/widgets/form/components/custom_elevated_button.dart';
import 'package:password_manager/widgets/form/components/custom_text_form_field.dart';

Validation _validation = Validation();

class CustomLoginForm extends StatelessWidget {
  final TextEditingController urlController;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController noteController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const CustomLoginForm(
      {Key? key,
      required this.urlController,
      required this.nameController,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.noteController,
      required this.onPressed,
      required this.formKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            /// Url
            CustomTextFormField(
              controller: urlController,
              label: 'Url',
              textInputType: TextInputType.url,
              autofillHints: [AutofillHints.url],
            ),
            SizedBox(height: 15.0),

            /// Name
            CustomTextFormField(
              controller: nameController,
              label: 'Name *',
              validator: _validation.isEmptyValidation,
              textInputType: TextInputType.name,
              autofillHints: [AutofillHints.url],
            ),
            SizedBox(height: 15.0),

            /// Username
            CustomTextFormField(
              controller: usernameController,
              label: 'Username',
              autofillHints: [AutofillHints.name],
            ),
            SizedBox(height: 15.0),

            /// Email
            CustomTextFormField(
              controller: emailController,
              label: 'Email',
              validator: _validation.emailValidator,
              autofillHints: [AutofillHints.email],
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15.0),

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

            /// add item button
            CustomElevatedButton(
              buttonLabel: 'Save',
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
