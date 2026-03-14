import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/habit_model.dart';
part 'home_screen_states.freezed.dart';

@freezed
sealed class HomeScreenStates with _$HomeScreenStates {
  factory HomeScreenStates.loading() = _HomeScreenLoadingState;
  factory HomeScreenStates.loaded(Stream<List<HabitModel>> habitStream) = _HomeScreenLoadedState;
  factory HomeScreenStates.error(String errorMessage) = _HomeScreenErrorState;
}