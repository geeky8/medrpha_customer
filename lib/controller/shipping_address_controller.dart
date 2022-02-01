import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class ShippingAddressController extends GetxController {
  var shippingAddress;
  var loaded = false.obs;
  var dataSaved = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadShippingAddress();
  }

  Future loadShippingAddress() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var customerRes =
            await ApiService.getShippingAddressData(sessionID: _sessionID);
        if (customerRes != null) {
          shippingAddress = customerRes.obs;
        }
      } finally {
        loaded(true);
        print('Customer Address data loaded');
      }
    }
  }
}
