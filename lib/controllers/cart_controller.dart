import 'package:get/get.dart';

import '../models/product.dart';

class CartController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice {
    double total = 0;

    for (final product in cartItems) {
      total += product.price;
    }

    return total;
  }
}