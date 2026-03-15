import 'package:freezed_annotation/freezed_annotation.dart';

part 'sort_type.freezed.dart';

@freezed
abstract class SortType with _$SortType {
   factory SortType({
    required SortField sortField,
    required SortOrder sortOrder,
  }) = _SortType;

  factory SortType.defaultSort() => SortType(
    sortField: SortField.byCategory,
    sortOrder: SortOrder.ascending,
  );
}

enum SortField { byAddedDate, byStartDate, byEndDate, byCategory }

enum SortOrder { ascending, descending }
