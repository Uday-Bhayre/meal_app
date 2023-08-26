import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/Screens/provider/favorites_provider.dart';
import 'package:meal_app/models/meal.dart';

class mealDetails extends ConsumerWidget {
  const mealDetails({
    super.key,
    required this.meal,
  });
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final favoriteMeals = widgetRef.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              bool wasAdded = widgetRef
                  .watch(
                    favoriteMealsProvider.notifier,
                  )
                  .toggleMealFavorite(
                    meal,
                  );
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Marked as a favorite'
                      : 'Meal is no longer a favorite'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(
                milliseconds: 300,
              ),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
              key: ValueKey(isFavorite),
                isFavorite ? Icons.star : Icons.star_border_outlined,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: const TextStyle(color: Colors.white),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
