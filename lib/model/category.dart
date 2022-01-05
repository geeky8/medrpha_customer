// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  final String base_url = "https://superadmin.medrpha.com/allimage/";
  Category({
    this.catid,
    this.categoryName,
    this.imagedata,
  });
  int ii;
  int catid;
  String categoryName;
  String imagedata;

  factory Category.fromJson(Map<String, dynamic> json) {
    print(json["catid"]);
    print(json["category_name"]);
    return Category(
      catid: json["catid"],
      categoryName: json["category_name"],
      imagedata: json["imagedata"],
    );
  }
  Map<String, dynamic> toJson() => {
        "catid": catid,
        "category_name": categoryName,
        "imagedata": imagedata,
      };
}
