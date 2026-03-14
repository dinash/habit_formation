import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_events.freezed.dart';

@freezed
sealed class HomeScreenEvents with _$HomeScreenEvents {
  factory HomeScreenEvents.loadHabits() = _HomeScreenLoadingEvent;
}