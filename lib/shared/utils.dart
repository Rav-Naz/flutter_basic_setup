import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basic_setup/shared/logger.dart';

abstract class AppUtils {
  /// Function which loads JSON file from assets
  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String assetsPath) async {
    AppLogger.log([Colors.yellow, "Loading data from file: $assetsPath"]);
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
}
