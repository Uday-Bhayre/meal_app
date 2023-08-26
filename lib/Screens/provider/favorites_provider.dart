import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

class favoriteMealsNotifier extends StateNotifier<List<Meal>> {
  favoriteMealsNotifier() : super([]);

  bool toggleMealFavorite(Meal meal) {
    // state = [];
    var isFavorite = state.contains(meal);
    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<favoriteMealsNotifier, List<Meal>>(
  (ref) => favoriteMealsNotifier(),
);

