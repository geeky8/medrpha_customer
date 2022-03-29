import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class ProductDetailsController extends GetxController {
  var productDetails;
  var loaded = false.obs;
  var dataSaved = true.obs;
  @override
  ProductDetailsController({this.p_id, this.price_id});
  String p_id, price_id;

  @override
  void onInit() async {
    super.onInit();
    print('The val ${price_id} & ${p_id}');
    await loadProductDetails();
  }

  Future loadProductDetails() async {
    print('Calling load data with value ${price_id} & ${p_id}');
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var productRes = await ApiService.getProductDetails(
            sessionID: _sessionID, p_id: p_id, price_id: price_id);
        if (productRes != null) {
          productDetails = productRes.obs;
        }
      } finally {
        loaded(true);
        print('Product Details data loaded');
      }
    }
  }
}
