import 'package:habit_formation/domain/model/category_model.dart';

abstract class CategoryRepo {
  Future<List<CategoryModel>> getAllCategory();
}