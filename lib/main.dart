import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// 1. APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductScreen(),
    );
  }
}

// =====================================================
// 2. PRODUCT MODEL
// =====================================================

class Product {
  final String name;
  final double price;
  final String category;
  final IconData icon;

  const Product({
    required this.name,
    required this.price,
    required this.category,
    required this.icon,
  });
}

// =====================================================
// 3. PRODUCT SCREEN
// =====================================================

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  // Product data
  static const List<Product> products = [
    Product(
      name: 'Laptop',
      price: 65000,
      category: 'Electronics',
      icon: Icons.laptop,
    ),
    Product(
      name: 'Smartphone',
      price: 25000,
      category: 'Electronics',
      icon: Icons.phone_android,
    ),
    Product(
      name: 'Headphones',
      price: 3500,
      category: 'Accessories',
      icon: Icons.headphones,
    ),
    Product(
      name: 'Keyboard',
      price: 1500,
      category: 'Accessories',
      icon: Icons.keyboard,
    ),
    Product(
      name: 'Mouse',
      price: 800,
      category: 'Accessories',
      icon: Icons.mouse,
    ),
    Product(
      name: 'Smart Watch',
      price: 5000,
      category: 'Wearables',
      icon: Icons.watch,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),

        actions: [
          IconButton(
            onPressed: () {
              print('Search clicked');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      // =================================================
      // LISTVIEW.BUILDER
      // =================================================

      body: ListView.builder(
        padding: const EdgeInsets.all(12),

        // Number of items
        itemCount: products.length,

        // Creates each item
        itemBuilder: (context, index) {
          // Get current product
          final Product product = products[index];

          // Return UI for current product
          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}

// =====================================================
// 4. PRODUCT CARD
// =====================================================

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        // LEFT SIDE
        leading: CircleAvatar(
          child: Icon(
            product.icon,
          ),
        ),

        // PRODUCT NAME
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        // CATEGORY
        subtitle: Text(
          product.category,
        ),

        // RIGHT SIDE
        trailing: Text(
          '₹${product.price.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        // WHEN USER TAPS
        onTap: () {
          print('${product.name} selected');
        },
      ),
    );
  }
}