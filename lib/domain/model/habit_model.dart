import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:intl/intl.dart';

part 'habit_model.freezed.dart';

@freezed
abstract class HabitModel with _$HabitModel{
  const HabitModel._();
  factory HabitModel({required CategoryModel category, required DateTime startDate, required DateTime endDate}) = _HabitModel;

  String get formattedStartDate => DateFormat(DateFormat.YEAR_MONTH_DAY).format(startDate);
  String get formattedEndDate => DateFormat(DateFormat.YEAR_MONTH_DAY).format(endDate);
}