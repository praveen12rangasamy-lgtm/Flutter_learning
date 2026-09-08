import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the existing CartController
    final CartController cartController =
        Get.find<CartController>();

    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title: const Text('My Cart'),

        actions: [
          IconButton(
            onPressed: () {
              cartController.clearCart();

              Get.snackbar(
                'Cart',
                'Cart cleared',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(
              Icons.delete_sweep,
            ),
          ),
        ],
      ),

      // =================================================
      // CART BODY
      // =================================================

      body: Obx(
        () {
          // -------------------------------------------------
          // EMPTY CART
          // -------------------------------------------------

          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          // -------------------------------------------------
          // CART WITH PRODUCTS
          // -------------------------------------------------

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),

                  itemCount:
                      cartController.cartItems.length,

                  itemBuilder: (context, index) {
                    final Product product =
                        cartController.cartItems[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(product.icon),
                        ),

                        title: Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          '₹${product.price.toStringAsFixed(0)}',
                        ),

                        trailing: IconButton(
                          onPressed: () {
                            cartController
                                .removeFromCart(product);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // TOTAL SECTION
              // =================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Obx(
                      () => Text(
                        '₹${cartController.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}