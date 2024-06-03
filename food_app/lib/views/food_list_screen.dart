// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:food_shopping_app/store/food_store.dart';
// import 'package:provider/provider.dart';

// class FoodListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final store = Provider.of<FoodStore>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Food Items')),
//       body: Observer(
//         builder: (_) {
//           if (store.foodItems.isEmpty) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return ListView.builder(
//             itemCount: store.foodItems.length,
//             itemBuilder: (context, index) {
//               final item = store.foodItems[index];
//               return ListTile(
//                 title: Text(item.name),
//                 subtitle: Text(item.description),
//                 onTap: () {
//                   store.addToCart(item);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
