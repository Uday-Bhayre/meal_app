import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/Screens/categories.dart';
import 'package:meal_app/Screens/filters.dart';
import 'package:meal_app/Screens/provider/favorites_provider.dart';
import 'package:meal_app/Screens/provider/filters_provider.dart';
import 'package:meal_app/Screens/meals.dart';
import 'package:meal_app/widget/main_drawer.dart';

class tabScreen extends ConsumerStatefulWidget {
  const tabScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _tabScreenState();
  }
}

class _tabScreenState extends ConsumerState<tabScreen> {
  int _activeScreenIndex = 0;
  String _activeScreenTitle = 'Category';
 

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
    
  }

  void _selectactiveScreen(int index) {
    setState(() {
      _activeScreenIndex = index;
      _activeScreenTitle = 'Favorites';
    });
  }

  @override
  Widget build(BuildContext context) {
   
    final favoritemeals = ref.watch(favoriteMealsProvider);
    final availableMeals = ref.watch(filterMealsProvider);  

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _activeScreenTitle,
        ),
      ),
      drawer: MainDrawer(selectScreen: _selectScreen),
      body: (_activeScreenIndex == 0)
          ? CategoriesScreen(
              availableMeals: availableMeals,
            )
          : MealsScreen(
              meals: favoritemeals,
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectactiveScreen,
        currentIndex: _activeScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lunch_dining),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
