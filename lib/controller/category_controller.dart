import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  String _sessionID;
  var categoryCount = RxInt(0);
  var loaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    updateCatCount();
  }

  updateCatCount() {
    categoryCount(categoryList.length);
  }

  getCatCount() {
    categoryCount = RxInt(categoryList.length);
    print(categoryCount);
    update();
  }

  Future getCategories() async {
    CommonFunctions cf = CommonFunctions();
    List<Category> tempCategory = [];
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      categoryList = tempCategory;
    } else {
      print('session present');
      try {
        loaded(false);
        var cats = await ApiService.getAllCategory(sessionID: _sessionID);
        if (cats != null) {
          categoryList.assignAll(cats);
        }
      } finally {
        loaded(true);
      }
    }
  }
}
