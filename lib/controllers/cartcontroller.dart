

import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> product) {
    final existingIndex = _items.indexWhere((item) => item['id'] == product['id']);
    if (existingIndex != -1) {
      _items[existingIndex]['quantity'] += 1;
    } else {
      _items.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }



  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
