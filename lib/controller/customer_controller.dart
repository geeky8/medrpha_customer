import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class CustomerController extends GetxService {
  var customer;
  var loaded = false.obs;
  var dataSaved = true.obs;
  var gstSaved = true.obs;
  var fssaiSaved = true.obs;
  var dlSaved = true.obs;
  bool get gstUpdated => customer.value.gstnoyesno == "1" ? false : true;
  set gstUpdated(bool val) => val == true
      ? customer.value.gstnoyesno = "2"
      : customer.value.gstnoyesno = "1";

  bool get fssaiUpdated => customer.value.hdnFssai == "1" ? false : true;
  set fssaiUpdated(bool val) => val == true
      ? customer.value.hdnFssai = "2"
      : customer.value.hdnFssai = "1";

  bool get dlUpdated => customer.value.hdnDrugsyesno == "1" ? false : true;
  set dlUpdated(bool val) => val == true
      ? customer.value.hdnDrugsyesno = "2"
      : customer.value.hdnDrugsyesno = "1";

  @override
  void onInit() async {
    super.onInit();
    await loadCustomerData();
  }

  Future loadCustomerData() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var customerRes =
            await ApiService.getCustomerData(sessionID: _sessionID);
        if (customerRes != null) {
          customer = customerRes.obs;
        }
      } finally {
        loaded(true);
        print('Customer data loaded');
      }
    }
  }
}
