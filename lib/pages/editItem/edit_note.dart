import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/constants/variables.dart';
import 'package:password_manager/services/encrypt/my_encryption.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';
import 'package:password_manager/widgets/form/custom_note_form.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class EditNotePage extends StatefulWidget {
  static final String routeName = 'EditNotePageRoute';

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  var item;

  @override
  void initState() {
    _titleController = TextEditingController();
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    item = ModalRoute.of(context)!.settings.arguments;
    _titleController.text = item['title'];
    String _decryptedNote = MyEncryptionDecryption.decrypt64Fernet(item['note']);
    _noteController.text = _decryptedNote;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Note'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * 1.5,
            horizontal: kDefaultPadding * 0.5,
          ),
          child: CustomNoteForm(
            formKey: _formKey,
            titleController: _titleController,
            noteController: _noteController,
            onPressed: _trySubmitForm,
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
        await _firestore.collection('NoteItems').doc(item.id).update({
          'title': _titleController.text,
          'note': MyEncryptionDecryption.encryptFernet(_noteController.text).base64,
        }).then((value) {
          _noteController.clear();
        });
        CustomToast.showToast(message: '${_titleController.text} has been Updated Successfully.');
        Navigator.of(context).pushNamedAndRemoveUntil(BottomBarWidget.routeName, (route) => false, arguments: {3});
        _titleController.clear();
      } catch (e) {
        print(e);
      }
    }
  }
}
