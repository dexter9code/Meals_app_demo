import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/provider/favourite_provider.dart';
import 'package:recipe/provider/filter_provider.dart';
import 'package:recipe/provider/meals_provider.dart';
import 'package:recipe/screens/Categories.dart';
import 'package:recipe/screens/Meals.dart';
import 'package:recipe/screens/fliter.dart';
import 'package:recipe/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Meal> _favoritesMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  void _toggleMealsFavorites(Meal meal) {
    var isAlreadyExits = _favoritesMeal.contains(meal);

    if (isAlreadyExits) {
      setState(() {
        _favoritesMeal.remove(meal);
        _showInfoMessage('Meal is Remove from Favorite');
      });
    } else {
      setState(() {
        _favoritesMeal.add(meal);
        _showInfoMessage('Meal is added to Favorite');
      });
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var currentTitle = 'Categories';

    if (_selectedIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      currentTitle = 'Favorites';
      activePage = MealsScreen(
        meals: favMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Catagories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
              ),
              label: 'Favorites'),
        ],
      ),
    );
  }
}
