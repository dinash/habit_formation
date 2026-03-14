import '../../../domain/model/category_model.dart';

sealed class CategorySelectionState {}

class CategorySelectionLoading extends CategorySelectionState {}

class CategorySelectionLoaded extends CategorySelectionState {
  final List<CategoryModel> categories;
  CategorySelectionLoaded({required this.categories});
}

class CategorySelectionError extends CategorySelectionState {
  CategorySelectionError({required String message});
}
