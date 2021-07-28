import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 16.0,
    );
  }
}
