import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/responsive.dart';

extension AppResponsive on BuildContext {
  AppResizableSize get responsiveSize => AppResizable.size(this);
}
