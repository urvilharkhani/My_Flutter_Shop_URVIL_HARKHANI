import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/cart_item.dart';

class HomeScreen extends StatefulWidget {
  final List<CartItem> cart;
  HomeScreen({required this.cart});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> items = [
    Item(
      category: 'Laptop',
      price: 999.99,
      brands: ['Dell', 'HP', 'Lenovo'],
      variants: ['8GB RAM', '16GB RAM', '32GB RAM'],
      colors: ['Silver', 'Black', 'Gray'],
    ),
    Item(
      category: 'Smartphone',
      price: 799.49,
      brands: ['Samsung', 'Google', 'OnePlus'],
      variants: ['128GB', '256GB'],
      colors: ['Blue', 'Black', 'White'],
    ),
    Item(
      category: 'Headphones',
      price: 149.99,
      brands: ['Sony', 'Bose', 'JBL'],
      variants: ['Wireless', 'Wired'],
      colors: ['Black', 'White'],
    ),
    Item(
      category: 'Mouse',
      price: 49.99,
      brands: ['Logitech', 'Razer'],
      variants: ['Wired', 'Wireless'],
      colors: ['Black', 'Red'],
    ),
  ];

  int get totalCartCount =>
      widget.cart.fold(0, (sum, item) => sum + item.quantity);

  String getImagePath(String category) =>
      'lib/assets/${category.toLowerCase()}.png';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        backgroundColor: Color(0xFFE8F0FE),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Product Categories'),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart').then((_) {
                      setState(() {});
                    });
                  },
                ),
                if (totalCartCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$totalCartCount',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Image.asset(
                  getImagePath(item.category),
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.category, size: 40),
                ),
                title: Text(item.category),
                subtitle: Text('Explore ${item.brands.length} brands'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: item,
                  ).then((_) {
                    setState(() {});
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
