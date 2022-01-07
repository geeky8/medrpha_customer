import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<int> addNewItem(
      {@required Product product, @required String session}) async {
    print(
        'The product to add is ${product.productName} for session ${session}');
    Map requestBody = {
      "sessid": session,
      "pid": product.pid,
      "priceID": product.priceId,
      "WPID": product.wpid,
      "saleprice": product.saleprice,
    };
    var url = Uri.parse('https://api.medrpha.com/api/cart/addtocart');
    var response = await client.post(url, body: requestBody);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0") {
        //The session id is incorrect
        return 0;
      } else {
        if (jsonData['status'] == "1") {
          //product successfully added
          return 1;
        } else {
          return int.parse(jsonData['quantity']);
        }
      }
    } else {
      return 0;
    }
  }

  static Future<int> plusItem(
      {@required Product product, @required String session}) async {
    print(
        'The product to plus is ${product.productName} for session ${session}');
    Map requestBody = {
      "sessid": session,
      "pid": product.pid,
      "priceID": product.priceId,
      "quantity": product.quantity,
    };
    var url = Uri.parse('https://api.medrpha.com/api/cart/cartplus');
    var response = await client.post(url, body: requestBody);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0") {
        //The session id is incorrect
        return 0;
      } else {
        if (jsonData['status'] == "1") {
          //product successfully added
          return 1;
        } else {
          return int.parse(jsonData['quantity']);
        }
      }
    } else {
      return 0;
    }
  }

  static Future<int> minusItem(
      {@required Product product, @required String session}) async {
    print(
        'The product to minus is ${product.productName} for session ${session}');
    Map requestBody = {
      "sessid": session,
      "pid": product.pid,
      "priceID": product.priceId,
    };
    var url = Uri.parse('https://api.medrpha.com/api/cart/cartminus');
    var response = await client.post(url, body: requestBody);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0") {
        //The session id is incorrect
        return 0;
      } else {
        if (jsonData['status'] == "1") {
          //product successfully added
          return 1;
        } else {
          return int.parse(jsonData['quantity']);
        }
      }
    } else {
      return 0;
    }
  }

  static Future<int> deleteItem(
      {@required Product product, @required String session}) async {
    print(
        'The product to delete is ${product.productName} for session ${session}');
    Map requestBody = {
      "sessid": session,
      "pid": product.pid,
      "priceID": product.priceId,
    };
    var url = Uri.parse('https://api.medrpha.com/api/cart/deletecart');
    var response = await client.post(url, body: requestBody);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0") {
        //The session id is incorrect
        return 0;
      } else {
        if (jsonData['status'] == "1") {
          //product successfully added
          return 1;
        } else {
          return int.parse(jsonData['quantity']);
        }
      }
    } else {
      return 0;
    }
  }

  static Future<List<Category>> getAllCategory({String sessionID}) async {
    List<Category> tempCategory = [];
    var url = Uri.parse('https://api.medrpha.com/api/product/getcategory');
    Map jsonBody = {
      "sessid": sessionID,
    };
    // print('Now calling getCAt with ${jsonBody}');
    var response = await client.post(url, body: jsonBody);
    // print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempCategory;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempCategory
            : categoryFromJson(json.encode(dataArray));
      }
    } else {
      return tempCategory;
    }
  }

  //Static function to load product
  static Future<List<Product>> getAllProduct(
      {String sessionID, catId = '', productName = ''}) async {
    List<Product> MyProductList = [];
    var url = Uri.parse('https://api.medrpha.com/api/product/productlist');
    Map jsonBody = {
      "sessid": sessionID,
      "term": productName,
      "catcheck": catId,
    };
    print('Now calling product post method with ${jsonBody}');
    var response = await client.post(url, body: jsonBody);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return MyProductList;
      } else {
        var dataArray = jsonData['data'];
        // print(dataArray);
        return dataArray == null
            ? MyProductList
            : productFromJson(json.encode(dataArray));
      }
    } else {
      return MyProductList;
    }
  }
}
