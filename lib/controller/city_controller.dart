import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/city.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class CityController extends GetxService {
  List<City> cityOptions = [];
  var loaded = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadCity();
  }

  Future loadCity() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var cityRes = await ApiService.getAllCity(sessionID: _sessionID);
        if (cityRes != null) {
          cityOptions = cityRes;
        }
      } finally {
        loaded(true);
        cityOptions.insert(
            0, City(cityid: 0, cityName: 'Select City', statid: 0));
        print('City loaded now');
      }
    }
  }
}
