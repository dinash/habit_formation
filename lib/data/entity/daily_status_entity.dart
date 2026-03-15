import 'package:habit_formation/data/entity/habit_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DailyStatusEntity {
  @Id()
  int id;
  bool doneToday;
  @Property(type: PropertyType.date)
  DateTime markingDate;

  DailyStatusEntity({
    this.id = 0,
    required this.doneToday,
    required this.markingDate});

  final habit = ToOne<HabitEntity>();
}