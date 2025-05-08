class Item {
  final String category; // e.g. 'Laptop'
  final double price;
  final List<String> brands;
  final List<String> variants;
  final List<String> colors;

  Item({
    required this.category,
    required this.price,
    required this.brands,
    required this.variants,
    required this.colors,
  });
}
