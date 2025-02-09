import 'package:flutter/material.dart';
import 'package:flutter_basic_setup/shared/components/form/bloc/form_state_bloc.dart';
import 'package:flutter_basic_setup/shared/extensions/read_or_null_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppFormBuilder extends StatefulWidget {
  final VoidCallback? onChanged;
  final WillPopCallback? onWillPop;
  final Widget Function(AppFormState appFormState) child;

  final AutovalidateMode? autovalidateMode;
  final Map<String, dynamic>? initialValue;

  final bool skipDisabled;
  final bool? enabled;
  final bool clearValueOnUnregister;
  final double maxWidth;
  final GlobalKey<FormBuilderState>? formKey;
  final Future<AppFormStateStageFunction> Function()? onSubmit;

  const AppFormBuilder({
    super.key,
    required this.formKey,
    required this.child,
    this.onChanged,
    this.onSubmit,
    this.autovalidateMode,
    this.onWillPop,
    this.maxWidth = double.infinity,
    this.initialValue,
    this.skipDisabled = false,
    this.enabled,
    this.clearValueOnUnregister = false,
  });

  @override
  State<AppFormBuilder> createState() => _AppFormBuilderState();
}

class _AppFormBuilderState extends State<AppFormBuilder> {
  AppFormStateBloc? appFormStateBloc;
  @override
  void didUpdateWidget(covariant AppFormBuilder oldWidget) {
    if (oldWidget.initialValue.toString() != widget.initialValue.toString()) {
      appFormStateBloc?.add(AppFormValidChanged(false));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var appFormStateB = context.readOrNull<AppFormStateBloc>();
    Widget formBuilder = BlocBuilder<AppFormStateBloc, AppFormState>(
      bloc: appFormStateB,
      builder: (context, state) {
        appFormStateBloc ??= context.readOrNull<AppFormStateBloc>();

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: FormBuilder(
            key: widget.formKey,
            autovalidateMode: widget.autovalidateMode,
            clearValueOnUnregister: widget.clearValueOnUnregister,
            initialValue: widget.initialValue ?? {},
            enabled: widget.enabled ??
                state.stage == const AppFormStateStageNormal(),
            onChanged: () {
              widget.onChanged?.call();
              var isValid = widget.formKey?.currentState?.isValid;
              if (isValid != null &&
                  widget.formKey?.currentState?.instantValue.toString() !=
                      widget.initialValue.toString()) {
                context
                    .read<AppFormStateBloc>()
                    .add(AppFormValidChanged(isValid));
              }
            },
            // onWillPop: widget.onWillPop,
            skipDisabled: widget.skipDisabled,
            child: widget.child(state),
          ),
        );
      },
    );
    if (appFormStateB != null) {
      return formBuilder;
    } else {
      return BlocProvider(
        create: (context) => AppFormStateBloc(onSubmit: widget.onSubmit),
        child: formBuilder,
      );
    }
  }
}
