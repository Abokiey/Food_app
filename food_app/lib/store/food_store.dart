import 'package:mobx/mobx.dart';
import 'package:food_shopping_app/models/product.dart';
import 'package:food_shopping_app/services/api_service.dart';

part 'food_store.g.dart';

class FoodStore = _FoodStore with _$FoodStore;

abstract class _FoodStore with Store {
  @observable
  ObservableList<Product> products = ObservableList<Product>();

  final ApiService _apiService = ApiService();

  @action
  Future<void> searchProducts(String query) async {
    final items = await _apiService.searchProducts(query);
    products.clear();
    products.addAll(items);
  }
}
