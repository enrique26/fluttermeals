import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/models/meal.dart';

// This is a provider that returns a list of meals
class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final mealisFavorite = state.contains(meal);
    // if meal is already in the list, remove it
    if (mealisFavorite) {
      state = state.where((statemeal) => statemeal.id != meal.id).toList();
      return false;
    } else {
      // if meal is not in the list, add it
      state = [...state, meal];
      return true;
    }
  }
}

// This is a provider that returns a list of meals that are favorites
final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
  // return an instance of the FavoritesMealsNotifier
  return FavoritesMealsNotifier();
});
