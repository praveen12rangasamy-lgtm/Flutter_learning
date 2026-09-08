import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // Register CartController
  Get.put(CartController());

  runApp(const MyApp());
}

// =====================================================
// PRODUCT MODEL
// =====================================================

class Product {
  final String name;
  final double price;
  final IconData icon;

  const Product({
    required this.name,
    required this.price,
    required this.icon,
  });
}

// =====================================================
// CART CONTROLLER
// =====================================================

class CartController extends GetxController {
  // Observable list
  final RxList<Product> cartItems = <Product>[].obs;

  // Add product
  void addToCart(Product product) {
    cartItems.add(product);
  }

  // Remove product
  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
  }

  // Calculate total price
  double get totalPrice {
    double total = 0;

    for (final product in cartItems) {
      total += product.price;
    }

    return total;
  }
}

// =====================================================
// APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Shopping Cart',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // IMPORTANT:
      // ProductScreen constructor is not const
      home: ProductScreen(),
    );
  }
}

// =====================================================
// PRODUCT SCREEN
// =====================================================

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  // Product list
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
    Product(
      name: 'Smart Watch',
      price: 5000,
      icon: Icons.watch,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Get existing controller
    final CartController cartController =
        Get.find<CartController>();

    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title: const Text('Products'),

        actions: [
          Stack(
            children: [
              // Cart button
              IconButton(
                onPressed: () {
                  Get.to(
                    () => const CartScreen(),
                  );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),

              // Cart count
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

      // =================================================
      // PRODUCT LIST
      // =================================================

      body: ListView.builder(
        padding: const EdgeInsets.all(12),

        itemCount: products.length,

        itemBuilder: (context, index) {
          final Product product = products[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 12,
            ),

            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              // Product icon
              leading: CircleAvatar(
                child: Icon(product.icon),
              ),

              // Product name
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),

              // Product price
              subtitle: Text(
                '₹${product.price.toStringAsFixed(0)}',
              ),

              // Add button
              trailing: ElevatedButton(
                onPressed: () {
                  cartController.addToCart(product);

                  Get.snackbar(
                    'Added to Cart',
                    '${product.name} added to cart',
                    snackPosition:
                        SnackPosition.BOTTOM,
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

// =====================================================
// CART SCREEN
// =====================================================

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the same controller
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
                snackPosition:
                    SnackPosition.BOTTOM,
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
          // Empty cart
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
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          // Cart contains products
          return Column(
            children: [
              // =================================================
              // CART ITEMS
              // =================================================

              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.all(12),

                  itemCount:
                      cartController.cartItems.length,

                  itemBuilder: (context, index) {
                    final Product product =
                        cartController
                            .cartItems[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            product.icon,
                          ),
                        ),

                        title: Text(
                          product.name,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          '₹${product.price.toStringAsFixed(0)}',
                        ),

                        trailing: IconButton(
                          onPressed: () {
                            cartController
                                .removeFromCart(
                              product,
                            );
                          },
                          icon: const Icon(
                            Icons
                                .remove_circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // =================================================
              // TOTAL
              // =================================================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color:
                          Colors.grey.shade300,
                    ),
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    Obx(
                      () => Text(
                        '₹${cartController.totalPrice.toStringAsFixed(0)}',
                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
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