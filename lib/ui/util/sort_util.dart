import 'package:habit_formation/domain/model/sort_type.dart';

final List<Map<SortType, String>> sortTypes = [
  {
    SortType(sortField: SortField.byAddedDate,
        sortOrder: SortOrder.ascending): "Added Date Ascending"
  },
  {
    SortType(sortField: SortField.byAddedDate,
        sortOrder: SortOrder.descending): "Added Date Descending"
  },
  {
    SortType(sortField: SortField.byStartDate,
        sortOrder: SortOrder.ascending): "Start Date Ascending"
  },
  {
    SortType(sortField: SortField.byStartDate,
        sortOrder: SortOrder.descending): "Start Date Descending"
  },
  {
    SortType(sortField: SortField.byCategory,
        sortOrder: SortOrder.ascending): "Category Ascending"
  },
  {
    SortType(sortField: SortField.byCategory,
        sortOrder: SortOrder.descending): "Category Descending"
  },

];