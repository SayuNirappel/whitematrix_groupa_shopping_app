// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  User? user;
  String? token;

  UserModel({
    this.user,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  Cart? cart;
  String? id;
  String? email;
  List<dynamic>? wishlist;
  bool? isAdmin;
  List<dynamic>? addresses;
  List<dynamic>? orders;
  DateTime? createdAt;
  int? v;

  User({
    this.cart,
    this.id,
    this.email,
    this.wishlist,
    this.isAdmin,
    this.addresses,
    this.orders,
    this.createdAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
        id: json["_id"],
        email: json["email"],
        wishlist: json["wishlist"] == null
            ? []
            : List<dynamic>.from(json["wishlist"]!.map((x) => x)),
        isAdmin: json["isAdmin"],
        addresses: json["addresses"] == null
            ? []
            : List<dynamic>.from(json["addresses"]!.map((x) => x)),
        orders: json["orders"] == null
            ? []
            : List<dynamic>.from(json["orders"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "cart": cart?.toJson(),
        "_id": id,
        "email": email,
        "wishlist":
            wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x)),
        "isAdmin": isAdmin,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x)),
        "orders":
            orders == null ? [] : List<dynamic>.from(orders!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Cart {
  int? subtotal;
  int? discount;
  int? cartTotal;
  List<dynamic>? items;

  Cart({
    this.subtotal,
    this.discount,
    this.cartTotal,
    this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        subtotal: json["subtotal"],
        discount: json["discount"],
        cartTotal: json["cartTotal"],
        items: json["items"] == null
            ? []
            : List<dynamic>.from(json["items"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "discount": discount,
        "cartTotal": cartTotal,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
      };
}
