import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return MyProductList;
      } else {
        var dataArray = jsonData['data'];
        if (dataArray == null) {
          return MyProductList;
        } else {
          MyProductList = productFromJson(json.encode(dataArray));
        }
      }
    }
    products.value = MyProductList;
  }
}
