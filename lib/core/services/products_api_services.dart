import 'dart:convert';
import 'dart:developer';
import 'package:whitematrix_groupa_shopping_app/core/network/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

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

  Future<ProductsResModel?> fetchProductById({required String id}) async {
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
  

Future<bool> addToCart({
  required String? userId,
  required String productId,
  required String variantSKU,
  required int quantity,
}) async {
  final userId = ApiConstants.userID ; 

  final response = await ApiHelper.postData(
    endpoint: "/cart/add-product-to-cart/$userId",
    data: {
      "productId": productId,
      "variantSKU": variantSKU,
      "quantity": quantity,
    },
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
