// To parse this JSON data, do
//
//     final getAllProductModel = getAllProductModelFromJson(jsonString);

import 'dart:convert';

List<GetAllProductModel> getAllProductModelFromJson(String str) =>
    List<GetAllProductModel>.from(
        json.decode(str).map((x) => GetAllProductModel.fromJson(x)));

String getAllProductModelToJson(List<GetAllProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllProductModel {
  dynamic brand;
  String id;
  String title;
  String category;
  String description;
  List<Variant> variants;
  String? createdBy;
  DateTime createdAt;
  int v;
  List<Review> reviews;
  Discount? discount;

  GetAllProductModel({
    this.brand,
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.variants,
    this.createdBy,
    required this.createdAt,
    required this.v,
    required this.reviews,
    this.discount,
  });

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) =>
      GetAllProductModel(
        brand: json["brand"],
        id: json["_id"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        variants: List<Variant>.from(
            json["variants"].map((x) => Variant.fromJson(x))),
        createdBy: json["createdBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        v: json["__v"],
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "_id": id,
        "title": title,
        "category": category,
        "description": description,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "discount": discount?.toJson(),
      };
}

class BrandClass {
  String name;
  String image;

  BrandClass({
    required this.name,
    required this.image,
  });

  factory BrandClass.fromJson(Map<String, dynamic> json) => BrandClass(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}

class Discount {
  Type type;
  int value;
  DateTime startDate;
  DateTime endDate;
  bool isActive;

  Discount({
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        type: typeValues.map[json["type"]]!,
        value: json["value"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "value": value,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isActive": isActive,
      };
}

enum Type { FLAT, PERCENTAGE }

final typeValues =
    EnumValues({"flat": Type.FLAT, "percentage": Type.PERCENTAGE});

class Review {
  String user;
  int rating;
  String comment;
  DateTime createdAt;

  Review({
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
      };
}

class Variant {
  String sku;
  String color;
  String size;
  int price;
  int stock;
  List<String> images;
  Discount? discount;

  Variant({
    required this.sku,
    required this.color,
    required this.size,
    required this.price,
    required this.stock,
    required this.images,
    this.discount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        sku: json["sku"],
        color: json["color"],
        size: json["size"],
        price: json["price"],
        stock: json["stock"],
        images: List<String>.from(json["images"].map((x) => x)),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "sku": sku,
        "color": color,
        "size": size,
        "price": price,
        "stock": stock,
        "images": List<dynamic>.from(images.map((x) => x)),
        "discount": discount?.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
