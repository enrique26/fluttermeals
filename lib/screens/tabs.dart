import 'package:flutter/material.dart';
import 'package:mealsnav/data/dummy_data.dart';
import 'package:mealsnav/models/meal.dart';
import 'package:mealsnav/screens/categories.dart';
import 'package:mealsnav/screens/filters.dart';
import 'package:mealsnav/screens/meals.dart';
import 'package:mealsnav/widgets/main_drawer.dart';

const kInitialFilters = {
  FilterOptions.gluttenFree: false,
  FilterOptions.lactoseFree: false,
  FilterOptions.vegan: false,
  FilterOptions.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _favoriteMeals = [];
  Map<FilterOptions, bool> _filters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  void _toggleMealFavorte(Meal meal) {
    final existingIndex = _favoriteMeals.contains(meal);

    if (existingIndex) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Removed from favorites');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('added to favorites');
      });
    }
  }

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
    final aviablemeals = dummeMeals.where((meal) {
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

    Widget activePage = CategoriesScreen(
        toggleFavorite: _toggleMealFavorte, aviableMeals: aviablemeals);
    var activePagetitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favoriteMeals, toggleFavorite: _toggleMealFavorte);
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
