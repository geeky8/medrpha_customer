import 'package:flutter_medical_ui/controller/pin_controller.dart';
import 'package:flutter_medical_ui/controller/state_controller.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:get/get.dart';

import 'city_controller.dart';
import 'country_controller.dart';

class LocalSessionController extends GetxService {
  var mySession;
  int test = 11;
  static String medDefault = 'medrpha_';
  static String sessionID = medDefault + "sessionId";
  static String mobileNo = medDefault + "mobileNo";
  static String regCompleted = medDefault + "regCompleted";
  static String adminApproved = medDefault + "adminApproved";
  static String pin = medDefault + "pin";

  @override
  Future onInit() async {
    super.onInit();
    print('getting session now');
    await getSessionData();
    print(
        'Init called from Local session controller, and init has been called adter getting the pref data');
  }

  Future<void> getSessionData() async {
    print('Getting pref data from disk');

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String session = prefs.getString(sessionID);
    // String mobile = prefs.getString(mobileNo) ?? '';
    // String newpin = prefs.getString(pin) ?? '';
    // bool regC = prefs.getBool(regCompleted) ?? false;
    // bool adminapp = prefs.getBool(adminApproved) ?? false;
    //
    // print('Local data received');
    // mySession = LocalSession(session, mobile, regC, adminapp, newpin);
    mySession = await PrefData.getAllLocalData();
    print('Starting getx service for country');
    Get.put<CountryController>(CountryController(), permanent: true);
    Get.put<StateController>(StateController(), permanent: true);
    Get.put<CityController>(CityController(), permanent: true);
    Get.put<PinController>(PinController(), permanent: true);
  }

  String getSessionValue() {
    return mySession.session;
  }

  bool getProfileCompletionStatus() {
    return mySession.regCompleted;
  }

  bool getAdminAprovalStatus() {
    return mySession.adminApproved;
  }
}
