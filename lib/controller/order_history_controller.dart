import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class OrderHistoryController extends GetxController {
  var orderHistory;
  var loaded = false.obs;
  var filter = false.obs;
  String startDate, endDate;

  @override
  void onInit() async {
    super.onInit();
    print('init OrderHosttoey');
    await loadOrderHistoryData();
  }

  Future loadOrderHistoryData() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    print('for ${_sessionID}');
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var orderRes =
            await ApiService.getOrderHistoryData(sessionID: _sessionID);
        print(orderRes);
        if (orderRes != null) {
          orderHistory = orderRes.obs;
        }
      } finally {
        loaded(true);
        print('OrderHistory data loaded');
      }
    }
  }

  Future filterOrderHistoryData({String StartDate, String EndDate}) async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    startDate = StartDate;
    endDate = EndDate;
    String _sessionID = ls.getSessionValue();
    filter = true.obs;
    print('for ${_sessionID}');
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var orderRes = await ApiService.getOrderHistoryData(
            sessionID: _sessionID, startDate: StartDate, endDate: EndDate);
        print(orderRes);
        if (orderRes != null) {
          orderHistory = orderRes.obs;
        }
      } finally {
        loaded(true);
        print('OrderHistory data loaded');
      }
    }
  }

  void updatePaymentStatus({String orderNo}) {
    int noOfOrders = orderHistory.value.length;
    orderHistory.value.forEach((order) {
      if (order.orderNo == orderNo) {
        print("Matching Order id.. AND UPDATING " + order.orderId);
        order.paymentStatus.value = "2";
      } else {
        print("Not an matching Order id " + order.orderId);
      }
    });
  }
}
