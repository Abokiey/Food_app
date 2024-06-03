import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:food_shopping_app/store/food_store.dart';
import 'package:provider/provider.dart';
import 'success_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foodStore = Provider.of<FoodStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Observer(
        builder: (_) => foodStore.cart.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: foodStore.cart.length,
                      itemBuilder: (context, index) {
                        final product = foodStore.cart[index];
                        return ListTile(
                          leading: Image.network(
                              'https://img.spoonacular.com/products/${product.id}-312x231.${product.imageType}'),
                          title: Text(product.title),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_shopping_cart),
                            onPressed: () => foodStore.removeFromCart(product),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await foodStore.checkout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SuccessPage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Checkout failed: $e')),
                        );
                      }
                    },
                    child: Text('Checkout'),
                  ),
                ],
              )
            : Center(child: Text('No items in the cart')),
      ),
    );
  }
}
