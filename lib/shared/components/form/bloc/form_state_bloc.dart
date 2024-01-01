import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'form_state_event.dart';
part 'form_state.dart';

class AppFormStateBloc extends Bloc<AppFormStateEvent, AppFormState> {
  AppFormStateBloc({bool? isValid, AppFormStateStage? stage})
      : super(AppFormState(
          isValid: isValid ?? false,
          stage: stage ?? const AppFormStateStageNormal(),
        )) {
    on<AppFormValidChanged>(_onFormValidChanged);
    on<AppFormStageChanged>(_onFormStageChanged);
  }

  void _onFormValidChanged(
      AppFormValidChanged event, Emitter<AppFormState> emit) {
    if (state.isValid != event.newValid) {
      emit(state.copyWith(isValid: event.newValid));
    }
  }

  void _onFormStageChanged(
      AppFormStageChanged event, Emitter<AppFormState> emit) {
    if (state.stage != event.newStage) {
      emit(state.copyWith(stage: event.newStage));
    }
  }

  bool get isValid => state.isValid;
  AppFormStateStage get stage => state.stage;
}
