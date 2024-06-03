import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String imageType;

  Product({required this.id, required this.title, required this.imageType});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      imageType: json['imageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageType': imageType,
    };
  }
}
