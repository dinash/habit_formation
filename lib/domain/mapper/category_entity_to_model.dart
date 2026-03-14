import 'package:habit_formation/data/entity/category_entity.dart';
import 'package:habit_formation/domain/model/category_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryEntityToModel {
  CategoryModel convert(CategoryEntity categoryEntity){
    return CategoryModel(id: categoryEntity.id, name: categoryEntity.name);
  }
}