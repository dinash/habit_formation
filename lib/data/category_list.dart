enum CategoryTypes {
  exerciseWorkout(name: "Exercise / Workout"),
  runningWalkingCycling(name: "Running / Walking / Cycling"),
  stretchingYogo(name: "Stretching / Yoga"),
  drinkWater(name: "Drink water regularly"),
  eatFruitsVegetables(name: "Eat fruits & vegetables"),
  sleepOnTime(name: "Sleep on time"),
  meditationMindfulness(name: "Meditation / Mindfulness"),
  readABook(name: "Read a book"),
  listenToMusic(name: "Listen to music");

  final String name;
  const CategoryTypes({required this.name});
}