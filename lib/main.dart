import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/purchase_success_screen.dart';

void main() {
  runApp(MyShopApp());
}

class MyShopApp extends StatelessWidget {
  final List<CartItem> cart = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => HomeScreen(cart: cart),
        '/cart': (context) => CartScreen(cart: cart),
        '/details': (context) => ProductDetailScreen(cart: cart),
        '/success': (context) => PurchaseSuccessScreen(),
      },
    );
  }
}
