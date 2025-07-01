import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

class ProductService {
  static Future<List<ProductsResModel>> fetchProducts() async {
    try {
      final url = Uri.parse("${ApiConstants.baseUrl}/all-products");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${ApiConstants.token}",
          "Content-Type": "application/json",
        },
      );

      print("🟡 STATUS: ${response.statusCode}");
      print("🟡 BODY: ${response.body}");

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);
        // 🔍 Add this debug print here
        // final genders = decoded.map((e) => e["gender"]).toSet().toList();
        // print("🧩 Unique gender values in API: $genders");
        //
        print("🟢 Decoded length: ${decoded.length}");

        final List<ProductsResModel> safeProducts = [];

        for (var e in decoded) {
          try {
            final product = ProductsResModel.fromJson(e);
            safeProducts.add(product);
          } catch (err) {
            print("❌ Failed to parse product: $err");
            print("⛔ Skipped Product Data: $e\n");
          }
        }

        print("✅ Successfully parsed products: ${safeProducts.length}");
        return safeProducts;
      } else {
        print("❌ Failed to fetch products. Status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Exception occurred while fetching products: $e");
      return [];
    }
  }
}

///
///
///
///
///
///
///
///

// class ProductService {
//   static Future<List<ProductsResModel>> fetchProducts() async {
//     try {
//       final url = Uri.parse("${ApiConstants.baseUrl}/all-products");

//       final response = await http.get(
//         url,
//         headers: {
//           "Authorization": "Bearer ${ApiConstants.token}",
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final List decoded = jsonDecode(response.body);
//         return decoded.map((e) => ProductsResModel.fromJson(e)).toList();
//       } else {
//         throw Exception("Failed to load products: ${response.statusCode}");
//       }
//     } catch (e) {
//       // You can print the error or log it if needed
//       print("Error fetching products: $e");

//       // Optionally show a snackbar or toast using context (if passed)
//       // Return an empty list or rethrow the error depending on use case
//       return [];
//     }
//   }
// }
