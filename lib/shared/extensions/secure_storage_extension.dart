import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/utils/secure_storage/secure_storage.dart';

extension SecureStorageExtension on BuildContext {
  get storage => SecureStorage();
}
