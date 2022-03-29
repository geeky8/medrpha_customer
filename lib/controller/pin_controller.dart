import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/pin.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class PinController extends GetxService {
  List<Pin> pinOptions = [];
  var loaded = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadPin();
  }

  Future loadPin() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var pinRes = await ApiService.getAllPin(sessionID: _sessionID);
        if (pinRes != null) {
          pinOptions = pinRes;
        }
      } finally {
        loaded(true);
        pinOptions.insert(
            0, Pin(areaid: 0, areaName: 'Select State', cityid: 0));
        print('Pin loaded now');
      }
    }
  }
}
