import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class OrderDetailsController extends GetxController {
  var orderDetails, order_datetime, order_no, order_amount, payment_status;
  var loaded = false.obs;
  // OrderDetailsController({
  //
  //   print('constructed orderdetailscontroller');
  //
  // }

  String orderId;
  @override
  void onInit() async {
    super.onInit();
    // print('init Order Details with order ID : ${orderId}');
    // await loadOrderDetailsData();
  }

  Future loadOrderDetailsData(orderId) async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      print('calling get order details data');
      try {
        loaded(false);
        var orderRes = await ApiService.getOrderDetailsData(
            sessionID: _sessionID, orderId: orderId);
        print(orderRes);

        if (orderRes["status"] == "1") {
          String ps = orderRes["payment_status"];
          order_datetime = orderRes["order_datetime"];
          order_no = orderRes["order_no"];
          order_amount = orderRes["order_amount"];
          orderDetails = orderRes["orders"];
          print("Order status as received " + orderRes["payment_status"]);
          payment_status = ps.obs;
        } else {
          order_amount = "0";
        }
      } finally {
        loaded(true);
        print('Order details data loaded');
      }
    }
  }
}
