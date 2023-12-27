import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/cubits/intl_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppTranslate on BuildContext {
  String translate(String identifier) =>
      watch<IntlCubit>().translate(identifier);
}
