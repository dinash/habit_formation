import 'package:objectbox/objectbox.dart';

@Entity()
class CategoryEntity {
  @Id()
  int id;
  final String name;

  CategoryEntity({this.id =0, required this.name});
}