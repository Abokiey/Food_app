import 'package:flutter/material.dart';
import 'package:food_shopping_app/store/food_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductSearchPage(),
    );
  }
}

class ProductSearchPage extends StatefulWidget {
  @override
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FoodStore _foodStore = FoodStore();
  String? _error;

  Future<void> _searchProducts() async {
    final query = _controller.text;
    if (query.isEmpty) {
      setState(() {
        _error = 'Please enter a search query';
      });
      return;
    }

    try {
      await _foodStore.searchProducts(query);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for a product',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchProducts,
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
                builder: (_) => _foodStore.products.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: _foodStore.products.length,
                          itemBuilder: (context, index) {
                            final product = _foodStore.products[index];
                            return ListTile(
                              leading: Image.network(product.image),
                              title: Text(product.title),
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
