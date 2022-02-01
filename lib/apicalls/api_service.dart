import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/model/city.dart';
import 'package:flutter_medical_ui/model/country.dart';
import 'package:flutter_medical_ui/model/customer.dart';
import 'package:flutter_medical_ui/model/order_details.dart';
import 'package:flutter_medical_ui/model/order_history.dart';
import 'package:flutter_medical_ui/model/pin.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/model/shipping_address.dart';
import 'package:flutter_medical_ui/model/state.dart';
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
      "quantity": product.quantity.toString(),
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

  static Future<int> updateQuantityforItem(
      {@required Product product,
      @required String session,
      @required newQuantity}) async {
    print(
        'The product to Update is ${product.productName} for session ${session}');
    Map requestBody = {
      "sessid": session,
      "pid": product.pid,
      "priceID": product.priceId,
      "quantity": product.quantity.toString(),
      "qtyfield": newQuantity.toString()
    };
    var url = Uri.parse('https://api.medrpha.com/api/cart/updatequantity');
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

  static Future<List<Country>> getAllCountry({String sessionID}) async {
    List<Country> tempCountry = [];
    var url = Uri.parse('https://api.medrpha.com/api/register/getcountry');
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
        return tempCountry;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempCountry
            : countryFromJson(json.encode(dataArray));
      }
    } else {
      return tempCountry;
    }
  }

  static Future<List<States>> getAllState({String sessionID}) async {
    List<States> tempState = [];
    var url = Uri.parse('https://api.medrpha.com/api/register/getstateall');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempState;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempState
            : statesFromJson(json.encode(dataArray));
      }
    } else {
      return tempState;
    }
  }

  static Future<List<City>> getAllCity({String sessionID}) async {
    List<City> tempCity = [];
    var url = Uri.parse('https://api.medrpha.com/api/register/getcityall');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempCity;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempCity
            : cityFromJson(json.encode(dataArray));
      }
    } else {
      return tempCity;
    }
  }

  static Future<String> uploadImage(filepath, session_id,
      {imageType = 3}) async {
    //imageType
    // 1: dl 1
    // 2: dl 2
    // 3 : fssai
    String url;
    if (imageType == 3) {
      url = 'https://medrpha.com/api/register/registerfssaiimg';
    } else if (imageType == 1) {
      url = 'https://medrpha.com/api/register/registerdl1';
    } else {
      url = 'https://medrpha.com/api/register/registerdl2';
    }
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map jsonBody = {
      "sessid": session_id,
    };
    request.fields["sessid"] = session_id;
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }

  static Future<dynamic> getUserStatus({String sessionID}) async {
    var url = Uri.parse('https://api.medrpha.com/api/Default/userstatus');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return {'status': '0'};
      } else {
        var dataArray = jsonData['data'];
        bool _regComplete =
            dataArray["complete_reg_status"] == "True" ? true : false;
        bool adminstatus = dataArray["adminstatus"] == "True" ? true : false;
        return {
          'status': '1',
          'completed': _regComplete,
          'admin': adminstatus,
        };
      }
    } else {
      return {'status': '0'};
    }
  }

  static Future<List<Pin>> getAllPin({String sessionID}) async {
    List<Pin> tempPin = [];
    var url = Uri.parse('https://api.medrpha.com/api/register/getpincodeall');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempPin;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempPin
            : pinFromJson(json.encode(dataArray));
      }
    } else {
      return tempPin;
    }
  }

  static Future<dynamic> getCartItems({String sessionID}) async {
    var url = Uri.parse('https://api.medrpha.com/api/cart/viewcart');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return {"status": '0'};
      } else {
        String cartCount = jsonData['count'];
        String finalPrice = jsonData['final'];
        String finalPriceString = jsonData['total'];
        var cartArray = jsonData['data'];
        Map resData = {
          "status": "1",
          "cartCount": cartCount,
          "finalPrice": finalPrice,
          "finalPriceString": finalPriceString,
          "cartItems": cartArray
        };
        return resData;
      }
    } else {
      return {
        "status": '0',
        "code": response.statusCode,
      };
    }
  }

  static Future<dynamic> checkoutCartItems(
      {String sessionID, int paymentMode, double finalPrice}) async {
    var url = Uri.parse('https://api.medrpha.com/api/checkout/checkout');
    Map jsonBody = {
      "sessid": sessionID,
      "paymode": paymentMode.toString(),
      "final": finalPrice.toString(),
    };
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return {"status": '0'};
      } else {
        String order_id = jsonData['order_id'];
        Map resData = {
          "status": "1",
          "order_id": order_id,
        };
        return resData;
      }
    } else {
      return {
        "status": '0',
        "code": response.statusCode,
      };
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

  static Future<String> updateCustomer(
      {String sessionID, Customer customer}) async {
    var url = Uri.parse('https://api.medrpha.com/api/register/register');
    Map jsonBody = {
      "sessid": sessionID,
      "firm_name": customer.firmName,
      "txtemail": customer.txtemail,
      "countryid": customer.countryid,
      "stateid": customer.stateid,
      "phoneno": customer.phoneno,
      "cityid": customer.cityid,
      "Areaid": customer.areaid,
      "address": customer.address,
      "PersonName": customer.personName,
      "PersonNumber": customer.personNumber,
      "AlternateNumber": customer.alternateNumber
    };
    // print(jsonBody);
    var response = await client.post(url, body: jsonBody);
    // print(response);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      return "0";
    }
  }

  static Future<String> updateDL(
      {String sessionID, String dlno, String dlname, String validTill}) async {
    var url = Uri.parse('https://api.medrpha.com/api/register/registerdlno');
    Map jsonBody = {
      "sessid": sessionID,
      "txtdlno": dlno,
      "valid": validTill,
      "txtdlname": dlname,
    };
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      print(response);
      return "0";
    }
  }

  static Future<String> updateFSSAI({String sessionID, String fssaino}) async {
    var url = Uri.parse('https://api.medrpha.com/api/register/registerfssai');
    Map jsonBody = {"sessid": sessionID, "fssaiNo": fssaino};
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      print(response);
      return "0";
    }
  }

  static Future<String> updateGST({String sessionID, String gstno}) async {
    var url = Uri.parse('https://api.medrpha.com/api/register/registergstno');
    Map jsonBody = {"sessid": sessionID, "gstno": gstno};
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      return "0";
    }
  }

  static Future<String> deleteGST({String sessionID}) async {
    var url =
        Uri.parse('https://api.medrpha.com/api/register/registergstnodelete');
    Map jsonBody = {
      "sessid": sessionID,
    };
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      return "0";
    }
  }

  static Future<String> deleteFSSAI({String sessionID}) async {
    var url =
        Uri.parse('https://api.medrpha.com/api/register/registerfssaidelete');
    Map jsonBody = {
      "sessid": sessionID,
    };
    print(jsonBody);
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return "0";
      } else {
        String status = jsonData['status'];
        return status;
      }
    } else {
      return "0";
    }
  }

  static Future<Customer> getCustomerData({String sessionID}) async {
    Customer tempCustomer;
    var url = Uri.parse('https://api.medrpha.com/api/profile/getprofile');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempCustomer;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempCustomer
            : customerFromJson(json.encode(dataArray));
      }
    } else {
      return tempCustomer;
    }
  }

  static Future<ShippingAddress> getShippingAddressData(
      {String sessionID}) async {
    ShippingAddress tempCustomer;
    var url = Uri.parse('https://api.medrpha.com/api/order/shippingaddress');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);
    print(jsonBody);
    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempCustomer;
      } else {
        var dataArray = jsonData['data'];
        print(dataArray);
        return dataArray == null
            ? tempCustomer
            : shippingAddressFromJson(json.encode(dataArray));
      }
    } else {
      return tempCustomer;
    }
  }

  static Future<List<OrderHistory>> getOrderHistoryData(
      {String sessionID}) async {
    List<OrderHistory> tempOrderHistory = [];
    var url = Uri.parse('https://api.medrpha.com/api/order/orderlist');
    Map jsonBody = {
      "sessid": sessionID,
    };
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return tempOrderHistory;
      } else {
        var dataArray = jsonData['data'];
        return dataArray == null
            ? tempOrderHistory
            : orderHistoryFromJson(json.encode(dataArray));
      }
    } else {
      return tempOrderHistory;
    }
  }

  static Future<dynamic> getOrderDetailsData(
      {String sessionID, String orderId}) async {
    List<OrderDetails> tempOrderDetails = [];
    var url = Uri.parse('https://api.medrpha.com/api/order/orderdetail');
    Map jsonBody = {"sessid": sessionID, "order_id": orderId};
    var response = await client.post(url, body: jsonBody);

    if (response.statusCode == 200) {
      var jsonObj = response.body;
      var jsonData = json.decode(jsonObj.toString());
      // print(jsonData);
      if (jsonData['status'] == "0" || jsonData['status'] == null) {
        return {"status": "0"};
      } else {
        var dataArray = jsonData['data'];
        if (dataArray == null) {
          return {"status": "0"};
        } else {
          tempOrderDetails = orderDetailsFromJson(json.encode(dataArray));
          return {
            "status": "1",
            "order_datetime": jsonData['order_datetime'],
            "order_no": jsonData['order_no'],
            "order_amount": jsonData['order_amount'],
            "orders": tempOrderDetails,
          };
        }
      }
    } else {
      return {"status": "0"};
    }
  }
}
