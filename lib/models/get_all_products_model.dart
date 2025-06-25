import 'dart:convert';

class GetAllProductModel {
  final String id;
  final String title;
  final String brand;
  final int? price;
  final String category;
  final List<String> size;
  final String? image;
  final String description;
  final int? stock;
  final String createdBy;
  final DateTime createdAt;
  final int v;
  final List<Variant> variants;
  final Discount? discount;

  GetAllProductModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.category,
    required this.size,
    required this.image,
    required this.description,
    required this.stock,
    required this.createdBy,
    required this.createdAt,
    required this.v,
    required this.variants,
    this.discount,
  });

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) {
    return GetAllProductModel(
      id: json["_id"] ?? '',
      title: json["title"] ?? '',
      brand: json["brand"] ?? '',
      price: json["price"],
      category: json["category"] ?? '',
      size: json["size"] == null
          ? []
          : List<String>.from(json["size"].map((x) => x.toString().replaceAll('"', ''))), // Remove quotes
      image: json["image"],
      description: json["description"] ?? '',
      stock: json["stock"],
      createdBy: json["createdBy"] ?? '',
      createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      v: json["__v"] ?? 0,
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
      discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "brand": brand,
        "price": price,
        "category": category,
        "size": List<dynamic>.from(size.map((x) => x)),
        "image": image,
        "description": description,
        "stock": stock,
        "createdBy": createdBy,
        "createdAt": createdAt.toIso8601String(),
        "__v": v,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "discount": discount?.toJson(),
      };

  // Override toString method
  @override
  String toString() {
    return 'GetAllProductModel{id: $id, title: $title, brand: $brand, price: $price, category: $category, size: $size, image: $image, description: $description, stock: $stock}';
  }
}

class Variant {
  final String sku;
  final String color;
  final String size;
  final int price;
  final int stock;
  final List<String> images;
  final Discount? discount;

  Variant({
    required this.sku,
    required this.color,
    required this.size,
    required this.price,
    required this.stock,
    required this.images,
    this.discount,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      sku: json["sku"] ?? '',
      color: json["color"] ?? '',
      size: json["size"] ?? '',
      price: json["price"] ?? 0,
      stock: json["stock"] ?? 0,
      images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
      discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );
  }

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

class Discount {
  final String type;
  final int value;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  Discount({
    required this.type,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      type: json["type"] ?? '',
      value: json["value"] ?? 0,
      startDate: DateTime.tryParse(json["startDate"] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      endDate: DateTime.tryParse(json["endDate"] ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0),
      isActive: json["isActive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isActive": isActive,
      };
}