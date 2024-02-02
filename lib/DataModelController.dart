import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityProvider with ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;

  // Variable to track cart item count
  int _cartItemCount = 0;
  int get cartItemCount => _cartItemCount;

  void increment() {
    _quantity = checkQuantity(_quantity + 1);
    notifyListeners();
  }

  void decrement() {
    _quantity = checkQuantity(_quantity - 1);
    notifyListeners();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 0;
    } else if (quantity > 20) {
      Get.snackbar(
        "Item count",
        "You can't add more!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void updateCartItemCount() {
    _cartItemCount = _quantity;
    notifyListeners();
  }
}
