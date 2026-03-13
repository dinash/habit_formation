import 'package:flutter/material.dart';

import '../component/bold_text_widget.dart';

class CategorySelectionScreen extends StatelessWidget {
  CategorySelectionScreen({super.key});

  final List<String> categories = [
    "Running",
    "Walking",
    "Yoga",
    "Reading",
    "Swimming",
    "Cycling",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: ListTile.divideTiles(
          context: context,
          tiles: categories.map(
            (category) => ListTile(
              title: BoldTextWidget(text: category),
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
