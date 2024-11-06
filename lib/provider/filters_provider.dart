import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/provider/meals_providers.dart';

enum FilterOptions {
  gluttenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
      : super({
          FilterOptions.gluttenFree: false,
          FilterOptions.lactoseFree: false,
          FilterOptions.vegan: false,
          FilterOptions.vegetarian: false,
        });
  // This method is used to set the filter value
  void setFilter(FilterOptions filter, bool value) {
    state = {...state, filter: value};
  }

  // This method is used to set choosen filters
  void setFilters(Map<FilterOptions, bool> choosefilters) {
    state = choosefilters;
  }
}

// This provider is used to provide the filters
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>(
        (ref) => FiltersNotifier());

// dependent provider to filter meals
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[FilterOptions.gluttenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
