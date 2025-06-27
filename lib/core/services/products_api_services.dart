import 'dart:convert';
import 'dart:developer';
import 'package:whitematrix_groupa_shopping_app/core/network/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';

class ProductsApiServices {
 
 Future<List<ProductsResModel>?> fetchProducts() async {
    final resp = await ApiHelper.getData(endpoint: "/all-products");
    if (resp != null) {
      try {
        return productsResModelFromJson(resp);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<ProductsResModel?> fetchProductById(String id) async {
    final resp = await ApiHelper.getData(endpoint: "/product/$id");
    if (resp != null) {
      try {
        return ProductsResModel.fromJson(jsonDecode(resp));
        
      } catch (e) {
        print("Parsing single product error: $e");
        return null;
      }
    }
    return null;
  }
  
Future<bool> addToCart(String? userId, Map<String, dynamic> data) async {
  final resolvedUserId = userId ?? '685d96d6530d52e9c7e6e686'; // Default 

  final response = await ApiHelper.postData(
    endpoint: "/cart/add-product-to-cart/$resolvedUserId",
    data: {
  "productId": "685cf803728c88a1bc91821e",
  "variantSKU": "NRTN-SHOES-BLK-9",
  "quantity" : 1
}
,
  );

  if (response != null) {
    log("🧾 Cart API response status: ${response.statusCode}");
    log("📦 Response body: ${response.body}");

    if (response.statusCode == 200) {
      log("✅ Product added to cart successfully.");
      return true;
    } else {
      log("❌ Cart API returned error ${response.statusCode}: ${response.body}");
    }
  } else {
    log("❌ Cart API call failed (null response)");
  }

  return false;
}
}
