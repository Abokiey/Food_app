import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_shopping_app/models/product.dart';

class ApiService {
  final String apiKey = '';

  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('https://api.spoonacular.com/food/products/search?query=$query&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List).map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}






// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:food_shopping_app/models/food_items.dart';

// class ApiService {
//   final String apiKey = 'c0f201ef6dce44ffb2813bf7e9516496';

//   Future<List<FoodItem>> getFoodItems() async {
//     final url = Uri.parse('https://api.spoonacular.com/food/menuItems/424571?apiKey=$apiKey');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return (data['menuItems'] as List).map((item) => FoodItem.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load food items');
//     }
//   }

//   Future<void> checkout(List<FoodItem> cartItems) async {
//     final response = await http.post(
//       Uri.parse('https://jsonplaceholder.typicode.com/posts'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'items': cartItems.map((item) => item.toJson()).toList()}),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to checkout');
//     }
//   }
// }
