import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> fingerPrintAuthenticate() async {
    final isAvailable = await hasBiometrics();

    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
        biometricOnly: true,
        androidAuthStrings: AndroidAuthMessages(signInTitle: 'FingerPrint ID Required.'),
        localizedReason: 'Scan Fingerprint to Authenticate.',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
