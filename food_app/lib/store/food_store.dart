import 'package:mobx/mobx.dart';
import 'package:food_shopping_app/models/product.dart';
import 'package:food_shopping_app/services/api_service.dart';

part 'food_store.g.dart';

class FoodStore = _FoodStore with _$FoodStore;

abstract class _FoodStore with Store {
  final ApiService _apiService = ApiService();

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  ObservableList<Product> cart = ObservableList<Product>();

  @action
  Future<void> searchProducts(String query) async {
    final results = await _apiService.searchProducts(query);
    products.clear();
    products.addAll(results);
  }

  @action
  void addToCart(Product product) {
    cart.add(product);
  }

  @action
  void removeFromCart(Product product) {
    cart.remove(product);
  }

  Future<void> checkout() async {
    await _apiService.checkout(cart.toList());
    cart.clear();
  }
}
