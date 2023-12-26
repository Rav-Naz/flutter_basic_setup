import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/extensions/color_extension.dart';
import 'package:flutter_basic_setup/shared/extensions/typography_extension.dart';

class AppTheme {
  /// Colors
  static const primary = Color(0xFF6200EE);
  static const secondary = Color(0xFF4F01BD);
  static const error = Color(0xFFD11406);
  static const success = Color(0xFF06D121);

  /// Typography
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );

  static const body = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
  );

  /// Light Theme
  ///
  ///
  static final light = ThemeData.light().copyWith(
    extensions: [lightColors, lightTypography],
  );
  static const lightColors = AppColorsExtension(
      primary: primary,
      secondary: secondary,
      error: error,
      success: success,
      background: Color(0xFFE6E6E6),
      text: Color(0xFF141414));

  static final lightTypography = AppTypographyExtension(
      title: title.copyWith(color: lightColors.text),
      body: body.copyWith(color: lightColors.text));

  /// Dark Theme
  ///
  ///
  static final dark = ThemeData.dark().copyWith(
    extensions: [darkColors, darkTypography],
  );

  static const darkColors = AppColorsExtension(
      primary: primary,
      secondary: secondary,
      error: error,
      success: success,
      background: Color(0xFF252525),
      text: Color(0xFFB4B4B4));

  static final darkTypography = AppTypographyExtension(
      title: title.copyWith(color: darkColors.text),
      body: body.copyWith(color: darkColors.text));
}
