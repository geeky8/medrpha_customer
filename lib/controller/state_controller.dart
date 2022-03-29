import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/state.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class StateController extends GetxService {
  List<States> stateOptions = [];
  var loaded = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadState();
  }

  Future loadState() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var stateRes = await ApiService.getAllState(sessionID: _sessionID);
        if (stateRes != null) {
          stateOptions = stateRes;
        }
      } finally {
        loaded(true);
        stateOptions.insert(
            0, States(countid: 0, stateName: 'Select State', stateid: 0));
        print('State loaded now');
      }
    }
  }
}
