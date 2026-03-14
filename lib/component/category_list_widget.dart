import 'package:flutter/material.dart';
import 'package:habit_formation/domain/model/category_model.dart';

import 'bold_text_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: ListTile.divideTiles(
          context: context,
          tiles: categories.map(
            (category) => ListTile(
              title: BoldTextWidget(text: category.name),
              onTap: () {
                Navigator.pop(context, category);
              },
            ),
          ),
        ).toList(),
      ),
    );
  }
}
