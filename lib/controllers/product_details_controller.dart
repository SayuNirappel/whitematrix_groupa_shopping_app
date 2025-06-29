import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/cartcontroller.dart';
import 'package:whitematrix_groupa_shopping_app/core/services/products_api_services.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';

class ProductProvider with ChangeNotifier {
  ProductsResModel? selectedProduct;

  bool isLoading = false;
  bool isAddingToCart = false;

  Future<void> fetchProductById({required String id}) async {
  isLoading = true;
  selectedProduct = null; 
  notifyListeners();

  try {
    final response = await ProductsApiServices().fetchProductById(id : id);
    if (response != null) {
      selectedProduct = response;
      } else {
        print("No product found with ID: $id");
      }
    } catch (e) {
      print("Error fetching product by ID: $e");
      selectedProduct = null;
    }

    isLoading = false;
    notifyListeners();
  }
  

 ///add to cart
  Future<void> addProductToCart(
  String userId, 
  String productId,
  ProductsResModel product,
  String selectedSku, 
  int quantity,
  BuildContext context,
) async {
  isAddingToCart = true;
  notifyListeners();

  try {
    // Get variant by SKU
    final variant = product.variants!.firstWhere(
      (v) => v.sku == selectedSku,
      orElse: () => throw Exception("SKU not found"),
    );

   final response = await ProductsApiServices().addToCart(
     userId: ApiConstants.userID,
     productId: product.id ?? '',
     variantSKU: variant.sku!,
     quantity: quantity,
   );

if (response == true) {
  print("✅ Product added to cart");
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
  await cartProvider.fetchCartItems(userId);
} else {
  print("❌ Cart API failed.");
}

  } catch (e) {
    log("❌ Error adding to cart: $e");
  }

  isAddingToCart = false;
  notifyListeners();
}

 double calculateOfferPrice({String? selectedSize}) {
  if (selectedProduct == null || selectedProduct!.variants?.isEmpty != false) {
    return 0.0;
  }

  final variant = _getSelectedVariant(selectedProduct!.variants!, selectedSize);
  if (variant == null) return 0.0;

  final int price = variant.price ?? 0;
  final discount = variant.discount ?? selectedProduct!.discount;

  return _calculateDiscountedPrice(price, discount);
}

String? discountText({String? selectedSize}) {
  if (selectedProduct == null || selectedProduct!.variants?.isEmpty != false) {
    return null;
  }

  final variant = _getSelectedVariant(selectedProduct!.variants!, selectedSize);
  final discount = variant?.discount ?? selectedProduct!.discount;

  if (_isDiscountValid(discount)) {
    final type = discount?.type?.toString().toLowerCase();
    final value = discount?.value;

    if (type == 'flat') {
      return '₹$value OFF';
    } else if (type == 'percentage') {
      return '$value% OFF';
    }
  }

  return null;
}

Map<String, dynamic> getPricingInfo(ProductsResModel product, String? selectedSize) {
  final variant = _getSelectedVariant(product.variants, selectedSize);
  final int price = variant?.price ?? 0;
  final discount = variant?.discount ?? product.discount;

  bool hasDiscount = false;
  double offerPrice = price.toDouble();
  String? discountLabel;

  if (_isDiscountValid(discount)) {
    hasDiscount = true;

    final type = discount!.type?.toString().toLowerCase();
    final value = discount.value ?? 0;

    if (type?.contains('percentage') == true) {
      final discountAmount = ((price * value) / 100).round();
      offerPrice = (price - discountAmount).toDouble();
      discountLabel = '$value% OFF';
    } else if (type?.contains('flat') == true) {
      offerPrice = (price - value).clamp(0, price).toDouble();
      discountLabel = '₹$value OFF';
    }
  }

  return {
    'price': price,
    'offerPrice': offerPrice,
    'discountText': discountLabel,
    'hasDiscount': hasDiscount,
  };
}

double _calculateDiscountedPrice(int price, dynamic discount) {
  if (_isDiscountValid(discount)) {
    final type = discount.type?.toString().toLowerCase();
    final value = discount.value ?? 0;

    if (type?.contains('percentage') == true) {
      final discountAmount = ((price * value) / 100).round();
      return (price - discountAmount).toDouble();
    } else if (type?.contains('flat') == true) {
      return (price - value).clamp(0, price).toDouble();
    }
  }

  return price.toDouble();
}

bool _isDiscountValid(dynamic discount) {
  return discount != null &&
      discount.isActive == true &&
      discount.startDate != null &&
      discount.endDate != null &&
      DateTime.now().isAfter(discount.startDate!) &&
      DateTime.now().isBefore(discount.endDate!);
}

Variant? _getSelectedVariant(List<Variant>? variants, String? selectedSize) {
  if (variants == null || variants.isEmpty) return null;

  if (selectedSize != null) {
    return variants.firstWhere(
      (v) => v.size == selectedSize,
      orElse: () => variants.first,
    );
  }

  return variants.first;
}

}
