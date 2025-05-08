import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  CartScreen({required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get total => widget.cart.fold(
      0, (sum, item) => sum + (item.item.price * item.quantity));

  void removeItem(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
  }

  void clearCart() {
    setState(() {
      widget.cart.clear();
    });
  }

  void payAndNavigate() {
    setState(() {
      widget.cart.clear();
    });
    Navigator.pushNamed(context, '/success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F0FE),
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text('Your cart is empty 😢'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return Card(
                  margin:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Info column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.item.category,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(height: 4),
                              Text('Brand: ${item.brand}'),
                              Text('Variant: ${item.variant}'),
                              Text('Color: ${item.color}'),
                              Text('Qty: ${item.quantity}'),
                            ],
                          ),
                        ),
                        // Price and Remove
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${(item.item.price * item.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () => removeItem(index),
                              icon: Icon(Icons.close, color: Colors.red),
                              tooltip: 'Remove item',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Clear Cart Button
                ElevatedButton(
                  onPressed: widget.cart.isEmpty ? null : clearCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Clear Cart'),
                ),
                SizedBox(height: 12),

                // Pay Now Button
                ElevatedButton(
                  onPressed: widget.cart.isEmpty ? null : payAndNavigate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Pay Now 💳'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
