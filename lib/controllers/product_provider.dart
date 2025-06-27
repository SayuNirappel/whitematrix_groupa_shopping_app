import 'package:flutter/material.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/home_api/product_service.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/home_api/banner_service.dart';

class ProductProvider with ChangeNotifier {
  List<ProductsResModel> allProducts = [];
  List<ProductsResModel> genderProducts = [];
  List<String> bannerImages = [];
  bool isLoading = true;
  List<Map<String, String>> get categories {
    final Map<String, String> categoryMap = {}; // categoryName -> imageUrl

    for (var product in allProducts) {
      final category = product.category ?? "Uncategorized";

      // Skip if category is already added
      if (categoryMap.containsKey(category)) continue;

      // Get the first available image from variants
      final image = product.variants?.first.images?.isNotEmpty == true
          ? _getFullImageUrl(product.variants!.first.images!.first)
          : "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg";

      categoryMap[category] = image;
    }

    // Convert to List<Map<String, String>>
    return categoryMap.entries.map((e) {
      return {
        "title": e.key,
        "image": e.value,
      };
    }).toList();
  }

  Future<void> fetchInitialData() async {
    isLoading = true;
    notifyListeners();

    final products = await ProductService.fetchProducts();
    setAllProducts(products); //  this replaces your direct assignment

    bannerImages = await BannerService.fetchActiveBannerImages();

    isLoading = false;
    notifyListeners();
  }

  String getImage(int index) {
    if (index >= 0 &&
        allProducts.length > index &&
        allProducts[index].variants!.isNotEmpty &&
        allProducts[index].variants!.first.images!.isNotEmpty) {
      return allProducts[index].variants!.first.images!.first;
    }
    return "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg";
  }

  List<Map<String, dynamic>> get bestSellerCategory {
    if (allProducts.length < 13) return [];

    return [
      {
        "type": allProducts[12].category,
        "offer": allProducts[12].discount?.type.toString() ?? "None",
        "image": getImage(12),
        "id": allProducts[12].id,
      },
      {
        "type": allProducts[0].category,
        "offer": allProducts[0].discount?.type.toString() ?? "None",
        "image": getImage(0),
        "id": allProducts[0].id,
      },
    ];
  }

  List<Map<String, String>> get featuredBrandsList {
    if (allProducts.length < 13) return [];

    return [
      _brandMap(2),
      _brandMap(4),
      _brandMap(6),
      _brandMap(8),
      _brandMap(10),
      _brandMap(1),
    ];
  }

  List<Map<String, String>> get featuredPicks {
    final indices = [1, 3, 5, 7, 9];
    return indices
        .where((i) => i < allProducts.length)
        .map((i) => {
              "image": getImage(i),
              "name": allProducts[i].brand?.name ?? "Custom",
              "category": allProducts[i].category ?? "All",
              "oP": allProducts[i].variants!.first.price.toString(),
              "nP": allProducts[i].discount?.type.toString() ?? "Flat",
              "reduction": "${allProducts[i].discount?.value ?? "10"}%off",
              "id": allProducts[i].id ?? "",
            })
        .toList();
  }

  List<Map<String, String>> get notificationList {
    return allProducts
        .where((product) {
          // Product-level discount check
          final isProductDiscountActive = product.discount?.isActive == true;

          // Variant-level discount check
          final isAnyVariantDiscountActive = product.variants?.any(
                (v) => v.discount?.isActive == true,
              ) ??
              false;

          return isProductDiscountActive || isAnyVariantDiscountActive;
        })
        .map((product) => _mapNotificationFromProduct(product))
        .toList();
  }

  Map<String, String> _mapNotification(int index) {
    final product = allProducts[index];
    return {
      "image": product.variants?.first.images?.first ??
          "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg",
      "brand": product.title ?? "Untitled",
      "offer":
          "${product.variants?.first.discount?.value ?? 0}${typeValues.reverse[product.variants?.first.discount?.type] == "flat" ? " OFF" : "% OFF"}",
      "time": "${index + 1} hrs ago",
    };
  }

  String _getFullImageUrl(String relativePath) {
    return relativePath.startsWith("http")
        ? relativePath
        : " https://myntacloneappbackend-1.onrender.com/all-products/$relativePath";
  }

  Map<String, String> _mapNotificationFromProduct(ProductsResModel product) {
    final image = product.variants?.first.images?.isNotEmpty == true
        ? product.variants!.first.images!.first
        : "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg";

    final offerValue =
        product.discount?.value ?? product.variants?.first.discount?.value ?? 0;

    final offerType = typeValues.reverse[
            product.discount?.type ?? product.variants?.first.discount?.type] ??
        "flat";

    final offerText =
        offerType == "flat" ? "$offerValue OFF" : "$offerValue% OFF";

    return {
      "image": image,
      "brand": product.title ?? "Untitled",
      "offer": offerText,
      "time": "Just now", // You can make this dynamic if needed
    };
  }

  List<Map<String, String>> get hiddenGems {
    final indices = [9, 0, 3, 6, 8];
    return indices
        .where((i) => i < allProducts.length)
        .map((i) => {
              "type": allProducts[i].category ?? "All",
              "offer": "From ₹${allProducts[i].variants!.first.price}",
              "image": getImage(i),
              "id": allProducts[i].id ?? "",
            })
        .toList();
  }

  List<Map<String, String>> get seasonsBrandsList {
    return [1, 3, 5]
        .where((i) => i < allProducts.length)
        .map((i) => _brandMap(i))
        .toList();
  }

  List<Map<String, String>> get trendingNearby {
    return [2, 4, 6]
        .where((i) => i < allProducts.length)
        .map((i) => {
              "image": getImage(i),
              "id": allProducts[i].id ?? "",
            })
        .toList();
  }

  Map<String, String> _brandMap(int i) {
    return {
      "image": getImage(i),
      "brand": allProducts[i].brand?.name ?? "Custom",
      "title": allProducts[i].category ?? "All",
      "subt": allProducts[i].variants!.first.color ?? "Black",
      "id": allProducts[i].id ?? "",
    };
  }

  void setAllProducts(List<ProductsResModel> products) {
    allProducts = products;
    genderProducts = products
        .where((e) => (e.gender ?? '').toString().toLowerCase() == 'men')
        .toList();

    // Debugging aid — you can remove this later
    print("Total Products: ${products.length}");
    print("Men's Products: ${genderProducts.length}");
    for (var p in products) {
      print("→ ${p.title} | Gender: ${p.gender}");
    }

    notifyListeners();
  }
}
