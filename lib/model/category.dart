// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

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
    this.highlighted,
  });
  int ii;
  int catid;
  String categoryName;
  String imagedata;
  var highlighted;

  factory Category.fromJson(Map<String, dynamic> json) {
    // print(json["catid"]);
    // print(json["category_name"]);
    return Category(
      catid: json["catid"],
      categoryName: json["category_name"],
      imagedata: json["imagedata"],
      highlighted: false.obs,
    );
  }
  Map<String, dynamic> toJson() => {
        "catid": catid,
        "category_name": categoryName,
        "imagedata": imagedata,
      };
}
