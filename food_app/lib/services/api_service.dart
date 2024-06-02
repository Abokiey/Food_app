import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_shopping_app/models/food_items.dart';

class ApiService {
  final String apiKey = 'c0f201ef6dce44ffb2813bf7e9516496';

  Future<List<FoodItem>> getFoodItems() async {
    final response = await http.get(Uri.parse('https://api.spoonacular.com/food/menuItems?apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['menuItems'] as List).map((item) => FoodItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load food items');
    }
  }

  Future<void> checkout(List<FoodItem> cartItems) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'items': cartItems.map((item) => item.toJson()).toList()}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to checkout');
    }
  }
}
