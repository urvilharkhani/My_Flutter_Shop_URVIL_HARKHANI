import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/cart_item.dart';

class ProductDetailScreen extends StatefulWidget {
  final List<CartItem> cart;
  ProductDetailScreen({required this.cart});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final Map<String, String?> selectedVariants = {};
  final Map<String, String?> selectedColors = {};
  final Map<String, int> quantities = {};

  @override
  Widget build(BuildContext context) {
    final Item item = ModalRoute.of(context)?.settings.arguments as Item;

    return Scaffold(

      backgroundColor: Color(0xFFE8F0FE),
      appBar: AppBar(
        title: Text('${item.category} Brands'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              for (var brand in item.brands) {
                final variant = selectedVariants[brand];
                final color = selectedColors[brand];
                final quantity = quantities[brand] ?? 1;

                if (variant != null && color != null) {
                  _addToCart(item, brand, variant, color, quantity);
                }
              }

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: item.brands.map((brand) {
          return _buildBrandCard(item, brand);
        }).toList(),
      ),
    );
  }

  Widget _buildBrandCard(Item item, String brand) {
    return StatefulBuilder(
      builder: (context, setCardState) {
        final variant = selectedVariants[brand];
        final color = selectedColors[brand];
        final quantity = quantities[brand] ?? 1;

        return Card(
          margin: EdgeInsets.all(12),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Logo
                Image.asset(
                  'lib/assets/${brand.toLowerCase()}.png',
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 60),
                ),
                SizedBox(height: 10),

                Text(
                  brand,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),

                // Variants
                Wrap(
                  spacing: 8,
                  children: item.variants.map((v) {
                    final selected = variant == v;
                    return ChoiceChip(
                      label: Text(v),
                      selected: selected,
                      onSelected: (_) {
                        setCardState(() {
                          selectedVariants[brand] = v;
                        });
                      },
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                // Colors
                Wrap(
                  spacing: 8,
                  children: item.colors.map((c) {
                    final selected = color == c;
                    return ChoiceChip(
                      label: Text(c),
                      selected: selected,
                      onSelected: (_) {
                        setCardState(() {
                          selectedColors[brand] = c;
                        });
                      },
                      selectedColor: Colors.teal,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),

                // Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () => setCardState(() {
                        quantities[brand] = quantity - 1;
                      })
                          : null,
                      icon: Icon(Icons.remove),
                    ),
                    Text(quantity.toString(),
                        style: TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () => setCardState(() {
                        quantities[brand] = quantity + 1;
                      }),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Add + Clear Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: (variant != null && color != null)
                          ? () {
                        _addToCart(
                            item, brand, variant, color, quantity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Added $quantity x $brand to cart!')),
                        );
                        setCardState(() {
                          selectedVariants[brand] = null;
                          selectedColors[brand] = null;
                          quantities[brand] = 1;
                        });
                      }
                          : null,
                      icon: Icon(Icons.shopping_cart_checkout),
                      label: Text('Add'),
                    ),
                    TextButton(
                      onPressed: () {
                        setCardState(() {
                          selectedVariants[brand] = null;
                          selectedColors[brand] = null;
                          quantities[brand] = 1;
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: Text('Clear'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToCart(Item item, String brand, String variant, String color,
      int quantity) {
    final existing = widget.cart.firstWhere(
          (c) =>
      c.item.category == item.category &&
          c.brand == brand &&
          c.variant == variant &&
          c.color == color,
      orElse: () => CartItem(
          item: item, brand: '', variant: '', color: '', quantity: 0),
    );

    setState(() {
      if (existing.quantity == 0) {
        widget.cart.add(CartItem(
          item: item,
          brand: brand,
          variant: variant,
          color: color,
          quantity: quantity,
        ));
      } else {
        existing.quantity += quantity;
      }
    });
  }
}
