import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class OrderHistoryController extends GetxController {
  var orderHistory;
  var loaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    print('init OrderHosttoey');
    await loadOrderHistoryData();
  }

  Future loadOrderHistoryData() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
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
}
