// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

// Product productFromJson(String str) => Product.fromJson(json.decode(str));
//
// String productToJson(Product data) => json.encode(data.toJson());
List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  static const base_url = "https://partner.medrpha.com/product_image/";
  Product({
    this.pid,
    this.wpid,
    this.priceId,
    this.saleprice,
    this.productImg,
    this.productName,
    this.categorystr,
    this.compnaystr,
    this.newmrp,
    this.oldmrp,
    this.percent,
    this.saleqtytypestr,
    this.prodsaletypedetails,
    this.quantity,
    this.cartquantity,
    this.inCart,
  });

  String pid;
  String wpid;
  String priceId;
  String saleprice;
  String productImg;
  String productName;
  String categorystr;
  String compnaystr;
  String newmrp;
  String oldmrp;
  String percent;
  String saleqtytypestr;
  String prodsaletypedetails;
  String quantity;
  var cartquantity;
  var inCart;

  factory Product.fromJson(Map<String, dynamic> json) {
    // print('Cart Qty for ${json["product_name"]} is ${json["cartquantity"]}');
    var qty, incrt;
    if (json["cartquantity"] == null || json["cartquantity"] == '') {
      print(json["cartquantity"]);
      qty = RxString("0");
      incrt = RxBool(false);
    } else {
      qty = RxString(json["cartquantity"]);
      incrt = RxBool(true);
    }

    return Product(
      pid: json["pid"],
      wpid: json["wpid"],
      priceId: json["priceID"],
      saleprice: json["saleprice"],
      productImg: json["product_img"],
      productName: json["product_name"],
      categorystr: json["categorystr"],
      compnaystr: json["compnaystr"],
      newmrp: json["newmrp"],
      oldmrp: json["oldmrp"],
      percent: json["percent"],
      saleqtytypestr: json["saleqtytypestr"],
      prodsaletypedetails: json["prodsaletypedetails"],
      quantity: json["quantity"],
      cartquantity: qty,
      inCart: incrt,
    );
  }

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "wpid": wpid,
        "priceID": priceId,
        "saleprice": saleprice,
        "product_img": productImg,
        "product_name": productName,
        "categorystr": categorystr,
        "compnaystr": compnaystr,
        "newmrp": newmrp,
        "oldmrp": oldmrp,
        "percent": percent,
        "saleqtytypestr": saleqtytypestr,
        "prodsaletypedetails": prodsaletypedetails,
        "quantity": quantity,
        "cartquantity": cartquantity,
        "inCart": inCart,
      };
}
