import 'package:flutter/material.dart';
import 'package:mealsnav/data/dummy_data.dart';
import 'package:mealsnav/models/category.dart';
import 'package:mealsnav/models/meal.dart';
import 'package:mealsnav/screens/meals.dart';
import 'package:mealsnav/widgets/category_grid.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.aviableMeals});
  final List<Meal> aviableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = aviableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                MealsScreen(title: category.title, meals: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: aviableCategories.map((category) {
        return CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            });
      }).toList(),
    );
  }
}
