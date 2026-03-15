import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/category_model.dart';
part 'add_habit_events.freezed.dart';

@freezed
sealed class AddHabitEvents with _$AddHabitEvents{
  factory AddHabitEvents.initial() = _Initial;
  factory AddHabitEvents.onCategorySelected(CategoryModel selectedCategory) = _OnCategorySelected;
  factory AddHabitEvents.onStartDateSelected(DateTime selectedStartDate) = _OnStartDateSelected;
  factory AddHabitEvents.saveHabit() = _SaveHabit;
}