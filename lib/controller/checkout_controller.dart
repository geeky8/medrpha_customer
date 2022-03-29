import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';

class CheckoutController extends GetxController {
  var orderId = RxString('0');
  var loaded = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  checkoutCart({int checkOutType, double finalPrice}) async {
    List<Product> tempCart = [];
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      print('session present');
      try {
        loaded(false);
        finalPrice = (finalPrice * 100).round() / 100;
        var itemsResult = await ApiService.checkoutCartItems(
            sessionID: _sessionID,
            paymentMode: checkOutType,
            finalPrice: finalPrice);
        if (itemsResult != null) {
          if (itemsResult["status"] == "1") {
            orderId.value = itemsResult["order_id"];
            clearLocalCart();
            CommonFunctions().refreshOrders();
            Get.find<ProductController>().searchString.value = '';
          }
        }
      } finally {
        // getCatCount();
        loaded(true);
      }
    }
  }

  clearLocalCart() {
    final CartController cc = Get.find<CartController>();
    cc.finalPrice.value = 0.0;
    cc.myCart.value.clear();
    cc.cartCount.value = 0;
    print(
        'After clearing the cart  Final price:${cc.finalPrice.value}, Cart Count: ${cc.cartCount.value} ');
    print('& no of elements in cart: ${cc.myCart.length}');
    cc.fillCart();
    ProductController pc = Get.find<ProductController>();
    pc.getProductList();
  }
}
