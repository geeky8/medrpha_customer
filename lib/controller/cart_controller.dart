import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/model/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Cart myCart;
  var categoryCount = RxInt(0);
  var loaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    fillCart();
  }

  fillCart() async {
    Cart tempCart;
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      myCart = tempCart;
    } else {
      print('session present');
      try {
        loaded(false);
        var cats = await ApiService.getAllCategory(sessionID: _sessionID);
        if (cats != null) {
          // categoryList.assignAll(cats);
        }
      } finally {
        // getCatCount();
        loaded(true);
      }
    }
  }
}
