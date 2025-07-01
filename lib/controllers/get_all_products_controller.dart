import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whitematrix_groupa_shopping_app/models/get_all_products_model.dart';
import 'package:whitematrix_groupa_shopping_app/models/unique_category_model.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

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
          "Authorization": "Bearer ${token ?? ApiConstants.token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);

        final DateTime cutoffDate = DateTime(2025, 6, 30);

        // ✅ Filter productsList before 30 June 2025
        productsList = jsonResponse
            .map((e) => GetAllProductModel.fromJson(e))
            .where((product) {
              final createdAt = _parseDate(product.createdAt);
              return createdAt != null && createdAt.isBefore(cutoffDate);
            })
            .toList();

        isEmpty = productsList.isEmpty;

        // ✅ Build uniqueCategories from valid products
        final Map<String, String> categoryImageMap = {};
        for (var product in productsList) {
          final createdAt = _parseDate(product.createdAt);
          if (createdAt == null || createdAt.isAfter(cutoffDate)) continue;

          if (product.category.isNotEmpty && product.brand != null) {
            final pimage = product.variants.first.images;
            String? image;

            if (pimage is String) {
              image = pimage.toString();
            } else if (pimage is List && pimage.isNotEmpty) {
              image = pimage.first.toString();
            }

            if (image != null && image.isNotEmpty) {
              categoryImageMap[product.category] = image;
            }
          }
        }

        uniqueCategories = categoryImageMap.entries
            .map((e) => CategoryModel(name: e.key, image: e.value))
            .toList();

        uniqueCategories.sort((a, b) => a.name.compareTo(b.name));

        // ✅ Filter products based on selected category
        if (category != null && category.isNotEmpty) {
          filteredProducts = productsList.where((product) {
            return (product.category ?? "").toLowerCase() ==
                category.toLowerCase();
          }).toList();
        } else {
          filteredProducts = productsList;
        }

        isEmpty = filteredProducts.isEmpty;

        for (var product in filteredProducts) {
          final firstVariant =
              product.variants.isNotEmpty ? product.variants.first : null;
          final price = firstVariant?.price ?? "N/A";
          final discount = firstVariant?.discount;
          final image = firstVariant?.images.isNotEmpty == true
              ? firstVariant!.images.first
              : "No image";

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

  /// 🔹 Helper: Safely parse dynamic `createdAt` to `DateTime?`
  DateTime? _parseDate(dynamic date) {
    if (date is DateTime) return date;
    if (date is String) return DateTime.tryParse(date);
    return null;
  }
}
