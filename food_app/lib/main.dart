import 'package:flutter/material.dart';
import 'package:food_shopping_app/store/food_store.dart';
import 'package:food_shopping_app/views/food_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FoodStore store = FoodStore();

  @override
  Widget build(BuildContext context) {
    return Provider<FoodStore>(
      create: (_) => store..fetchFoodItems(),
      child: MaterialApp(
        home: FoodListScreen(),
      ),
    );
  }
}
