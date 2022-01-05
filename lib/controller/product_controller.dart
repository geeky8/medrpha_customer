import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  String medicineName, categoryId;
  var products = <Product>[].obs;
  String _sessionID;
  var cartCount = RxInt(0);
  var loaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    getProductList(session: '91c65d5706f2ab8b', productName: '');
  }

  addProduct() {
    print('productName ');
  }

  getProductByCat(int catd) {
    print('calling filter with cat id ${catd.toString()}');
    filterProduct(
        session: _sessionID, categoryId: catd == 0 ? '' : catd.toString());
  }

  updateCartCount() {
    cartCount++;
    filterProduct(session: '91c65d5706f2ab8b', productName: 'cipl');
    print(cartCount);
  }

  Future filterProduct(
      {@required session, productName = '', categoryId = '', term = ''}) async {
    List<Product> MyProductList = [];
    var url = Uri.parse('https://api.medrpha.com/api/product/productlist');
    Map jsonBody = {
      "sessid": session,
      "term": productName,
      "catcheck": categoryId,
    };
    print('Now calling post method with ${jsonBody}');
    var response = await http.post(url, body: jsonBody);
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    print(jsonBody);
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

  Future getProductList(
      {@required session, productName = '', categoryId = ''}) async {
    List<Product> MyProductList = [];
    CommonFunctions cf = CommonFunctions();
    _sessionID = await cf.isSessionActive();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      products.value = MyProductList;
    } else {
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
      if (response.statusCode.toString() == "200" ||
          response.statusCode == 200) {
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
    }

    products.value = MyProductList;
  }
}
