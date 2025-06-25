// To parse this JSON data, do
//
//     final productsResModel = productsResModelFromJson(jsonString);

import 'dart:convert';

List<ProductsResModel> productsResModelFromJson(String str) => List<ProductsResModel>.from(json.decode(str).map((x) => ProductsResModel.fromJson(x)));

String productsResModelToJson(List<ProductsResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsResModel {
    String? id;
    String? title;
    String? brand;
    int? price;
    String? category;
    List<String>? size;
    String? image;
    String? description;
    int? stock;
    String? createdBy;
    DateTime? createdAt;
    int? v;
    List<Variant>? variants;
    Discount? discount;

    ProductsResModel({
        this.id,
        this.title,
        this.brand,
        this.price,
        this.category,
        this.size,
        this.image,
        this.description,
        this.stock,
        this.createdBy,
        this.createdAt,
        this.v,
        this.variants,
        this.discount,
    });

    factory ProductsResModel.fromJson(Map<String, dynamic> json) => ProductsResModel(
        id: json["_id"],
        title: json["title"],
        brand: json["brand"],
        price: json["price"],
        category: json["category"],
        size: json["size"] == null ? [] : List<String>.from(json["size"]!.map((x) => x)),
        image: json["image"],
        description: json["description"],
        stock: json["stock"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "brand": brand,
        "price": price,
        "category": category,
        "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x)),
        "image": image,
        "description": description,
        "stock": stock,
        "createdBy": createdBy,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "discount": discount?.toJson(),
    };
}

class Discount {
    Type? type;
    int? value;
    DateTime? startDate;
    DateTime? endDate;
    bool? isActive;

    Discount({
        this.type,
        this.value,
        this.startDate,
        this.endDate,
        this.isActive,
    });

    factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        type: typeValues.map[json["type"]]!,
        value: json["value"],
        startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "value": value,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "isActive": isActive,
    };
}

enum Type {
    FLAT,
    PERCENTAGE
}

final typeValues = EnumValues({
    "flat": Type.FLAT,
    "percentage": Type.PERCENTAGE
});

class Variant {
    String? sku;
    String? color;
    String? size;
    int? price;
    int? stock;
    List<String>? images;
    Discount? discount;

    Variant({
        this.sku,
        this.color,
        this.size,
        this.price,
        this.stock,
        this.images,
        this.discount,
    });

    factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        sku: json["sku"],
        color: json["color"],
        size: json["size"],
        price: json["price"],
        stock: json["stock"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );

    Map<String, dynamic> toJson() => {
        "sku": sku,
        "color": color,
        "size": size,
        "price": price,
        "stock": stock,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
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
