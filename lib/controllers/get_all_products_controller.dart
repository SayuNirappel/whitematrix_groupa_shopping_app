import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whitematrix_groupa_shopping_app/models/get_all_products_model.dart';

class GetAllProductsController with ChangeNotifier {
  List<GetAllProductModel> productsList = [];
  List<String> uniqueCategories = [];
  bool isLoading = true;
  String? errorMessage;
  bool isError = false;
  bool isEmpty = false;

  final String _baseUrl =
      "https://myntacloneappbackend-1.onrender.com/all-products";

    String selectedCategory = "Trending Now"; 

Future<void> fetchAllProducts() async {
  isLoading = true;
  isError = false;
  errorMessage = null;
  isEmpty = false;
  notifyListeners();

  try {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODViNmQ3NTgzNGU1YWE4Y2RhZjE4YjEiLCJpYXQiOjE3NTA4MzUzODUsImV4cCI6MTc1MTQ0MDE4NX0.FSFcXs_RgTC7v17oPWtMseUBfkPxMYsEgK4kLgCSg4E",
        "Content-Type": "application/json",
      },
    );
    

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      productsList =
          jsonResponse.map((e) => GetAllProductModel.fromJson(e)).toList();

      isEmpty = productsList.isEmpty;
    
  uniqueCategories = productsList
      .map((e) => e.category)
      .toSet()
      .toList();

 
  uniqueCategories.sort();
      

      log("✅ Products fetched successfully (${productsList.length}):\n${productsList.map((e) => e.toString()).join('\n')}");
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