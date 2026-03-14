import 'package:objectbox/objectbox.dart';

import 'habit_entity.dart';

@Entity()
class CategoryEntity {
  @Id()
  int id;
  final String name;

  CategoryEntity({this.id =0, required this.name});

  @Backlink("category")
  ToMany<HabitEntity> habits = ToMany<HabitEntity>();
}