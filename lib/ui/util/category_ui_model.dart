import 'package:flutter/material.dart';
import 'package:habit_formation/data/category_list.dart';

class CategoryUiModel {
  CategoryUiModel._();
  static IconData getIcon(CategoryTypes categoryList){
    return switch(categoryList) {
      CategoryTypes.exerciseWorkout => Icons.sports_gymnastics,
      CategoryTypes.runningWalkingCycling => Icons.directions_bike,
      CategoryTypes.stretchingYogo => Icons.self_improvement,
      CategoryTypes.drinkWater => Icons.local_drink,
      CategoryTypes.eatFruitsVegetables => Icons.restaurant,
      CategoryTypes.sleepOnTime => Icons.nightlight,
      CategoryTypes.meditationMindfulness => Icons.psychology,
      CategoryTypes.readABook => Icons.auto_stories,
      CategoryTypes.listenToMusic => Icons.headphones
    };
  }

  static ColorSwatch<int> getColorScheme(CategoryTypes categoryList){
    return switch(categoryList) {
      CategoryTypes.exerciseWorkout => Colors.redAccent,
      CategoryTypes.runningWalkingCycling => Colors.orange,
      CategoryTypes.stretchingYogo => Colors.deepPurple,
      CategoryTypes.drinkWater => Colors.blue,
      CategoryTypes.eatFruitsVegetables => Colors.green,
      CategoryTypes.sleepOnTime => Colors.indigo,
      CategoryTypes.meditationMindfulness => Colors.teal,
      CategoryTypes.readABook => Colors.amber,
      CategoryTypes.listenToMusic => Colors.pinkAccent
    };
  }

  static Color getForegroundColorFor(Color background) {
    // return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    final hsl = HSLColor.fromColor(background);

    // If background is dark → make text lighter
    // If background is light → make text darker
    final adjusted = hsl.lightness > 0.5
        ? hsl.withLightness(0.2)
        : hsl.withLightness(0.85);

    return adjusted.toColor();
  }

  static Color primaryButtonColor(Color cardColor) {
    final hsl = HSLColor.fromColor(cardColor);

    return hsl
        .withLightness((hsl.lightness - 0.15).clamp(0.0, 1.0))
        .withSaturation((hsl.saturation + 0.1).clamp(0.0, 1.0))
        .toColor();
  }
}