import 'package:flutter/material.dart';
import 'package:password_manager/services/validation.dart';
import 'package:password_manager/widgets/form/components/custom_elevated_button.dart';
import 'package:password_manager/widgets/form/components/custom_text_form_field.dart';

Validation _validation = Validation();

class CustomNoteForm extends StatelessWidget {
  const CustomNoteForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController noteController,
    required this.onPressed,
  })  : _formKey = formKey,
        _titleController = titleController,
        _noteController = noteController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _noteController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            /// Title
            CustomTextFormField(
              controller: _titleController,
              label: 'Title *',
              validator: _validation.isEmptyValidation,
              textInputType: TextInputType.name,
              autofillHints: [AutofillHints.url],
            ),
            SizedBox(height: 15.0),

            /// Note
            CustomTextFormField(
              controller: _noteController,
              validator: _validation.isEmptyValidation,
              label: 'Note *',
              maxLines: 20,
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
