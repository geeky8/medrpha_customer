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
  // TODO: change product image path
  static const base_url = "https://partnertest.medrpha.com/product_image/";
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
    this.subtotal,
  });

  String pid;
  String wpid;
  String priceId;
  String saleprice;
  String productImg;
  String productName;
  String categorystr;
  String compnaystr;
  String saleqtytypestr;
  String prodsaletypedetails;
  int quantity;
  double newmrp;
  double oldmrp;
  String percent;
  var subtotal;
  var cartquantity;
  var inCart;

  factory Product.fromJson(Map<String, dynamic> json) {
    // print('Cart Qty for ${json["product_name"]} is ${json["cartquantity"]}');
    var qty, incrt, s_total;

    qty = int.tryParse(json["cartquantity"]) == null
        ? RxInt(0)
        : RxInt(int.parse(json["cartquantity"]));
    s_total = json["subtotal"] == null
        ? RxDouble(0.00)
        : RxDouble(double.parse(json["subtotal"]));
    if (json["cartquantity"] == null || json["cartquantity"] == '') {
      incrt = RxBool(false);
    } else {
      incrt = RxBool(true);
    }
    print('Product sub total : ${s_total}');
    return Product(
      pid: json["pid"],
      wpid: json["wpid"],
      priceId: json["priceID"],
      saleprice: json["saleprice"],
      productImg: json["product_img"],
      productName: json["product_name"],
      categorystr: json["categorystr"],
      compnaystr: json["compnaystr"],
      newmrp: double.tryParse(json["newmrp"]) == null
          ? 0.0
          : double.parse(json["newmrp"]),
      oldmrp: double.tryParse(json["oldmrp"]) == null
          ? 0.0
          : double.parse(json["oldmrp"]),
      percent: json["percent"],
      saleqtytypestr: json["saleqtytypestr"],
      prodsaletypedetails: json["prodsaletypedetails"],
      quantity: int.tryParse(json["quantity"]) == null
          ? 0
          : int.parse(json["quantity"]),
      cartquantity: qty,
      inCart: incrt,
      subtotal: s_total,
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
        "subtotal": subtotal,
      };
}
