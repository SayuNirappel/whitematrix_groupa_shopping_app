import 'dart:convert';

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
}
