import 'package:freezed_annotation/freezed_annotation.dart';
part 'daily_status_model.freezed.dart';

@freezed
abstract class DailyStatusModel with _$DailyStatusModel{
  factory DailyStatusModel({required bool doneToday, required DateTime markingDate}) = _DailyStatusModel;
}