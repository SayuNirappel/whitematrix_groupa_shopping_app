// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  bool? success;
  int? count;
  List<Ad>? ads;

  BannerModel({
    this.success,
    this.count,
    this.ads,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        success: json["success"],
        count: json["count"],
        ads: json["ads"] == null
            ? []
            : List<Ad>.from(json["ads"]!.map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "ads":
            ads == null ? [] : List<dynamic>.from(ads!.map((x) => x.toJson())),
      };
}

class Ad {
  String? id;
  String? title;
  String? image;
  bool? isActive;
  DateTime? expiresAt;
  DateTime? createdAt;
  int? v;
  String? link;

  Ad({
    this.id,
    this.title,
    this.image,
    this.isActive,
    this.expiresAt,
    this.createdAt,
    this.v,
    this.link,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        isActive: json["isActive"],
        expiresAt: json["expiresAt"] == null
            ? null
            : DateTime.parse(json["expiresAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "image": image,
        "isActive": isActive,
        "expiresAt": expiresAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "link": link,
      };
}
