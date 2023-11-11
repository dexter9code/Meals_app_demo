import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/models/meal.dart';

class FavoriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifer() : super([]);

  bool toggleFavoriteMealStatus(Meal meal) {
    final mealIsAlreadyFavorite = state.contains(meal);

    if (mealIsAlreadyFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifer, List<Meal>>((ref) {
  return FavoriteMealsNotifer();
});
