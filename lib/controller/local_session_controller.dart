import 'package:flutter_medical_ui/controller/category_controller.dart';
import 'package:flutter_medical_ui/controller/pin_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/controller/state_controller.dart';
import 'package:flutter_medical_ui/model/local_session.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';
import 'city_controller.dart';
import 'country_controller.dart';
import 'customer_controller.dart';

class LocalSessionController extends GetxController {
  LocalSession mySession;
  int test = 11;
  static String medDefault = 'medrpha_';
  static String sessionID = medDefault + "sessionId";
  static String mobileNo = medDefault + "mobileNo";
  static String regCompleted = medDefault + "regCompleted";
  static String adminApproved = medDefault + "adminApproved";
  static String pin = medDefault + "pin";

  LocalSessionController() {
    print('In constructor of local session data');
  }

  @override
  Future onInit() async {
    super.onInit();
    print('LocalsessionController init: getting session now ');
    await getSessionData();
    print(
        'Init called from Local session controller, and init has been called after getting the pref data');
  }

  Future<void> getSessionData() async {
    print('Getting pref data from disk');
    Get.delete<ProductController>();
    Get.delete<CustomerController>();
    Get.delete<CartController>();
    mySession = await PrefData.getAllLocalData();

    try {
      print(
          'Starting getx service for country for session id : ${mySession.session}');
      Get.put<CountryController>(CountryController());
      Get.put<StateController>(StateController());
      Get.put<CityController>(CityController());
      Get.put<PinController>(PinController());
      Get.put<CustomerController>(CustomerController());
    } finally {
      Get.put<CountryController>(CountryController());
      Get.put<StateController>(StateController());
      Get.put<CityController>(CityController());
      Get.put<PinController>(PinController());
      Get.put<ProductController>(ProductController());
      Get.put<CustomerController>(CustomerController());
      Get.put<CartController>(CartController());
      Get.put(CategoryController());
    }
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

  String getPhoneNumber() {
    return mySession.mobileNo;
  }
}
