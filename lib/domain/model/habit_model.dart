import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/category_model.dart';
part 'habit_model.freezed.dart';

@freezed
abstract class HabitModel with _$HabitModel{
  factory HabitModel({required CategoryModel category, required DateTime startDate, required DateTime endDate}) = _HabitModel;
}