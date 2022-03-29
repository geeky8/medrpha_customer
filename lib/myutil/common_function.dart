import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/controller/cart_controller.dart';
import 'package:flutter_medical_ui/controller/customer_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/order_history_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/navigation_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../util/PrefData.dart';
import '../MySignUpPage.dart';

class CommonFunctions {
  Future<String> isSessionActive() async {
    String SessionId = await PrefData.getSessionID();
    if (SessionId == '' || SessionId == null) {
      return 'no';
    } else {
      return SessionId;
    }
  }

  Future<int> showPrice() async {
    bool registrationComplete = await PrefData.getRegCompleted();
    if (!registrationComplete) {
      return 1;
    } else {
      bool adminApproved = await PrefData.getAdminApproved();
      if (!adminApproved) {
        return 2;
      } else {
        return 3;
      }
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    try {
      Get.delete<ProductController>();
      Get.delete<CartController>();
      Get.delete<CustomerController>();
      Get.delete<LocalSessionController>();
      Get.delete<OrderHistoryController>();
    } finally {
      Navigator.pushReplacement(
          NavigationService.navigatorKey.currentContext,
          MaterialPageRoute(
            builder: (context) => MySignUpPage(),
          ));
    }
  }

  refreshOrders() {
    try {
      OrderHistoryController oc = Get.find<OrderHistoryController>();
      oc.loadOrderHistoryData();
    } catch (e) {
      OrderHistoryController ohC = Get.put(OrderHistoryController());
    }
  }
}
