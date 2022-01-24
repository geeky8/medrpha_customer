// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    this.pid,
    this.productName,
    this.categorystr,
    this.compnaystr,
    this.saleqtytypestr,
    this.prodsaletypedetails,
    this.quantity,
    this.mrp,
    this.mrpold,
    this.priceId,
    this.quantityStock,
    this.subtotal,
  });

  String pid;
  String productName;
  String categorystr;
  String compnaystr;
  String saleqtytypestr;
  String prodsaletypedetails;
  String quantity;
  String mrp;
  String mrpold;
  String priceId;
  String quantityStock;
  String subtotal;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        pid: json["pid"],
        productName: json["product_name"],
        categorystr: json["categorystr"],
        compnaystr: json["compnaystr"],
        saleqtytypestr: json["saleqtytypestr"],
        prodsaletypedetails: json["prodsaletypedetails"],
        quantity: json["quantity"],
        mrp: json["mrp"],
        mrpold: json["mrpold"],
        priceId: json["priceID"],
        quantityStock: json["quantity_stock"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "product_name": productName,
        "categorystr": categorystr,
        "compnaystr": compnaystr,
        "saleqtytypestr": saleqtytypestr,
        "prodsaletypedetails": prodsaletypedetails,
        "quantity": quantity,
        "mrp": mrp,
        "mrpold": mrpold,
        "priceID": priceId,
        "quantity_stock": quantityStock,
        "subtotal": subtotal,
      };
}
