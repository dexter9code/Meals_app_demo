import 'package:flutter/material.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/screens/Categories.dart';
import 'package:recipe/screens/Meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealsFavorites,
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
