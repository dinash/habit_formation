import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:habit_formation/data/store/category_manager.dart';
import 'package:habit_formation/domain/habit_formation_repo.dart';
import 'package:habit_formation/domain/mapper/category_entity_to_model.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HabitFormationRepo)
class HabitFormationRepoImpl extends HabitFormationRepo {
  CategoryManager categoryManager;
  CategoryEntityToModel mapper;

  HabitFormationRepoImpl({required this.categoryManager, required this.mapper});

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    List<CategoryEntity> list = await categoryManager.getAllCategory();
    return list.map((entity) => mapper.convert(entity)).toList();
  }
}
