import 'package:flutter/material.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/category.dart';
import 'package:recipe/screens/Meals.dart';
import 'package:recipe/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _onSelectCategory(BuildContext context, Category category) {
    final filterData = dummyMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(meals: filterData, title: category.title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Category'),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final item in availableCategories)
            CategoryGridItem(
              category: item,
              onSelectCategory: () {
                _onSelectCategory(context, item);
              },
            )
        ],
      ),
    );
  }
}
