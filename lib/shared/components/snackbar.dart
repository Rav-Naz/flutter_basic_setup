import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_basic_setup/shared/extensions/theme_extenstion.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

enum AppSnackbarType {
  success,
  error,
  info,
  warning,
}

class AppSnackbar {
  static void show(String message, AppSnackbarType type,
      {Duration duration = const Duration(seconds: 4),
      void Function()? onTap}) {
    var context = scaffoldKey.currentContext;
    var animationDuration = const Duration(milliseconds: 300);
    if (context == null) return;
    var width = MediaQuery.of(context).size.width.clamp(0, 400).toDouble();
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      duration: duration + animationDuration,
      width: width,
      content: GestureDetector(
        onTap: onTap ?? scaffoldKey.currentState?.hideCurrentSnackBar,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: switch (type) {
              AppSnackbarType.success => context.theme.appColors.success,
              AppSnackbarType.error => context.theme.appColors.error,
              AppSnackbarType.info => Colors.blue,
              AppSnackbarType.warning => Colors.orange,
            },
          ),
          padding: const EdgeInsets.all(16),
          child: Stack(children: [
            Positioned(
              right: 0,
              child: Transform.scale(
                scale: 5,
                child: Transform.rotate(
                  angle: -pi / 12.0,
                  child: Icon(
                    switch (type) {
                      AppSnackbarType.success => Icons.check_circle_outlined,
                      AppSnackbarType.error => Icons.error_outline_outlined,
                      AppSnackbarType.info => Icons.info_outlined,
                      AppSnackbarType.warning => Icons.warning_amber_outlined,
                    },
                    color: context.theme.appColors.text.withOpacity(0.2),
                    size: 20,
                  ),
                ),
              ),
            ),
            Text(message, style: context.theme.appTypos.body),
          ]),
        )
            .animate()
            .scale(duration: animationDuration, curve: Curves.easeOutCubic)
            .fadeIn(duration: animationDuration, curve: Curves.easeOutCubic)
            .fadeOut(delay: duration - animationDuration),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.height - 150,
      //     left: 10,
      //     right: 10),
    ));
  }
}
