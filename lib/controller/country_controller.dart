import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/country.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class CountryController extends GetxService {
  List<Country> countryOptions = [];
  var loaded = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadCountry();
  }

  Future loadCountry() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var contryRes = await ApiService.getAllCountry(sessionID: _sessionID);
        if (contryRes != null) {
          countryOptions = contryRes;
        }
      } finally {
        loaded(true);
        print('Country loaded now');
      }
    }
  }

  Future<List<Country>> getCountryOptions() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
    } else {
      try {
        loaded(false);
        var contryRes = await ApiService.getAllCountry(sessionID: _sessionID);
        if (contryRes != null) {
          countryOptions = contryRes;
        }
      } finally {
        loaded(true);
      }
    }
    return countryOptions;
  }
}
