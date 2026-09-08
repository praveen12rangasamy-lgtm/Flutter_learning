import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'cart_screen.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final List<Product> products = const [
    Product(
      name: 'Laptop',
      price: 65000,
      icon: Icons.laptop,
    ),
    Product(
      name: 'Smartphone',
      price: 25000,
      icon: Icons.phone_android,
    ),
    Product(
      name: 'Headphones',
      price: 3500,
      icon: Icons.headphones,
    ),
    Product(
      name: 'Keyboard',
      price: 1500,
      icon: Icons.keyboard,
    ),
    Product(
      name: 'Mouse',
      price: 800,
      icon: Icons.mouse,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the controller that was registered in main.dart
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),

        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.to(
                    () => const CartScreen(),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),

              Positioned(
                right: 5,
                top: 5,
                child: Obx(
                  () => CircleAvatar(
                    radius: 9,
                    child: Text(
                      '${cartController.cartItems.length}',
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,

        itemBuilder: (context, index) {
          final Product product = products[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),

            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: CircleAvatar(
                child: Icon(product.icon),
              ),

              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              subtitle: Text(
                '₹${product.price.toStringAsFixed(0)}',
              ),

              trailing: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);

                  Get.snackbar(
                    'Added',
                    '${product.name} added to cart',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text('Add'),
              ),
            ),
          );
        },
      ),
    );
  }
}