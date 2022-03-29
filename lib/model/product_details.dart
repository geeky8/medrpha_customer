// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    this.productName,
    this.productImg,
    this.description,
    this.categorystr,
    this.compnaystr,
    this.saleqtytypestr,
    this.dtExpiryDate,
    this.prodsaletypedetails,
  });

  String productName;
  String productImg;
  String description;
  String categorystr;
  String compnaystr;
  String saleqtytypestr;
  String dtExpiryDate;
  String prodsaletypedetails;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productName: json["product_name"],
        productImg: json["product_img"],
        description: json["Description"],
        categorystr: json["categorystr"],
        compnaystr: json["compnaystr"],
        saleqtytypestr: json["saleqtytypestr"],
        dtExpiryDate: json["dtExpiryDate"],
        prodsaletypedetails: json["prodsaletypedetails"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_img": productImg,
        "Description": description,
        "categorystr": categorystr,
        "compnaystr": compnaystr,
        "saleqtytypestr": saleqtytypestr,
        "dtExpiryDate": dtExpiryDate,
        "prodsaletypedetails": prodsaletypedetails,
      };
}
