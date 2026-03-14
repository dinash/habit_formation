import 'package:flutter/material.dart';
import 'package:habit_formation/injection/getit_setup.dart';

import '../component/bottom_sheet_circular_loader.dart';
import '../component/category_list_widget.dart';
import '../component/generic_error_widget.dart';
import '../data/entity/category_entity.dart';
import '../data/store/category_manager.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getId<CategoryManager>().getAllCategory(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<CategoryEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BottomSheetCircularLoader();
          }
          else if (snapshot.hasData) {
            List<CategoryEntity> categories = snapshot.data?.toList() ??
                List.empty();
            return CategoryListWidget(categories: categories);
          }
          else {
            return SafeArea(
              child: GenericErrorWidget(),
            );
          }
        });
  }
}
