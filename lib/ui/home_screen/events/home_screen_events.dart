import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/sort_type.dart';

part 'home_screen_events.freezed.dart';

@freezed
sealed class HomeScreenEvents with _$HomeScreenEvents {
  factory HomeScreenEvents.loadHabits(SortType sortType) = _HomeScreenLoadingEvent;
}