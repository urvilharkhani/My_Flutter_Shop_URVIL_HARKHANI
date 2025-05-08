import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/cart_item.dart';

class BrandCard extends StatefulWidget {
  final Item item;
  final String brand;
  final Function(CartItem) onAddToCart;

  BrandCard({
    required this.item,
    required this.brand,
    required this.onAddToCart,
  });

  @override
  _BrandCardState createState() => _BrandCardState();
}

class _BrandCardState extends State<BrandCard> {
  String? selectedVariant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.brand,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Variant buttons
            Wrap(
              spacing: 8,
              children: widget.item.variants.map((variant) {
                final isSelected = selectedVariant == variant;
                return ChoiceChip(
                  label: Text(variant),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedVariant = variant;
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Add to Cart Button
            ElevatedButton(
              onPressed: selectedVariant == null
                  ? null
                  : () {
                widget.onAddToCart(CartItem(
                  item: widget.item,
                  brand: widget.brand,
                  variant: selectedVariant!,
                  quantity: 1,
                ));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to cart!')),
                );

                setState(() {
                  selectedVariant = null;
                });
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
