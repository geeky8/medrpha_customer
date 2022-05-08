import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Product {
  static const base_url = "https://partner.medrpha.com/product_image/";
  // static const base_url = 'https://partnertest.medrpha.com/product_image/';
  String product_img,
      product_name,
      categorystr,
      compnaystr,
      newmrp,
      oldmrp,
      percent,
      saleqtytypestr,
      prodsaletypedetails,
      quantity,
      pid,
      wpid,
      priceID,
      saleprice,
      cartquantity;
  Product(
      this.product_img,
      this.product_name,
      this.categorystr,
      this.compnaystr,
      this.newmrp,
      this.oldmrp,
      this.percent,
      this.saleqtytypestr,
      this.prodsaletypedetails,
      this.quantity,
      this.pid,
      this.wpid,
      this.priceID,
      this.saleprice,
      this.cartquantity);
}

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProductList(session: '91c65d5706f2ab8b', productName: '');
  }

  Future getProductList(
      {@required session, productName = '', categoryId = ''}) async {
    List<Product> MyProductList = [];
    print('In get product');
    var url = Uri.parse('https://api.medrpha.com/api/product/productlist');
    Map jsonBody = {
      "sessid": session,
      "term": productName,
      "catcheck": categoryId,
    };
    print('Now calling post method');
    var response = await http.post(url, body: jsonBody);
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    print('fetch response. produt name $productName for cat $categoryId ');
    print(jsonBody);
    // print(http.po);
    if (response.statusCode.toString() == "200" || response.statusCode == 200) {
      print('Status 200');
      var jsonData = json.decode(response.body.toString());
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return MyProductList;
      } else {
        var dataArray = jsonData['data'];
        if (dataArray == null) {
          return MyProductList;
        } else {
          for (var data in dataArray) {
            MyProductList.add(
              Product(
                data["product_img"],
                data['product_name'],
                data['categorystr'],
                data['compnaystr'],
                data['newmrp'],
                data['oldmrp'],
                data['percent'],
                data['saleqtytypestr'],
                data['prodsaletypedetails'],
                data['quantity'],
                data['pid'],
                data['wpid'],
                data['priceID'],
                data['saleprice'],
                data['cartquantity'].length < 1 ? '0' : data['cartquantity'],
              ),
            );
          }
        }
      }
    }
    products.value = MyProductList;
  }
}
