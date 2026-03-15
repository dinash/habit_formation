
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/daily_status_model.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
import 'package:habit_formation/ui/habit_completion_marker/states/habit_completion_marker_ui_state.dart';
part 'habit_completion_marker_states.freezed.dart';

@freezed
sealed class HabitCompletionMarkerStates with _$HabitCompletionMarkerStates {
  factory HabitCompletionMarkerStates.loading(HabitCompletionMarkerUiState uiState) = _HabitCompletionLoading;
  factory HabitCompletionMarkerStates.loaded(HabitCompletionMarkerUiState uiState, HabitModel habitModel, List<DailyStatusModel> dailyStatus) = _HabitCompletionLoaded;
  factory HabitCompletionMarkerStates.error(HabitCompletionMarkerUiState uiState, String errorMessage) = _HabitCompletionError;
}