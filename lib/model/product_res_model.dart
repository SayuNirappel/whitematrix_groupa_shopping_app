// To parse this JSON data, do
//
//     final productsResModel = productsResModelFromJson(jsonString);

import 'dart:convert';

<<<<<<< HEAD
List<ProductsResModel> productsResModelFromJson(String str) => List<ProductsResModel>.from(json.decode(str).map((x) => ProductsResModel.fromJson(x)));

String productsResModelToJson(List<ProductsResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsResModel {
    Brand? brand;
    String? id;
    String? title;
    String? category;
    String? description;
    List<Variant>? variants;
    Discount? discount;
    String? createdBy;
    List<Review>? reviews;
    DateTime? createdAt;
    int? v;
    Gender? gender;

    ProductsResModel({
        this.brand,
        this.id,
        this.title,
        this.category,
        this.description,
        this.variants,
        this.discount,
        this.createdBy,
        this.reviews,
        this.createdAt,
        this.v,
        this.gender,
    });

    factory ProductsResModel.fromJson(Map<String, dynamic> json) => ProductsResModel(
=======
List<ProductsResModel> productsResModelFromJson(String str) =>
    List<ProductsResModel>.from(
        json.decode(str).map((x) => ProductsResModel.fromJson(x)));

String productsResModelToJson(List<ProductsResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsResModel {
  Brand? brand;
  String? id;
  String? title;
  String? category;
  String? description;
  List<Variant>? variants;
  Discount? discount;
  String? createdBy;
  List<Review>? reviews;
  DateTime? createdAt;
  int? v;
  Gender? gender;

  ProductsResModel({
    this.brand,
    this.id,
    this.title,
    this.category,
    this.description,
    this.variants,
    this.discount,
    this.createdBy,
    this.reviews,
    this.createdAt,
    this.v,
    this.gender,
  });

  factory ProductsResModel.fromJson(Map<String, dynamic> json) =>
      ProductsResModel(
>>>>>>> auth_with_token
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        id: json["_id"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
<<<<<<< HEAD
        variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"]!.map((x) => Variant.fromJson(x))),
        discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
        createdBy: json["createdBy"],
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        gender: genderValues.map[json["gender"]]!,
    );

    Map<String, dynamic> toJson() => {
=======
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        createdBy: json["createdBy"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        gender: genderValues.map[json["gender"]]!,
      );

  Map<String, dynamic> toJson() => {
>>>>>>> auth_with_token
        "brand": brand?.toJson(),
        "_id": id,
        "title": title,
        "category": category,
        "description": description,
<<<<<<< HEAD
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "discount": discount?.toJson(),
        "createdBy": createdBy,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "gender": genderValues.reverse[gender],
    };
}

class Brand {
    String? name;
    String? image;

    Brand({
        this.name,
        this.image,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
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
=======
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "discount": discount?.toJson(),
        "createdBy": createdBy,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "gender": genderValues.reverse[gender],
      };
}

class Brand {
  String? name;
  String? image;

  Brand({
    this.name,
    this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
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
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
>>>>>>> auth_with_token
        "type": typeValues.reverse[type],
        "value": value,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "isActive": isActive,
<<<<<<< HEAD
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

enum Gender {
    MEN,
    UNISEX
}

final genderValues = EnumValues({
    "Men": Gender.MEN,
    "unisex": Gender.UNISEX
});

class Review {
    String? user;
    int? rating;
    String? comment;
    DateTime? createdAt;

    Review({
        this.user,
        this.rating,
        this.comment,
        this.createdAt,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
=======
      };
}

enum Type { FLAT, PERCENTAGE }

final typeValues =
    EnumValues({"flat": Type.FLAT, "percentage": Type.PERCENTAGE});

enum Gender { MEN, UNISEX }

final genderValues = EnumValues({"Men": Gender.MEN, "unisex": Gender.UNISEX});

class Review {
  String? user;
  int? rating;
  String? comment;
  DateTime? createdAt;

  Review({
    this.user,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        user: json["user"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
>>>>>>> auth_with_token
        "user": user,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
<<<<<<< HEAD
    };
}

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
=======
      };
}

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
>>>>>>> auth_with_token
        sku: json["sku"],
        color: json["color"],
        size: json["size"],
        price: json["price"],
        stock: json["stock"],
<<<<<<< HEAD
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );

    Map<String, dynamic> toJson() => {
=======
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
>>>>>>> auth_with_token
        "sku": sku,
        "color": color,
        "size": size,
        "price": price,
        "stock": stock,
<<<<<<< HEAD
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
=======
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
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
>>>>>>> auth_with_token
}
