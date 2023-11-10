import 'package:flutter/material.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/screens/Categories.dart';
import 'package:recipe/screens/Meals.dart';
import 'package:recipe/screens/fliter.dart';
import 'package:recipe/widgets/main_drawer.dart';

const kInitialMeals = {
  Filter.gluten: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedIndex = 0;
  Map<Filter, bool> _selectedMeals = kInitialMeals;

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
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    currentFilters: _selectedMeals,
                  )));

      setState(() {
        _selectedMeals = result ?? kInitialMeals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((element) {
      if (_selectedMeals[Filter.gluten]! && !element.isGlutenFree) {
        return false;
      }
      if (_selectedMeals[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (_selectedMeals[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (_selectedMeals[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealsFavorites,
      availableMeals: availableMeals,
    );
    var currentTitle = 'Categories';

    if (_selectedIndex == 1) {
      currentTitle = 'Favorites';
      activePage = MealsScreen(
        meals: _favoritesMeal,
        onToggleFavorite: _toggleMealsFavorites,
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
