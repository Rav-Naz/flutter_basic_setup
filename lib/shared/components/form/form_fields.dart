import 'dart:async';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basic_setup/shared/cubits/intl_cubit.dart';
import 'package:flutter_basic_setup/shared/extensions/theme_extenstion.dart';
import 'package:flutter_basic_setup/shared/utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppFormFieldDecoration extends InputDecoration {
  AppFormFieldDecoration(
      BuildContext context, String name, Color stateColor, String? errorText)
      : super(
          labelText: name.toUpperCase(),
          labelStyle: context.theme.appTypos.input.copyWith(color: stateColor),
          counterStyle: context.theme.appTypos.body.copyWith(color: stateColor),
          errorText: errorText,
          errorMaxLines: 2,
          errorStyle: context.theme.appTypos.body
              .copyWith(color: context.theme.appColors.error, height: 1.5),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.theme.appColors.primary, width: 1.5)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.appColors.text, width: 1.5)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.theme.appColors.text.withOpacity(0.7),
                  width: 1.5)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.appColors.error, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.theme.appColors.error, width: 1.5)),
        );
}

// ignore: must_be_immutable
class AppFieldOperator extends StatelessWidget {
  AppFieldOperator({
    super.key,
    required this.onValidateStream,
    required this.hasFocusStream,
    required this.currentValueStream,
    required this.enabled,
    required this.builder,
    required this.validator,
  });
  bool dirty = false;
  bool touched = false;
  final Stream<bool> onValidateStream;
  final Stream<bool> hasFocusStream;
  final Stream<String?> currentValueStream;
  final bool enabled;
  final Widget Function(Color statusColor, String? errorText) builder;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Opacity(
        opacity: enabled ? 1.0 : 0.3,
        child: StreamBuilder<bool>(
            stream: onValidateStream,
            initialData: false,
            builder: (context, validate) {
              return StreamBuilder<bool>(
                  stream: hasFocusStream,
                  initialData: false,
                  builder: (context, isFocused) {
                    if (!dirty && touched && !isFocused.data!) {
                      dirty = true;
                    }
                    if (isFocused.data!) {
                      touched = true;
                    }
                    return StreamBuilder<String?>(
                        stream: currentValueStream,
                        builder: (context, inputValue) {
                          String? errorText = touched && dirty || validate.data!
                              ? validator?.call(inputValue.data)
                              : null;
                          Color stateColor = !enabled
                              ? context.theme.appColors.text.withOpacity(0.7)
                              : errorText != null
                                  ? context.theme.appColors.error
                                  : isFocused.data!
                                      ? context.theme.appColors.primary
                                      : context.theme.appColors.text;

                          return builder(stateColor, errorText);
                        });
                  });
            }),
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final String name;
  final String? label;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final void Function(String?)? onChanged;
  final String? Function(String?)? valueTransformer;
  final bool enabled;
  final void Function(String?)? onSaved;
  final AutovalidateMode autovalidateMode;
  final void Function()? onReset;
  final FocusNode? focusNode;
  final String? restorationId;
  final String? initialValue;
  final bool readOnly;
  final int? maxLines;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextAlign textAlign;
  final bool autofocus;
  final bool autocorrect;
  final double cursorWidth;
  final double? cursorHeight;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final InputCounterWidgetBuilder? buildCounter;
  final bool expands;
  final int? minLines;
  final bool? showCursor;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool enableSuggestions;
  final TextAlignVertical? textAlignVertical;
  final DragStartBehavior dragStartBehavior;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final ui.BoxWidthStyle selectionWidthStyle;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final ui.BoxHeightStyle selectionHeightStyle;
  final Iterable<String>? autofillHints;
  final String obscuringCharacter;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// TODO: Add rest fields
  const AppTextField({
    super.key,
    required this.name,
    this.label,
    this.validator,
    this.decoration,
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onReset,
    this.focusNode,
    this.restorationId,
    this.initialValue,
    this.readOnly = false,
    this.maxLines,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.keyboardType,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.onTapOutside,
    this.enableSuggestions = false,
    this.textAlignVertical,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.smartDashesType,
    this.smartQuotesType,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.autofillHints,
    this.obscuringCharacter = '•',
    this.mouseCursor,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.contentInsertionConfiguration,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _debouncer = Debouncer(milliseconds: 200);
  final FocusNode _focus = FocusNode();
  final onValidate = StreamController<bool>();
  final hasFocus = StreamController<bool>();
  final currentValue = StreamController<String?>();

  @override
  void initState() {
    currentValue.add(widget.initialValue);
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    hasFocus.add(_focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return AppFieldOperator(
        onValidateStream: onValidate.stream,
        hasFocusStream: hasFocus.stream,
        currentValueStream: currentValue.stream,
        enabled: widget.enabled,
        builder: (stateColor, errorText) {
          return FormBuilderTextField(
            name: widget.name,
            validator: widget.validator,
            decoration: widget.decoration ??
                AppFormFieldDecoration(context, widget.label ?? widget.name,
                    stateColor, errorText),
            onChanged: (value) {
              widget.onChanged?.call(value);
              _debouncer.run(() {
                currentValue.add((value?.isEmpty ?? true) ? null : value);
              });
            },
            valueTransformer: widget.valueTransformer,
            enabled: widget.enabled,
            onSaved: (newValue) {
              widget.onSaved?.call(newValue);
              onValidate.add(true);
            },
            autovalidateMode: widget.autovalidateMode,
            onReset: widget.onReset,
            focusNode: widget.focusNode ?? _focus,
            restorationId: widget.restorationId,
            initialValue: widget.initialValue,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            obscureText: widget.obscureText,
            textCapitalization: widget.textCapitalization,
            scrollPadding: widget.scrollPadding,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            maxLengthEnforcement: widget.maxLengthEnforcement,
            textAlign: widget.textAlign,
            autofocus: widget.autofocus,
            autocorrect: widget.autocorrect,
            cursorWidth: widget.cursorWidth,
            cursorHeight: widget.cursorHeight,
            keyboardType: widget.keyboardType,
            style: widget.style,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            strutStyle: widget.strutStyle,
            textDirection: widget.textDirection,
            maxLength: widget.maxLength,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            cursorRadius: widget.cursorRadius,
            cursorColor: widget.cursorColor,
            keyboardAppearance: widget.keyboardAppearance,
            buildCounter: widget.buildCounter,
            expands: widget.expands,
            minLines: widget.minLines,
            showCursor: widget.showCursor,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            enableSuggestions: widget.enableSuggestions,
            textAlignVertical: widget.textAlignVertical,
            dragStartBehavior: widget.dragStartBehavior,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            selectionWidthStyle: widget.selectionWidthStyle,
            smartDashesType: widget.smartDashesType,
            smartQuotesType: widget.smartQuotesType,
            selectionHeightStyle: widget.selectionHeightStyle,
            autofillHints: widget.autofillHints,
            obscuringCharacter: widget.obscuringCharacter,
            mouseCursor: widget.mouseCursor,
            contextMenuBuilder: widget.contextMenuBuilder,
            magnifierConfiguration: widget.magnifierConfiguration,
            contentInsertionConfiguration: widget.contentInsertionConfiguration,
          );
        },
        validator: widget.validator);
  }
}

class InputValidators {
  /// Validator that check if string is not null and is correct email
  static String? isValidEmail(String? string, {bool canBeNull = false}) {
    if (canBeNull) {
      if (string == null || (string.isEmpty)) return null;
    } else {
      var isNull = isNotNull(string);
      if (isNull != null) {
        return isNull;
      }
    }

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return !emailRegExp.hasMatch(string!)
        ? IntlCubit.translateStatic("shared.components.input.valid_e-mail")
        : null;
  }

  /// Validator that check if string is not null and is correct format date
  static String? isValidDate(String? string, {bool canBeNull = false}) {
    if (canBeNull) {
      if (string == null || (string.isEmpty)) return null;
    } else {
      var isNull = isNotNull(string);
      if (isNull != null) {
        return isNull;
      }
    }
    final components = string!.split("-");
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
      }
    }
    return IntlCubit.translateStatic("shared.components.input.valid_date");
  }

  /// Validator that check if string is not null
  static String? isNotNull(String? string) {
    return string == null || string.isEmpty || string == ""
        ? IntlCubit.translateStatic("shared.components.input.not_null")
        : null;
  }

  /// Validator that check if string is not null
  static String? isNotNullAndSameValue(String? string, String? compareString,
      {String? message}) {
    var isNull = isNotNull(string);
    if (isNull != null || string == null) {
      return isNull;
    }
    return string != compareString
        ? message ??
            IntlCubit.translateStatic("shared.components.input.same_string")
        : null;
  }

  /// Validator that check if string complete regex
  static String? customRegex(String? string, String pattern,
      {String? message, bool canBeNull = false}) {
    RegExp regex = RegExp(pattern);
    if (string == null) {
      if (canBeNull) {
        return null;
      } else {
        return IntlCubit.translateStatic("shared.components.input.not_null");
      }
    } else {
      if (!regex.hasMatch(string)) {
        return message ??
            IntlCubit.translateStatic("shared.components.input.regex");
      } else {
        return null;
      }
    }
  }

  /// Validator that check if string has appropriate number of characters
  static String? maxLength(String? string, int maxLength) {
    if (string == null) return null;
    return string.length > maxLength
        ? "${IntlCubit.translateStatic("shared.components.input.max_length")} $maxLength"
        : null;
  }

  /// Validator that check if string has appropriate number of characters
  static String? minLength(String? string, int minLength) {
    if (string == null || string.isEmpty) return null;
    return string.length < minLength
        ? "${IntlCubit.translateStatic("shared.components.input.min_length")} $minLength"
        : null;
  }

  /// Validator that check if string is not null and value has appropriate number of characters
  static String? isNotNullAndMaxLength(String? string, int maxLength) {
    var isNull = isNotNull(string);
    if (isNull != null || string == null) {
      return isNull;
    }
    return string.length > maxLength
        ? "${IntlCubit.translateStatic("shared.components.input.max_length")} $maxLength"
        : null;
  }

  /// Validator that check if string is not in list
  static String? isNotInList(String? string, List<String> list,
      {String? message}) {
    return list.contains(string)
        ? message ??
            IntlCubit.translateStatic("shared.components.input.in_list")
        : null;
  }

  /// Validator that check if string is not null and not in list
  static String? isNotNullAndNotInList(String? string, List<String> list,
      {String? message}) {
    var isNull = isNotNull(string);
    if (isNull != null || string == null) {
      return isNull;
    }
    return list.contains(string)
        ? message ??
            IntlCubit.translateStatic("shared.components.input.in_list")
        : null;
  }

  /// Validator that check if string is not null and not in list and has appropriate number of characters
  static String? isNotInListAndMaxLength(
      String? string, int maxChars, List<String> list,
      {String? message}) {
    var isInList = isNotInList(string, list, message: message);
    if (isInList != null) {
      return isInList;
    }

    return maxLength(string, maxChars);
  }

  /// Validator that check if string is not null and not in list and has appropriate number of characters
  static String? isNotNullAndNotInListAndMaxLength(
      String? string, int maxChars, List<String> list,
      {String? message}) {
    var isNull = isNotNull(string);
    if (isNull != null || string == null) {
      return isNull;
    }
    var isInList = isNotInList(string, list, message: message);
    if (isInList != null) {
      return isInList;
    }

    return maxLength(string, maxChars);
  }

  static String? isPhoneValid(String? string) {
    var isNull = isNotNull(string);
    if (isNull != null) {
      return isNull;
    }
    final phoneRegExp =
        RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{3,6}$");
    return !phoneRegExp.hasMatch(string!)
        ? IntlCubit.translateStatic("shared.components.input.phone_valid")
        : null;
  }

  static String? isNotGreaterThan(String? value1, String? value2, String from) {
    var isNull1 = isNotNull(value1);
    var isNull2 = isNotNull(value2);
    if (isNull1 != null) {
      return isNull1;
    }
    if (isNull2 != null) {
      return isNull2;
    }
    var num1 = double.parse(value1!);
    var num2 = double.parse(value2!);
    return num1 > num2
        ? "${IntlCubit.translateStatic("shared.components.input.greater")} $from"
        : null;
  }

  static String? isNotLowerThan(String? value1, String? value2, String from,
      {bool canBeNull = false}) {
    var isNull1 = isNotNull(value1);
    var isNull2 = isNotNull(value2);
    if (isNull1 != null) {
      return canBeNull ? null : isNull1;
    }
    if (isNull2 != null) {
      return isNull2;
    }
    var num1 = double.parse(value1!);
    var num2 = double.parse(value2!);
    return num1 < num2
        ? "${IntlCubit.translateStatic("shared.components.input.lower")} $from"
        : null;
  }

  static String? isNotPastDate(String? value,
      {DateTime? customDate, bool canBeNull = true}) {
    var validDate = isValidDate(value, canBeNull: canBeNull);
    if (validDate != null) return validDate;
    if (value == null && canBeNull) return null;
    final components = value!.split("-");

    /// If data was succesfully splitted then transform it
    if (components.length == 3) {
      final day = int.tryParse(components[0]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[2]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day, 23, 59, 59);
        if (date.isBefore(customDate ?? DateTime.now())) {
          return customDate != null
              ? IntlCubit.translateStatic("shared.components.input.after_date")
              : IntlCubit.translateStatic("shared.components.input.past_date");
        }
      }
    }
    return null;
  }
}
