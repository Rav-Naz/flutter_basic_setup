// import 'secure_storage_mobile.dart'
//     if (dart.library.html) 'secure_storage_web.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage instance = SecureStorage._internal();

  factory SecureStorage() {
    return instance;
  }

  SecureStorage._internal();

  final _storage =
      FlutterSecureStorage(); // Calls platform-specific storage instance

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
