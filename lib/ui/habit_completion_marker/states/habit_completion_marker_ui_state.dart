import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/habit_tracking_status.dart';

part 'habit_completion_marker_ui_state.freezed.dart';

@freezed
abstract class HabitCompletionMarkerUiState
    with _$HabitCompletionMarkerUiState {
  HabitCompletionMarkerUiState._();

  factory HabitCompletionMarkerUiState({@Default(
      false) bool alreadyMarked, required HabitTrackingStatus habitStatus}) = _HabitCompletionMarkerUiState;

  factory HabitCompletionMarkerUiState.initial() =>
      HabitCompletionMarkerUiState(
          alreadyMarked: false, habitStatus: HabitTrackingStatus.notStarted);
}

