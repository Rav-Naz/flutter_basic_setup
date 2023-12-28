import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/components/form/bloc/form_state_bloc.dart';
import 'package:flutter_basic_setup/shared/extensions/read_or_null_extension.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppFormBuilder extends StatelessWidget {
  final VoidCallback? onChanged;
  final WillPopCallback? onWillPop;
  final Widget child;

  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic> initialValue;

  final bool skipDisabled;
  final bool? enabled;
  final bool clearValueOnUnregister;
  final GlobalKey<FormBuilderState> formKey;

  const AppFormBuilder({
    required this.formKey,
    required this.child,
    this.onChanged,
    this.autovalidateMode,
    this.onWillPop,
    this.initialValue = const <String, dynamic>{},
    this.skipDisabled = false,
    this.enabled,
    this.clearValueOnUnregister = false,
  });
  @override
  Widget build(BuildContext context) {
    var appFormStateBloc = context.readOrNull<AppFormStateBloc>();
    return FormBuilder(
      key: formKey,
      autovalidateMode: autovalidateMode,
      clearValueOnUnregister: clearValueOnUnregister,
      enabled: enabled ??
          appFormStateBloc?.stage != const AppFormStateStageLoading(),
      initialValue: initialValue,
      onChanged: () {
        onChanged?.call();
        var isValid = formKey.currentState?.isValid;
        if (isValid != null) {
          appFormStateBloc?.add(AppFormValidChanged(isValid));
        }
      },
      onWillPop: onWillPop,
      skipDisabled: skipDisabled,
      child: child,
    );
  }
}
