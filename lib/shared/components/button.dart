import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_basic_setup/shared/components/form/bloc/form_state_bloc.dart';
import 'package:flutter_basic_setup/shared/extensions/animation_extension.dart';
import 'package:flutter_basic_setup/shared/extensions/read_or_null_extension.dart';
import 'package:flutter_basic_setup/shared/extensions/theme_extenstion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Available types of [AppButton]
enum AppButtonType {
  ButtonPrimary,

  ButtonInverted,

  ButtonInvertedBlack,

  ButtonError,

  ButtonTransparent,

  ButtonForm,
}

/// Button widget which predefined styles
///
/// * Optional [onPressed] - On click function
/// * Optional [text] - Specifies button text
/// * Optional [customIcon] - Specifies button icon
/// * Optional [minWidth] - Determines min width of button in device pixels. If not given, it takes the value of the smallest amount of content.
/// * Optional [enabled] - Specifies whether the button is clickable (default true)
/// * Optional [backgroundColor] - Specifies background color
/// * Optional [textColor] - Specifies text color
/// * Optional [buttonType] - Specifies button appearance
// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(
      {super.key,
      this.onPressed,
      this.text,
      this.customIcon,
      this.minWidth,
      this.enabled = true,
      this.reactToFormChanges = true,
      this.iconOnRight = false,
      this.backgroundColor,
      this.textColor,
      this.textStyle,
      this.textAlign,
      this.buttonType = AppButtonType.ButtonPrimary});

  /// Optional: Specifies whether the button is clickable (default true)
  bool enabled;

  /// Optional: Specifies if button should react to [AppFormState] changes
  bool reactToFormChanges;

  /// Optional: Specifies button appearance
  AppButtonType buttonType;

  /// Optional: On click function
  void Function()? onPressed;

  /// Optional: Determines min width of button in device pixels. If not given, it takes the value of the smallest amount of content.
  double? minWidth;

  /// Optional: Specifies button text
  String? text;

  /// Optional: Specifies button icon
  String? customIcon;

  /// Optional: Specifies background color
  Color? backgroundColor;

  /// Optional: Specifies text color
  Color? textColor;

  /// Optional: Specifies position of the icon
  bool iconOnRight;

  /// Optional: Custom text style
  TextStyle? textStyle;

  /// Optional: Custom text alignment
  TextAlign? textAlign;

  /// Calculate color of button background
  Color _backgroundColor(BuildContext context, bool enabled) {
    switch (buttonType) {
      case AppButtonType.ButtonPrimary:

        /// If enabled color blue else color grey
        return enabled
            ? context.theme.appColors.primary
            : context.theme.appColors.text.withOpacity(0.1);
      case AppButtonType.ButtonInverted:

        /// Color grey
        return context.theme.appColors.text.withOpacity(0.1);
      case AppButtonType.ButtonInvertedBlack:

        /// Color grey
        return context.theme.appColors.text.withOpacity(0.1);
      case AppButtonType.ButtonError:

        /// If enabled color red else color grey
        return enabled
            ? context.theme.appColors.error
            : context.theme.appColors.text.withOpacity(0.1);
      case AppButtonType.ButtonTransparent:

        /// If enabled color red else color grey
        return Colors.transparent;
      case AppButtonType.ButtonForm:

        /// If enabled color red else color grey
        return enabled
            ? context.theme.appColors.primary
            : context.theme.appColors.background;
      default:

        /// If enabled color blue else color grey
        return enabled
            ? context.theme.appColors.primary
            : context.theme.appColors.text.withOpacity(0.1);
    }
  }

  /// Calculate color of button text
  TextStyle _textStyle(BuildContext context, bool enabled) {
    switch (buttonType) {
      case AppButtonType.ButtonPrimary:

        /// If enabled color white else color grey
        return context.theme.appTypos.title.copyWith(color: textColor);
      case AppButtonType.ButtonInverted:

        /// If enabled color blue else color grey
        return context.theme.appTypos.title.copyWith(color: textColor);
      case AppButtonType.ButtonInvertedBlack:

        /// If enabled color blue else color grey
        return context.theme.appTypos.title
            .copyWith(color: context.theme.appColors.background);
      case AppButtonType.ButtonError:

        /// If enabled color white else color grey
        return context.theme.appTypos.body
            .copyWith(color: textColor ?? context.theme.appColors.text);
      case AppButtonType.ButtonTransparent:

        /// If enabled color primary else color grey
        return context.theme.appTypos.body
            .copyWith(color: textColor ?? context.theme.appColors.text);
      case AppButtonType.ButtonForm:

        /// If enabled color primary else color grey
        return context.theme.appTypos.title.copyWith(
            color: textColor ??
                (enabled
                    ? context.theme.appColors.text
                    : context.theme.appColors.background));
      default:

        /// If enabled color white else color grey
        return context.theme.appTypos.body
            .copyWith(color: textColor ?? context.theme.appColors.text);
    }
  }

  /// Calculate color of button icon
  Color _iconStyle(BuildContext context) {
    switch (buttonType) {
      case AppButtonType.ButtonPrimary:

        /// If enabled color white else color grey
        return context.theme.appColors.text;
      case AppButtonType.ButtonInverted:

        /// If enabled color blue else color grey
        return context.theme.appColors.primary;
      case AppButtonType.ButtonInvertedBlack:

        /// If enabled color blue else color grey
        return context.theme.appColors.primary;
      case AppButtonType.ButtonError:

        /// If enabled color white else color grey
        return textColor ?? context.theme.appColors.text;
      case AppButtonType.ButtonTransparent:

        /// If enabled color primary else color grey
        return textColor ?? context.theme.appColors.text;
      default:

        /// If enabled color white else color grey
        return context.theme.appColors.text;
    }
  }

  SelectionContainer buildButton(
      BuildContext context, AppFormState? appFormState) {
    bool _isFormButton = buttonType == AppButtonType.ButtonForm;
    bool _isPrimaryLook = [
      AppButtonType.ButtonForm,
      AppButtonType.ButtonPrimary,
      AppButtonType.ButtonInverted,
      AppButtonType.ButtonInvertedBlack,
    ].contains(buttonType);
    bool _enabled = (appFormState != null && reactToFormChanges && _isFormButton
            ? appFormState.isValid
            : enabled) &&
        (appFormState?.stage != null
            ? _isFormButton
                ? appFormState!.stage == const AppFormStateStageNormal()
                : appFormState!.stage != const AppFormStateStageLoading()
            : onPressed != null);
    var bgColor = _isFormButton
        ? switch (appFormState?.stage) {
            AppFormStateStageError() => context.theme.appColors.error,
            AppFormStateStageSuccess() => context.theme.appColors.success,
            AppFormStateStageNormal() ||
            AppFormStateStageLoading() ||
            AppFormStateStage() ||
            null =>
              _backgroundColor(context, _enabled),
          }
        : _backgroundColor(context, _enabled);
    return SelectionContainer.disabled(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: !_enabled &&
                (buttonType == AppButtonType.ButtonInverted ||
                    buttonType == AppButtonType.ButtonInvertedBlack ||
                    buttonType == AppButtonType.ButtonTransparent)
            ? 0.6
            : 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: minWidth ?? 150),
          child: AnimatedContainer(
            clipBehavior: Clip.hardEdge,
            duration: context.defaultAnimationDuration,
            decoration: BoxDecoration(
              // gradient: _isPrimaryLook ? bgColor.appGradient() : null,
              color: backgroundColor ?? (!_isPrimaryLook ? bgColor : null),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ElevatedButton(

                /// If enabled then click on button run [onPressed] function else do nothing and become disable
                onPressed: _enabled
                    ? () {
                        if (_isFormButton) {
                          context.read<AppFormStateBloc>().doSubmit();
                        }
                        onPressed?.call();
                      }
                    : null,

                // Button style
                style: ButtonStyle(

                    /// Splash color of button
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return states.contains(MaterialState.pressed) ||
                                states.contains(MaterialState.hovered)
                            ? (buttonType == AppButtonType.ButtonInverted ||
                                    buttonType ==
                                        AppButtonType.ButtonInvertedBlack ||
                                    buttonType ==
                                        AppButtonType.ButtonTransparent
                                ? context.theme.appColors.primary
                                    .withOpacity(0.1)
                                : context.theme.appColors.text.withOpacity(0.1))
                            : null;
                      },
                    ),
                    textStyle: MaterialStateProperty.all(_isPrimaryLook
                        ? context.theme.appTypos.title
                        : context.theme.appTypos.body),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    side: buttonType == AppButtonType.ButtonInverted ||
                            buttonType == AppButtonType.ButtonInvertedBlack
                        ? MaterialStatePropertyAll(BorderSide(
                            color: buttonType == AppButtonType.ButtonInverted
                                ? context.theme.appColors.text
                                : context.theme.appColors.background,
                            width: 2,
                          ))
                        : null),
                child: Padding(
                  /// Horizontal space between text or icon and border of backgroundWhite
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Builder(
                    builder: (context) {
                      var normalButton = Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!iconOnRight) ...[
                            /// Icon or whitespace
                            customIcon != null
                                ? SvgPicture.asset(
                                    width: context.theme.appTypos.body.fontSize,
                                    height:
                                        context.theme.appTypos.body.fontSize,
                                    colorFilter: ColorFilter.mode(
                                        textColor ?? _iconStyle(context),
                                        BlendMode.srcIn),
                                    customIcon!,
                                  )
                                : const SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),

                            /// Spece between icon and text if icon and text is specified
                            customIcon != null && text != null
                                ? const SizedBox(
                                    width: 10,
                                    height: 0,
                                  )
                                : Container(),
                          ],

                          /// Button text or whitespace
                          Flexible(
                            child: Text(
                              textAlign: textAlign ?? TextAlign.center,
                              text != null
                                  ? (_isPrimaryLook
                                      ? text!.toUpperCase()
                                      : text!)
                                  : "",
                              softWrap: true,
                              style: textStyle ?? _textStyle(context, _enabled),
                            ),
                          ),
                          if (iconOnRight) ...[
                            /// Spece between icon and text if icon and text is specified
                            customIcon != null && text != null
                                ? const SizedBox(
                                    width: 10,
                                    height: 0,
                                  )
                                : Container(),

                            /// Icon or whitespace
                            customIcon != null
                                ? SvgPicture.asset(
                                    width: context.theme.appTypos.body.fontSize,
                                    height:
                                        context.theme.appTypos.body.fontSize,
                                    colorFilter: ColorFilter.mode(
                                        textColor ?? _iconStyle(context),
                                        BlendMode.srcIn),
                                    customIcon!,
                                  )
                                : const SizedBox(
                                    width: 0,
                                    height: 0,
                                  ),
                          ],
                        ],
                      );

                      if (buttonType != AppButtonType.ButtonForm) {
                        return normalButton;
                      }
                      return normalButton.animate().swap(
                        builder: (context, child) {
                          switch (appFormState?.stage) {
                            case AppFormStateStageLoading():
                              return SizedBox(
                                  width: context.theme.appTypos.body.fontSize,
                                  height: context.theme.appTypos.body.fontSize,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: _textStyle(context, _enabled).color,
                                  )
                                      .animate()
                                      .fadeIn(
                                          duration: 500
                                              .ms) // uses `Animate.defaultDuration`
                                      .move(
                                          begin: const Offset(-100, 0),
                                          duration: 300
                                              .ms) // runs after the above w/new duration
                                  );
                            case AppFormStateStageError():
                              return Icon(
                                Icons.block,
                                color: context.theme.appColors.text,
                                size: context.theme.appTypos.title.fontSize,
                              ).animate().fadeIn(duration: 150.ms).shake(
                                  delay: 100.ms,
                                  duration: context.defaultAnimationDuration,
                                  offset: const Offset(-15, 0),
                                  hz: 4);
                            case AppFormStateStageSuccess():
                              return Icon(
                                Icons.check,
                                color: context.theme.appColors.text,
                                size: context.theme.appTypos.title.fontSize,
                              ).animate().fadeIn(duration: 150.ms).scale(
                                    duration: context.defaultAnimationDuration,
                                  );
                            default:
                              return normalButton;
                          }
                        },
                      );
                    },
                  ),
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var appFormStateBloc = context.readOrNull<AppFormStateBloc>();

    /// Container determining minimum width of button
    if (appFormStateBloc != null && reactToFormChanges) {
      return BlocBuilder<AppFormStateBloc, AppFormState>(
        bloc: appFormStateBloc,
        builder: (context, state) {
          return buildButton(context, state);
        },
      );
    }
    return buildButton(context, null);
  }
}
