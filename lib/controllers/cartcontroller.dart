import 'dart:async';
import 'dart:convert';

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final String baseUrl = 'https://myntacloneappbackend-1.onrender.com';
  List<dynamic> _cartItems = [];
  String? couponMessage;
bool productiloading=false;
 
  



  List<dynamic> get cartItems => _cartItems;

  // Fetch cart items by userId
 Future<void> fetchCartItems(String userId) async {
   productiloading=true;
    notifyListeners();
  final url = Uri.parse('$baseUrl/cart/$userId');
  try {
    print("Fetching cart items for user: $userId at URL: $url");
    final response = await http.get(url);
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}"); // Log body regardless of status

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _cartItems = data["items"] ?? [];
      print("Successfully parsed cart items: $_cartItems");
      notifyListeners();
    } else {
      print('Error fetching cart - Status: ${response.statusCode}, Body: ${response.body}');
    }
  } catch (e, stackTrace) {
    print("Fetch cart error: $e, StackTrace: $stackTrace");
    print("URL attempted: $url");
  }
  productiloading=false;
    
  notifyListeners();
}




  // Update cart item by userId, productId, variantSKU, quantity
  Future<void> updateCartItem({
    required String userId,
    required String productId,
    required String variantSKU,
     int? quantity,
      String?size,
  }) async {
    final url = Uri.parse('$baseUrl/cart/update-cart');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "productId": productId,
          "variantSKU": variantSKU,
          "quantity": quantity,
          "size":size,
        }),
        
      );
      if (response.statusCode == 200) {
        await fetchCartItems(userId);
      } else {
        print('Update error: ${response.body}');
      }
    } catch (e) {
      print("Update cart error: $e");
    }
    notifyListeners();
  }

  // Remove one item from cart
  Future<void> removeCartItem({
    required String userId,
    required String productId,
    required String variantSKU,
  }) async {
    final url = Uri.parse('$baseUrl/cart/remove-cart-item');
    try {
      final request = http.Request("DELETE", url)
      
        ..headers['Content-Type'] = 'application/json'
        ..body = jsonEncode({
          "userId": userId,
          "productId": productId,
          "variantSKU": variantSKU,
        });
        log("🗑️ Attempting to delete cart item:");
log("UserId: $userId");
log("ProductId: $productId");
log("VariantSKU: $variantSKU");

      final streamed = await request.send();
      final result = await http.Response.fromStream(streamed);
      if (result.statusCode == 200) {
        await fetchCartItems(userId);
        log("✅ Item deleted successfully");

      } else {
        print("Remove item error: ${result.body}");
      }
    } catch (e) {
      print("Remove cart item error: $e");
    }
    notifyListeners();
  }

  // Remove multiple items from cart
 Future<void> removeMultipleCartItems({
  required String userId,
  required List<Map<String, String>> items,
}) async {
  final url = Uri.parse('$baseUrl/cart/remove-multiple-cart-item');
  try {
    final request = http.Request("DELETE", url)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        "userId": userId,
        "items": items,
      });

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      await fetchCartItems(userId); // refresh cart after delete
       log("✅ Item deleted successfully");
    } else {
      print("Remove multiple error: ${response.body}");
    }
  } catch (e) {
    print("Remove multiple items error: $e");
  }
  notifyListeners();
}

  // Apply a coupon to the cart
   Future<bool> applyCoupon({
    required String userId,
    required String couponCode,
    required double cartTotal, // Add cartTotal parameter
  }) async {
    final url = Uri.parse('$baseUrl/cart/apply-coupon');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "couponCode": couponCode,
          "cartTotal": cartTotal,
        }),
      );
      print("Apply coupon status: ${response.statusCode}");
      print("Apply coupon request: ${jsonEncode({
        "userId": userId,
        "couponCode": couponCode,
        "cartTotal": cartTotal,
      })}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        couponMessage = data["message"] ?? 'Coupon applied successfully';
        notifyListeners();
        await fetchCartItems(userId); // Refresh cart totals
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        couponMessage = errorData["error"] ?? 'Failed to apply coupon';
        print('Coupon error: ${response.body}');
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Error in applyCoupon: $e");
      couponMessage = 'Error applying coupon';
      notifyListeners();
      return false;
    }
  }

  // Place an order
 
/// Function to place an order
Future<bool> placeOrder({
  required String userId,
  required List<Map<String, dynamic>> items,
  required Map<String, dynamic> shippingAddress,
  required double cartTotal,
  required String paymentMethod,
  required String token,
}) async {
  final url = Uri.parse('https://myntacloneappbackend-1.onrender.com/order/place-an-order/$userId');

  final body = {
    "userId": userId,
    "items": items,
    "shippingAddress": shippingAddress,
    "cartTotal": cartTotal,
    "paymentMethod": paymentMethod,
  };

  // Log request details
  print("📤 Sending placeOrder request to: $url");
  print("📋 Request body: ${jsonEncode(body)}");
  print("🔑 Authorization: Bearer $token");

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    // Log response details
    print("📥 Response status: ${response.statusCode}");
    print("📋 Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("✅ Order placed successfully: ${response.body}");
      _cartItems = []; // Clear cart on success
      notifyListeners();
      return true;
    } else {
      // Parse error message from response
      try {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['error'] ?? 'Unknown error';
        print("❌ Failed to place order: $errorMessage (Status: ${response.statusCode})");
      } catch (e) {
        print("❌ Failed to place order: ${response.body} (Status: ${response.statusCode})");
      }
      return false;
    }
  } catch (e, stackTrace) {
    print("⚠️ Error placing order: $e");
    print("📍 Stack trace: $stackTrace");
    return false;
  }
}

// add to cart

  Future<void> addToCart({
  required String userId,
  required String productId,
  required int quantity,
  required String size,
}) async {
  final url = Uri.parse('$baseUrl/cart/add-product-to-cart/$userId');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "productId": productId,
        "quantity": quantity,
        "size": size,
      }),
    );

    if (response.statusCode == 200) {
      print("Item added to cart successfully");
      await fetchCartItems(userId); // Refresh cart after adding
    } else {
      print("Add to cart failed: ${response.body}");
    }
  } catch (e) {
    print("Add to cart exception: $e");
  }
  notifyListeners();
}



Future<List<dynamic>> fetchAllProducts() async {
  final url = Uri.parse('$baseUrl/all-products');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["products"]; // Adjust this based on your actual API response
    } else {
      print("Failed to load products: ${response.body}");
      return [];
    }
  } catch (e) {
    print("Error fetching products: $e");
    return [];
  
  }

}


Future<void> Addressupdate({
  required String token,
  required String userId,
  required Map<String, dynamic> addressData,
}) async {
  final url = Uri.parse('https://myntacloneappbackend-1.onrender.com/update-profile');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "userId": userId,
        "address": addressData,
      }),
    );

    if (response.statusCode == 200) {
      print("✅ Profile updated successfully");
    } else {
      print("❌ Update failed: ${response.body}");
    }
  } catch (e) {
    print("⚠️ Error updating profile: $e");
  }
}


Future<List<Map<String, dynamic>>> fetchUserAddresses({
  required String userId, // Ensure this matches the call site
  required String token,
}) async {
  final url = Uri.parse('https://myntacloneappbackend-1.onrender.com/View-profile/$userId'); // Use the parameter directly

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final addresses = data['user']['addresses'] as List<dynamic>;
      return addresses.cast<Map<String, dynamic>>();
    } else {
      print('❌ Failed to load address: ${response.body}');
      return [];
    }
  } catch (e) {
    print('⚠️ Error fetching address: $e');
    return [];
  }
}

}
