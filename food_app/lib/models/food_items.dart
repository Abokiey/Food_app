import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_items.freezed.dart';
part 'food_items.g.dart';

@freezed
class FoodItem with _$FoodItem {
  factory FoodItem({
    required String name,
    required String description,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);
}
