import 'package:flutter/material.dart';
// import 'package:recipe/screens/tabs.dart';
// import 'package:recipe/widgets/main_drawer.dart'
//
// ;

enum Filter { gluten, lactoseFree, vegetarian, vegan }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});
  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FilterScreen> {
  var _isGlutenFreeIsSet = false;
  var _isVegrationIsSet = false;
  var _isLactoseIsSet = false;
  var _isVeganIsSet = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFreeIsSet = widget.currentFilters[Filter.gluten]!;
    _isVegrationIsSet = widget.currentFilters[Filter.vegetarian]!;
    _isLactoseIsSet = widget.currentFilters[Filter.lactoseFree]!;
    _isVeganIsSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        centerTitle: true,
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //   }
      // }),
      body: WillPopScope(
        //passing data through props in navigation
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.gluten: _isGlutenFreeIsSet,
            Filter.lactoseFree: _isLactoseIsSet,
            Filter.vegan: _isVeganIsSet,
            Filter.vegetarian: _isVegrationIsSet
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFreeIsSet,
              onChanged: (isClicked) {
                setState(() {
                  _isGlutenFreeIsSet = isClicked;
                });
              },
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only includes gluten free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isLactoseIsSet,
              onChanged: (isClicked) {
                setState(() {
                  _isLactoseIsSet = isClicked;
                });
              },
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only includes lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isVegrationIsSet,
              onChanged: (isClicked) {
                setState(() {
                  _isVegrationIsSet = isClicked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only includes vegetarian free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _isVeganIsSet,
              onChanged: (isClicked) {
                setState(() {
                  _isVeganIsSet = isClicked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only includes Vegan free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
