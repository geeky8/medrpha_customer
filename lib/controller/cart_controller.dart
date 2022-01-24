import 'dart:convert';

import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/model/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var myCart = <Cart>[].obs;
  var cartCount = RxInt(0);
  var finalPrice = RxDouble(0.0);
  var loaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    fillCart();
  }

  fillCart() async {
    List<Cart> tempCart = [];
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      myCart.value = tempCart;
    } else {
      print('session present');
      try {
        loaded(false);
        var itemsResult = await ApiService.getCartItems(sessionID: _sessionID);
        if (itemsResult != null) {
          // categoryList.assignAll(cats);
          // if(itemsResult)
          if (itemsResult["status"] == "1") {
            cartCount.value = int.parse(itemsResult["cartCount"]);
            myCart
                .assignAll(cartFromJson(json.encode(itemsResult["cartItems"])));
            finalPrice.value = double.parse(itemsResult["finalPrice"]);
          }
        }
      } finally {
        // getCatCount();
        loaded(true);
      }
    }
  }
}
