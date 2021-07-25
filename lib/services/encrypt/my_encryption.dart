import 'package:encrypt/encrypt.dart' as encrypt;

class MyEncryptionDecryption {
  /// for Fernet encryption/decryption
  static final keyFernet = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  static final fernet = encrypt.Fernet(keyFernet);
  static final encrypterFernet = encrypt.Encrypter(fernet);

  static encryptFernet(text) {
    final encrypted = encrypterFernet.encrypt(text);
    return encrypted;
  }

  static decrypt64Fernet(text) {
    final decrypted = encrypterFernet.decrypt64(text);
    return decrypted;
  }

  static decryptFernet(text) {
    final decrypted = encrypterFernet.decrypt(text);
    return decrypted;
  }

  static final keyFernet2 = encrypt.Key.fromUtf8('asdzxcqwe123654987poiuytreqasdvb');
  static final fernet2 = encrypt.Fernet(keyFernet2);
  static final encrypterFernet2 = encrypt.Encrypter(fernet2);

  static encryptFernet2(text) {
    final encrypted = encrypterFernet2.encrypt(text);
    return encrypted;
  }

  static decrypt64Fernet2(text) {
    final decrypted = encrypterFernet2.decrypt64(text);
    return decrypted;
  }
}
