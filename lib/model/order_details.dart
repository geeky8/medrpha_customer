// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

List<OrderDetails> orderDetailsFromJson(String str) => List<OrderDetails>.from(
    json.decode(str).map((x) => OrderDetails.fromJson(x)));

String orderDetailsToJson(List<OrderDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetails {
  OrderDetails({
    this.productImg,
    this.productName,
    this.categoryName,
    this.compnayName,
    this.saleqtytypestr,
    this.prodsaletypedetails,
    this.quantity,
    this.mrp,
    this.totalqtymrp,
    this.batchNumber,
    this.dtExpiryDate,
  });

  String productImg;
  String productName;
  String categoryName;
  String compnayName;
  String saleqtytypestr;
  String prodsaletypedetails;
  String quantity;
  String mrp;
  String totalqtymrp;
  String batchNumber;
  String dtExpiryDate;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        productImg: json["product_img"],
        productName: json["product_name"],
        categoryName: json["category_name"],
        compnayName: json["compnay_name"],
        saleqtytypestr: json["saleqtytypestr"],
        prodsaletypedetails: json["prodsaletypedetails"],
        quantity: json["quantity"],
        mrp: json["mrp"],
        totalqtymrp: json["totalqtymrp"],
        batchNumber: json["BatchNumber"],
        dtExpiryDate: json["dtExpiryDate"],
      );

  Map<String, dynamic> toJson() => {
        "product_img": productImg,
        "product_name": productName,
        "category_name": categoryName,
        "compnay_name": compnayName,
        "saleqtytypestr": saleqtytypestr,
        "prodsaletypedetails": prodsaletypedetails,
        "quantity": quantity,
        "mrp": mrp,
        "totalqtymrp": totalqtymrp,
        "BatchNumber": batchNumber,
        "dtExpiryDate": dtExpiryDate,
      };
}
