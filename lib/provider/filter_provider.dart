import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/provider/meals_provider.dart';

enum Filter { gluten, lactoseFree, vegetarian, vegan }

class FiltersProviderNoitier extends StateNotifier<Map<Filter, bool>> {
  FiltersProviderNoitier()
      : super({
          Filter.gluten: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProviderNoitier, Map<Filter, bool>>((ref) {
  return FiltersProviderNoitier();
});

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((element) {
    if (activeFilters[Filter.gluten]! && !element.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !element.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !element.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
