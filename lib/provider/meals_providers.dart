import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummeMeals;
});
