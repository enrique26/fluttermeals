import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsnav/models/meal.dart';
import 'package:mealsnav/provider/favorites_provider.dart';
import 'package:mealsnav/provider/meals_providers.dart';
import 'package:mealsnav/screens/categories.dart';
import 'package:mealsnav/screens/filters.dart';
import 'package:mealsnav/screens/meals.dart';
import 'package:mealsnav/widgets/main_drawer.dart';

// This is the initial filters
const kInitialFilters = {
  FilterOptions.gluttenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegan: false,
  FilterOptions.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<FilterOptions, bool> _filters = kInitialFilters;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterOptions, bool>>(
          MaterialPageRoute(
              builder: (ctx) => FiltersScreen(currentFilters: _filters)));

      setState(() {
        _filters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealsRead = ref.watch(mealsProvider);
    final aviablemeals = mealsRead.where((meal) {
      if (_filters[FilterOptions.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters[FilterOptions.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_filters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(aviableMeals: aviablemeals);
    var activePagetitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals);
      activePagetitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePagetitle),
      ),
      drawer: MainDrawer(selectPage: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
