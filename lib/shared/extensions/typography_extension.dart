import 'package:flutter/material.dart';

class AppTypographyExtension extends ThemeExtension<AppTypographyExtension> {
  const AppTypographyExtension({
    required this.title,
    required this.body,
  });

  final TextStyle title;
  final TextStyle body;

  @override
  ThemeExtension<AppTypographyExtension> copyWith({
    TextStyle? title,
    TextStyle? body,
  }) {
    return AppTypographyExtension(
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  ThemeExtension<AppTypographyExtension> lerp(
    covariant ThemeExtension<AppTypographyExtension>? other,
    double t,
  ) {
    if (other is! AppTypographyExtension) {
      return this;
    }

    return AppTypographyExtension(
      title: TextStyle.lerp(title, other.title, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
    );
  }
}
