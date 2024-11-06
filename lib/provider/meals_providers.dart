import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/data/dummy_data.dart';

// This is a provider that returns a list of meals
final mealsProvider = Provider((ref) {
  return dummeMeals;
});
