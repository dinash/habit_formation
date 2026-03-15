import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
part 'habit_completion_marker_events.freezed.dart';

@freezed
sealed class HabitCompletionMarkerEvents with _$HabitCompletionMarkerEvents {
  factory HabitCompletionMarkerEvents.loadDailyStatus(HabitModel habitModel) = _HabitCompletionMarkerEventLoader;
  factory HabitCompletionMarkerEvents.markDoneForToday(HabitModel habitModel) = _HabitCompletionMarkerEventMarkDoneForToday;
}