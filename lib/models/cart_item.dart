import 'item.dart';

class CartItem {
  final Item item;
  final String brand;
  final String variant;
  final String color;
  int quantity;

  CartItem({
    required this.item,
    required this.brand,
    required this.variant,
    required this.color,
    this.quantity = 1,
  });
}
