import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'form_state_event.dart';
part 'form_state.dart';

class AppFormStateBloc extends Bloc<AppFormStateEvent, AppFormState> {
  AppFormStateBloc(
      {bool? isValid,
      AppFormStateStage? stage,
      Future<AppFormStateStageFunction> Function()? onSubmit})
      : super(AppFormState(
          isValid: isValid ?? false,
          stage: stage ?? const AppFormStateStageNormal(),
        )) {
    _submit = onSubmit;
    on<AppFormValidChanged>(_onFormValidChanged);
    on<AppFormStageChanged>(_onFormStageChanged);
  }
  Future<AppFormStateStageFunction> Function()? _submit;

  final Duration animationFadeOutDuration = 2000.ms;

  void _onFormValidChanged(
      AppFormValidChanged event, Emitter<AppFormState> emit) {
    if (state.isValid != event.newValid) {
      emit(state.copyWith(isValid: event.newValid));
    }
  }

  Future<void> _onFormStageChanged(
      AppFormStageChanged event, Emitter<AppFormState> emit) async {
    if (state.stage != event.newStage) {
      emit(state.copyWith(
          stage: event.newStage,
          isValid: (event.newStage is AppFormStateStageNormal)
              ? (event.newStage as AppFormStateStageNormal).isValid
              : null));
      if (event.newStage == const AppFormStateStageError()) {
        await Future.delayed(
          animationFadeOutDuration,
          () {
            emit(state.copyWith(stage: const AppFormStateStageNormal()));
          },
        );
      }
    }
  }

  void doSubmit() async {
    if (isValid && stage == const AppFormStateStageNormal()) {
      add(AppFormStageChanged(const AppFormStateStageLoading()));
      var result = await _submit?.call();
      if (result != null) {
        add(AppFormStageChanged(result.stage));
        if (result.then != null) {
          await Future.delayed(
            animationFadeOutDuration,
            () async {
              var resultThen = await result.then?.call();
              if (resultThen != null) {
                add(AppFormStageChanged(resultThen));
              }
            },
          );
        }
      } else {
        add(AppFormStageChanged(const AppFormStateStageNormal()));
      }
    }
  }

  bool get isValid => state.isValid;
  AppFormStateStage get stage => state.stage;
}

class AppFormStateStageFunction {
  AppFormStateStageFunction({required this.stage, this.then});
  AppFormStateStage stage;
  FutureOr<AppFormStateStage?> Function()? then;
}
