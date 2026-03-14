import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class HabitEntity {
  @Id()
  int id;
  @Property(type: PropertyType.date)
  DateTime startDate;
  @Property(type: PropertyType.date)
  DateTime endDate;

  HabitEntity({this.id = 0, required this.startDate, required this.endDate});

  final category = ToOne<CategoryEntity>();
}
