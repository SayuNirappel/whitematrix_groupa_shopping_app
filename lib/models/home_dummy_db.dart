// import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';
// import 'package:whitematrix_groupa_shopping_app/services/api/home_api/product_service.dart';

// class DummyDb {
//   static List<ProductsResModel> allProducts = [];
//   static int selectedCategory = 0;
//   static String getImage(int index) {
//     if (index >= 0 &&
//         allProducts.length > index &&
//         allProducts[index].variants!.isNotEmpty &&
//         allProducts[index].variants!.first.images!.isNotEmpty) {
//       return allProducts[index].variants!.first.images!.first;
//     }
//     // fallback image if data is missing or incomplete
//     return "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg";
//   }

//   static List<Map<String, String>> notificationList = [
//     {
//       "image":
//           "https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg",
//       "time": "Deal valid for 4hrs",
//       "brand": "H&M",
//       "offer": "Up to 60% Off on summer collection"
//     },
//     {
//       "image":
//           "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
//       "time": "Limited Time Offer",
//       "brand": "Zara",
//       "offer": "Flat ₹500 Off on all jeans"
//     },
//     {
//       "image":
//           "https://images.pexels.com/photos/2983460/pexels-photo-2983460.jpeg",
//       "time": "Deal valid for 4hrs",
//       "brand": "Nike",
//       "offer": "Buy 1 Get 1 on select sneakers"
//     }
//   ];
//   static List<Map<String, String>> categories = [
//     {
//       "title": "Fashion",
//       "image":
//           "https://images.pexels.com/photos/994234/pexels-photo-994234.jpeg",
//     },
//     {
//       "title": "Beauty",
//       "image":
//           "https://images.pexels.com/photos/3373742/pexels-photo-3373742.jpeg",
//     },
//     {
//       "title": "Home & Living",
//       "image":
//           "https://images.pexels.com/photos/8580762/pexels-photo-8580762.jpeg",
//     },
//     {
//       "title": "Footwear",
//       "image": "https://images.pexels.com/photos/19090/pexels-photo.jpg",
//     },
//     {
//       "title": "Accessories",
//       "image":
//           "https://images.pexels.com/photos/157888/fashion-glasses-go-pro-female-157888.jpeg",
//     },
//   ];

//   static List<String> carousel1ImgeUrl = [
//     "https://images.pexels.com/photos/1204463/pexels-photo-1204463.jpeg",
//     "https://images.pexels.com/photos/130855/pexels-photo-130855.jpeg",
//     "https://images.pexels.com/photos/1639729/pexels-photo-1639729.jpeg"
//   ];
//   static List<Map<String, dynamic>> get bestSellerCategory {
//     if (allProducts.length < 13) return [];

//     return [
//       {
//         "type": allProducts[12].category,
//         "offer": allProducts[12].discount?.type.toString() ?? "None",
//         "image": getImage(12),
//         "id": allProducts[12].id,
//       },
//       {
//         "type": allProducts[0].category,
//         "offer": allProducts[0].discount?.type.toString() ?? "None",
//         "image": getImage(0),
//         "id": allProducts[0].id,
//       },
//       {
//         "type": allProducts[12].category,
//         "offer": allProducts[12].discount?.type.toString() ?? "None",
//         "image": getImage(12),
//         "id": allProducts[12].id,
//       },
//       {
//         "type": allProducts[0].category,
//         "offer": allProducts[0].discount?.type.toString() ?? "None",
//         "image": getImage(0),
//         "id": allProducts[0].id,
//       },
//     ];
//   }

//   static List<Map<String, String>> get featuredBrandsList {
//     if (allProducts.length < 13) return []; // since we're accessing index 12

//     return [
//       {
//         "image": getImage(2),
//         "brand": allProducts[2].brand?.name ?? "Custom",
//         "title": allProducts[2].category ?? "All",
//         "subt": allProducts[2].variants!.first.color ?? "Black",
//         "id": allProducts[2].id ?? "",
//       },
//       {
//         "image": getImage(4),
//         "brand": allProducts[4].brand?.name ?? "Custom",
//         "title": allProducts[4].category ?? "All",
//         "subt": allProducts[4].variants!.first.color ?? "Black",
//         "id": allProducts[4].id ?? "",
//       },
//       {
//         "image": getImage(6),
//         "brand": allProducts[6].brand?.name ?? "Custom",
//         "title": allProducts[6].category ?? "All",
//         "subt": allProducts[6].variants!.first.color ?? "Black",
//         "id": allProducts[6].id ?? "",
//       },
//       {
//         "image": getImage(8),
//         "brand": allProducts[8].brand?.name ?? "Custom",
//         "title": allProducts[8].category ?? "All",
//         "subt": allProducts[8].variants!.first.color ?? "Black",
//         "id": allProducts[8].id ?? "",
//       },
//       {
//         "image": getImage(10),
//         "brand": allProducts[10].brand?.name ?? "Custom",
//         "title": allProducts[10].category ?? "All",
//         "subt": allProducts[10].variants!.first.color ?? "Black",
//         "id": allProducts[10].id ?? "",
//       },
//       {
//         "image": getImage(1),
//         "brand": allProducts[1].brand?.name ?? "Custom",
//         "title": allProducts[1].category ?? "All",
//         "subt": allProducts[1].variants!.first.color ?? "Black",
//         "id": allProducts[1].id ?? "",
//       },
//     ];
//   }

//   static List<Map<String, String>> get featuredPicks {
//     return [
//       {
//         "image": getImage(1),
//         "name": allProducts[1].brand?.name ?? "Custom",
//         "category": allProducts[1].category ?? "All",
//         "oP": allProducts[1].variants!.first.price.toString() ?? "₹500",
//         "nP": allProducts[1].discount?.type.toString() ?? "Flat",
//         "reduction": "${allProducts[1].discount?.value ?? "10"}%off",
//         "id": allProducts[1].id ?? "",
//       },
//       {
//         "image": getImage(3),
//         "name": allProducts[3].brand?.name ?? "Custom",
//         "category": allProducts[3].category ?? "All",
//         "oP": allProducts[3].variants!.first.price.toString() ?? "₹500",
//         "nP": allProducts[3].discount?.type.toString() ?? "Flat",
//         "reduction": "${allProducts[3].discount?.value ?? "10"}%off",
//         "id": allProducts[3].id ?? "",
//       },
//       {
//         "image": getImage(5),
//         "name": allProducts[5].brand?.name ?? "Custom",
//         "category": allProducts[5].category ?? "All",
//         "oP": allProducts[5].variants!.first.price.toString() ?? "₹500",
//         "nP": allProducts[5].discount?.type.toString() ?? "Flat",
//         "reduction": "${allProducts[5].discount?.value ?? "10"}%off",
//         "id": allProducts[5].id ?? "",
//       },
//       {
//         "image": getImage(7),
//         "name": allProducts[7].brand?.name ?? "Custom",
//         "category": allProducts[7].category ?? "All",
//         "oP": allProducts[7].variants!.first.price.toString() ?? "₹500",
//         "nP": allProducts[7].discount?.type.toString() ?? "Flat",
//         "reduction": "${allProducts[7].discount?.value ?? "10"}%off",
//         "id": allProducts[7].id ?? "",
//       },
//       {
//         "image": getImage(9),
//         "name": allProducts[9].brand?.name ?? "Custom",
//         "category": allProducts[9].category ?? "All",
//         "oP": allProducts[9].variants!.first.price.toString() ?? "₹500",
//         "nP": allProducts[9].discount?.type.toString() ?? "Flat",
//         "reduction": "${allProducts[9].discount?.value ?? "10"}%off",
//         "id": allProducts[9].id ?? "",
//       },
//     ];
//   }

//   static List<Map<String, String>> get hiddenGems {
//     final List<Map<String, String>> list = [];
//     final indices = [9, 0, 3, 6, 8];

//     for (var i in indices) {
//       if (allProducts.length > i &&
//           allProducts[i].variants?.isNotEmpty == true) {
//         list.add({
//           "type": allProducts[i].category ?? "All",
//           "offer": "From ₹${allProducts[i].variants!.first.price ?? "500"}",
//           "image": getImage(i),
//           "id": allProducts[i].id ?? "",
//         });
//       }
//     }

//     return list;
//   }

//   static List<Map<String, String>> get seasonsBrandsList {
//     List<Map<String, String>> list = [];
//     List<int> indices = [1, 3, 5];

//     for (int i in indices) {
//       if (i < allProducts.length) {
//         list.add({
//           "image": getImage(i),
//           "brand": allProducts[i].brand?.name ?? "Custom",
//           "title": allProducts[i].category ?? "All",
//           "subt": allProducts[i].variants?.first.price.toString() ?? "₹500",
//           "id": allProducts[i].id ?? "",
//         });
//       }
//     }

//     return list;
//   }

//   static List<Map<String, String>> get trendingNearby {
//     List<Map<String, String>> list = [];
//     List<int> indices = [2, 4, 6];

//     for (int i in indices) {
//       if (i < allProducts.length) {
//         list.add({
//           "image": getImage(i),
//           "id": allProducts[i].id ?? "",
//         });
//       }
//     }

//     return list;
//   }

//   static List<String> brandBanners = [
//     "https://images.pexels.com/photos/1204463/pexels-photo-1204463.jpeg"
//   ];
// }
