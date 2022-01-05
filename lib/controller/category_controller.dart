import 'dart:convert';

import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  String _sessionID;
  var categoryCount = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    print('Value before call ${categoryList.length}');
    getCategories();
    updateCatCount();
    print('Value after call ${categoryList.length}');
  }

  updateCatCount() {
    categoryCount = RxInt(categoryList.length);
    update();
  }

  getCatCount() {
    categoryCount = RxInt(categoryList.length);
    print(categoryCount);
    update();
  }

  Future getCategories() async {
    CommonFunctions cf = CommonFunctions();
    List<Category> tempCategory = [];
    _sessionID = await cf.isSessionActive();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      categoryList = tempCategory;
    } else {
      print('session present');
      var url = Uri.parse('https://api.medrpha.com/api/product/getcategory');
      Map jsonBody = {
        "sessid": _sessionID,
      };
      print('Getting catagires');
      var response = await http.post(url, body: jsonBody);
      print('Response status: ${response.statusCode}');
      // print(jsonBody);
      // print(http.po);
      if (response.statusCode == 200) {
        var jsonObj = response.body;
        var jsonData = json.decode(jsonObj.toString());
        // print(jsonData);
        if (jsonData['status'] == "0" || jsonData['status'] == null) {
          return tempCategory;
        } else {
          var dataArray = jsonData['data'];
          if (dataArray == null) {
            return tempCategory;
          } else {
            print(dataArray);
            tempCategory = categoryFromJson(json.encode(dataArray));
            categoryList.value = tempCategory;
            print('creating cat list of length ${tempCategory.length}');
          }
        }
      }
    }
  }
}
