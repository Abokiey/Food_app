import 'package:flutter/material.dart';
import 'package:food_shopping_app/store/food_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:food_shopping_app/models/product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:food_shopping_app/pages/cart_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FoodStore>(
      create: (_) => FoodStore(),
      child: MaterialApp(
        title: 'Product Search',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductSearchPage(),
      ),
    );
  }
}

class ProductSearchPage extends StatefulWidget {
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  Future<void> _searchProducts(FoodStore foodStore) async {
    final query = _controller.text;
    if (query.isEmpty) {
      setState(() {
        _error = 'Please enter a search query';
      });
      return;
    }

    try {
      await foodStore.searchProducts(query);
      setState(() {
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodStore = Provider.of<FoodStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Order for Products'),
        actions: [
          Observer(
            builder: (_) {
              return badges.Badge(
                badgeContent: Text(
                  foodStore.cart.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for a product e.g pizza',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _searchProducts(foodStore),
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            if (_error != null)
              Text(
                _error!,
                style: TextStyle(color: Colors.red),
              )
            else
              Observer(
                builder: (_) => foodStore.products.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: foodStore.products.length,
                          itemBuilder: (context, index) {
                            final product = foodStore.products[index];
                            return ListTile(
                              leading: Image.network(
                                  'https://img.spoonacular.com/products/${product.id}-312x231.${product.imageType}'),
                              title: Text(product.title),
                              trailing: IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () => foodStore.addToCart(product),
                              ),
                            );
                          },
                        ),
                      )
                    : Text('No products found'),
              ),
          ],
        ),
      ),
    );
  }
}
