import 'package:mobx/mobx.dart';
import 'package:food_shopping_app/models/food_items.dart';
import 'package:food_shopping_app/services/api_service.dart';

part 'food_store.g.dart';

class FoodStore = _FoodStore with _$FoodStore;

abstract class _FoodStore with Store {
  @observable
  ObservableList<FoodItem> foodItems = ObservableList<FoodItem>();

  @observable
  ObservableList<FoodItem> cartItems = ObservableList<FoodItem>();

  final ApiService _apiService = ApiService();

  @action
  Future<void> fetchFoodItems() async {
    final items = await _apiService.getFoodItems();
    foodItems.addAll(items);
  }

  @action
  void addToCart(FoodItem item) {
    cartItems.add(item);
  }

  @action
  Future<void> checkout() async {
    await _apiService.checkout(cartItems);
    cartItems.clear();
  }
}
