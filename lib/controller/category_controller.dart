import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:get/get.dart';

class CategoryController extends GetxService {
  var categoryList = <Category>[].obs;
  var categoryCount = RxInt(0);
  var loaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  getCatCount() {
    print('Before update : ${categoryCount}');
    categoryCount(categoryList.length);
    print(categoryCount);
  }

  Future getCategories() async {
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
        getCatCount();
        loaded(true);
      }
    }
  }

  void highlightCategory(int catid) {
    print("Category to heighlight: " + catid.toString());
    categoryList.forEach((category) {
      if (category.catid == catid) {
        category.highlighted.value = true;
      } else {
        category.highlighted.value = false;
      }
    });
  }

  void clearHighlight() {
    categoryList.forEach((category) {
      category.highlighted.value = false;
    });
  }
}
