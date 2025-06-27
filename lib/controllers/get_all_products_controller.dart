import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whitematrix_groupa_shopping_app/models/get_all_products_model.dart';
import 'package:whitematrix_groupa_shopping_app/models/unique_category_model.dart';

class GetAllProductsController with ChangeNotifier {
  List<GetAllProductModel> productsList = [];
  List<GetAllProductModel> filteredProducts = [];
  List<CategoryModel> uniqueCategories = [];
  bool isLoading = true;
  String? errorMessage;
  bool isError = false;
  bool isEmpty = false;

  final String _baseUrl =
      "https://myntacloneappbackend-1.onrender.com/all-products";

    String selectedCategory = "Trending Now"; 

Future<void> fetchAllProducts({String? category, String? token}) async {
  isLoading = true;
  isError = false;
  errorMessage = null;
  isEmpty = false;
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization": token ??
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODViNmQ3NTgzNGU1YWE4Y2RhZjE4YjEiLCJpYXQiOjE3NTA4MzUzODUsImV4cCI6MTc1MTQ0MDE4NX0.FSFcXs_RgTC7v17oPWtMseUBfkPxMYsEgK4kLgCSg4E",
        "Content-Type": "application/json",
      },
    );
    

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      productsList =
          jsonResponse.map((e) => GetAllProductModel.fromJson(e)).toList();

      isEmpty = productsList.isEmpty;
    
  /// 🟡 Build unique categories with image map
        final Map<String, String> categoryImageMap = {};
        for (var product in productsList) {
          if (product.category.isNotEmpty && product.brand != null) {
            final brandMap = product.brand;
            String? image;

            if (brandMap is Map<String, dynamic>) {
              image = brandMap["image"];
            } else if (brandMap is BrandClass) {
              image = brandMap.image;
            }

            if (image != null && image.isNotEmpty) {
              categoryImageMap[product.category] = image;
            }
          }
        }

        /// 🔹 Now convert to a list of CategoryModel
        uniqueCategories = categoryImageMap.entries
            .map((e) => CategoryModel(name: e.key, image: e.value))
            .toList();

        /// 🔸 Sort by category name
        uniqueCategories.sort((a, b) => a.name.compareTo(b.name));


  // create filteredcategoryList corresponding to the argument   
        if (category != null && category.isNotEmpty) {
          filteredProducts = productsList
              .where((product) =>
                  (product.category ?? "").toLowerCase() ==
                  category.toLowerCase())
              .toList();
          log("📝 Filtered Products JSON:\n${jsonEncode(filteredProducts.map((e) => e.toJson()).toList())}");

        } else {
          filteredProducts = productsList;
        }


        isEmpty = filteredProducts.isEmpty;
      

   for (var product in filteredProducts) {
  final firstVariant = product.variants.isNotEmpty ? product.variants.first : null;
  final price = firstVariant?.price ?? "N/A";
  final discount = firstVariant?.discount;
  final image = firstVariant?.images.isNotEmpty == true ? firstVariant!.images.first : "No image";

  log('''
🔹 Product: ${product.title}
   🔸 Brand: ${product.brand is Map ? product.brand["name"] : product.brand}
   🔸 Category: ${product.category}
   🔸 Price: ₹$price
   🔸 Discount: ${discount != null ? '${discount.value}% (${discount.type})' : "No Discount"}
   🔸 Image: $image
   🔸 Reviews: ${product.reviews.length}
''');
}

    } else {
      isError = true;
      errorMessage =
          "Failed to load products (Status: ${response.statusCode})";
      log("❌ Error: $errorMessage");
    }
  } catch (e, stackTrace) {
    isError = true;
    errorMessage = "Exception: $e";
    log('❌ Error fetching products', error: e, stackTrace: stackTrace);
  } finally {
    isLoading = false;
    notifyListeners();
  }
}




}