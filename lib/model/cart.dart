// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.status,
    this.message,
    this.count,
    this.cartFinal,
    this.total,
    this.data,
  });

  String status;
  String message;
  String count;
  String cartFinal;
  String total;
  List<Datum> data;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        cartFinal: json["final"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "final": cartFinal,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.pid,
    this.productName,
    this.categorystr,
    this.compnaystr,
    this.saleqtytypestr,
    this.prodsaletypedetails,
    this.quantity,
    this.mrp,
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
  String subtotal;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pid: json["pid"],
        productName: json["product_name"],
        categorystr: json["categorystr"],
        compnaystr: json["compnaystr"],
        saleqtytypestr: json["saleqtytypestr"],
        prodsaletypedetails: json["prodsaletypedetails"],
        quantity: json["quantity"],
        mrp: json["mrp"],
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
        "subtotal": subtotal,
      };
}
