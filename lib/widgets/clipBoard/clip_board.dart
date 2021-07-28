import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/widgets/toast/toast.dart';

class CustomClipBoard {
  static IconButton buildCopyClipboard({required String value}) {
    return IconButton(
      tooltip: 'Copy',
      icon: Icon(Icons.content_copy_rounded),
      splashRadius: 20.0,
      onPressed: () async {
        await FlutterClipboard.copy(value);
        CustomToast.showToast(message: 'Copy to clipboard');
      },
    );
  }

  static IconButton buildControllerCopyClipboard({controller}) {
    return IconButton(
      tooltip: 'Copy',
      icon: Icon(Icons.content_copy_rounded),
      splashRadius: 20.0,
      onPressed: () async {
        await FlutterClipboard.copy(controller.text);
        CustomToast.showToast(message: 'Copy to clipboard');
      },
    );
  }

  static IconButton buildPasteClipboard({onPressedState}) {
    return IconButton(
      tooltip: 'Paste',
      icon: Icon(Icons.paste),
      splashRadius: 20.0,
      onPressed: () async {
        final value = await FlutterClipboard.paste();
        onPressedState(value);
        CustomToast.showToast(message: 'Paste Sucessfully');
      },
    );
  }

  static IconButton buildClearTextField({onPressed}) {
    return IconButton(
      tooltip: 'Clear',
      icon: Icon(Icons.clear),
      splashRadius: 20.0,
      onPressed: onPressed,
    );
  }

  static IconButton buildPasswordVisibility({obscureText, onPressed}) {
    return IconButton(
      icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
      splashRadius: 20.0,
      onPressed: onPressed,
    );
  }
}
