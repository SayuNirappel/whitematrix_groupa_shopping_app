import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserOrders({
    required String userId,
    String? token,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse('https://myntacloneappbackend-1.onrender.com/orders/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final fetchedOrders = data['orders'] as List<dynamic>;
        _orders = fetchedOrders.cast<Map<String, dynamic>>();
      } else {
        _errorMessage = "Failed to fetch orders: ${response.body}";
      }
    } catch (e) {
      _errorMessage = "Error fetching orders: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}