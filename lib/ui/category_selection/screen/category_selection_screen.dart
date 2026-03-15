import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_formation/injection/getit_setup.dart';

import '../../../component/bottom_sheet_circular_loader.dart';
import '../../../component/category_list_widget.dart';
import '../../../component/generic_error_widget.dart';
import '../category_selection_bloc.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: getIt<CategorySelectionBloc>()..add(CategorySelectionLoad()),
      builder: (BuildContext buildContext, CategorySelectionState state) {
        switch (state) {
          case CategorySelectionLoading():
            return BottomSheetCircularLoader();
          case CategorySelectionLoaded():
            return CategoryListWidget(categories: state.categories);
          case CategorySelectionError():
            return SafeArea(child: GenericErrorWidget());
        }
      });
  }
}
