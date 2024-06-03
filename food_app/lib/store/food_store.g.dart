// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FoodStore on _FoodStore, Store {
  late final _$productsAtom =
      Atom(name: '_FoodStore.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$cartAtom = Atom(name: '_FoodStore.cart', context: context);

  @override
  ObservableList<Product> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(ObservableList<Product> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$searchProductsAsyncAction =
      AsyncAction('_FoodStore.searchProducts', context: context);

  @override
  Future<void> searchProducts(String query) {
    return _$searchProductsAsyncAction.run(() => super.searchProducts(query));
  }

  late final _$_FoodStoreActionController =
      ActionController(name: '_FoodStore', context: context);

  @override
  void addToCart(Product product) {
    final _$actionInfo =
        _$_FoodStoreActionController.startAction(name: '_FoodStore.addToCart');
    try {
      return super.addToCart(product);
    } finally {
      _$_FoodStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromCart(Product product) {
    final _$actionInfo = _$_FoodStoreActionController.startAction(
        name: '_FoodStore.removeFromCart');
    try {
      return super.removeFromCart(product);
    } finally {
      _$_FoodStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
cart: ${cart}
    ''';
  }
}
