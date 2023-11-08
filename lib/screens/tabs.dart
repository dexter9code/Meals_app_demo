import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();
    var currentTitle = 'Categories';

    if (_selectedIndex == 1) {
      currentTitle = 'Favorites';
      activePage = const MealsScreen(meals: [], title: 'some title');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Catagories'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Favorites'),
        ],
      ),
    );
  }
}
