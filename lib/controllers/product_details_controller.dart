import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/core/services/products_api_services.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';

class ProductProvider with ChangeNotifier {
  ProductsResModel? selectedProduct;

  bool isLoading = false;
  bool isAddingToCart = false;

  Future<void> fetchProductById(String id) async {
    isLoading = true;
    selectedProduct = null;
    notifyListeners();

    try {
      final response = await ProductsApiServices().fetchProductById(id);
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

      final data = {
        "productId": product.id,
        "sku": variant.sku,
        "quantity": quantity,
      };

      final response = await ProductsApiServices().addToCart(userId, data);

      if (response == true) {
        print("✅ Product added to cart");
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
    if (selectedProduct == null ||
        selectedProduct!.variants == null ||
        selectedProduct!.variants?.isEmpty == true) {
      return 0.0;
    }

    final variant = selectedSize != null
        ? (selectedProduct!.variants != null &&
                selectedProduct!.variants?.isNotEmpty == true
            ? selectedProduct!.variants!.firstWhere(
                (v) => v.size == selectedSize,
                orElse: () => selectedProduct!.variants!.first,
              )
            : null)
        : (selectedProduct!.variants != null &&
                selectedProduct!.variants!.isNotEmpty
            ? selectedProduct!.variants!.first
            : null);

    if (variant == null) {
      return 0.0;
    }

    final int price = variant.price ?? 0;
    final discount = variant.discount ?? selectedProduct!.discount;

    return _calculateDiscountedPrice(price, discount);
  }

  String? discountText({String? selectedSize}) {
    if (selectedProduct == null || selectedProduct!.variants?.isEmpty != false)
      return null;

    final variant = selectedSize != null
        ? (selectedProduct!.variants != null &&
                selectedProduct!.variants!.isNotEmpty
            ? selectedProduct!.variants!.firstWhere(
                (v) => v.size == selectedSize,
                orElse: () => selectedProduct!.variants!.first,
              )
            : null)
        : (selectedProduct!.variants != null &&
                selectedProduct!.variants!.isNotEmpty
            ? selectedProduct!.variants!.first
            : null);

    final discount = variant?.discount ?? selectedProduct!.discount;

    if (discount != null &&
        discount.isActive == true &&
        discount.startDate != null &&
        discount.endDate != null &&
        DateTime.now().isAfter(discount.startDate!) &&
        DateTime.now().isBefore(discount.endDate!)) {
      if (discount.type != null &&
          discount.type.toString().toLowerCase() == 'flat') {
        return '₹${discount.value} OFF';
      } else if (discount.type != null &&
          discount.type.toString().toLowerCase() == 'percentage') {
        return '${discount.value}% OFF';
      }
    }
    return null;
  }

  Map<String, dynamic> getPricingInfo(
      ProductsResModel product, String? selectedSize) {
    final selectedVariant = selectedSize != null
        ? (product.variants != null && product.variants!.isNotEmpty
            ? product.variants!.firstWhere(
                (v) => v.size == selectedSize,
                orElse: () => product.variants!.first,
              )
            : null)
        : (product.variants != null && product.variants!.isNotEmpty
            ? product.variants!.first
            : null);

    final discount = selectedVariant?.discount ?? product.discount;
    final int price = selectedVariant?.price ?? 0;

    bool hasDiscount = false;
    double offerPrice = price.toDouble();
    String? discountText;

    if (discount != null &&
        discount.isActive == true &&
        discount.startDate != null &&
        discount.endDate != null &&
        DateTime.now().isAfter(discount.startDate!) &&
        DateTime.now().isBefore(discount.endDate!)) {
      hasDiscount = true;

      if (discount.type != null &&
          discount.type.toString().toLowerCase().contains('percentage')) {
        final discountAmount = ((price * (discount.value ?? 0)) / 100).round();
        offerPrice = (price - discountAmount).toDouble();
        discountText = '${discount.value}% OFF';
      } else if (discount.type != null &&
          discount.type.toString().toLowerCase().contains('flat')) {
        offerPrice = (price - (discount.value ?? 0)).clamp(0, price).toDouble();
        discountText = '₹${discount.value} OFF';
      }
    }

    return {
      'price': price,
      'offerPrice': offerPrice,
      'discountText': discountText,
      'hasDiscount': hasDiscount,
    };
  }

  int selectedImageIndex = 0;
  String? selectedSize;
  int selectedVariantIndex = 0;

  double _calculateDiscountedPrice(int price, dynamic discount) {
    if (discount != null &&
        discount.isActive == true &&
        discount.startDate != null &&
        discount.endDate != null &&
        DateTime.now().isAfter(discount.startDate!) &&
        DateTime.now().isBefore(discount.endDate!)) {
      if (discount.type != null &&
          discount.type.toString().toLowerCase().contains('percentage')) {
        final discountAmount = ((price * (discount.value ?? 0)) / 100).round();
        return (price - discountAmount).toDouble();
      } else if (discount.type != null &&
          discount.type.toString().toLowerCase().contains('flat')) {
        return (price - (discount.value ?? 0)).clamp(0, price).toDouble();
      }
    }
    return price.toDouble();
  }
}
