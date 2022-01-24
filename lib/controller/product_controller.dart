import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class ProductController extends GetxController {
  String medicineName, categoryId;
  var products = <Product>[].obs;
  String _sessionID;
  var cartCount = RxInt(0);
  var loaded = false.obs;
  var showProduct = false.obs;

  var adminApproved = false.obs;
  var regCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProductList();
  }

  addProduct() {
    print('productName ');
  }

  getProductByCat(int catd) {
    print('calling filter with cat id ${catd.toString()}');
    // filterProduct(session: _sessionID, categoryId: catd == 0 ? '' : catd.toString());
    getProductList(catcheck: catd == 0 ? '' : catd.toString());
  }

  updateCartCount() {
    cartCount++;
    print(cartCount);
  }

  getApprovedStatus() async {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    print('getting user status');
    try {
      var response = await ApiService.getUserStatus(sessionID: _sessionID);
      if (response["status"] == "1") {
        ls.mySession.adminApproved = response["admin"];
        ls.mySession.regCompleted = response["completed"];
      }
      print(
          'status function try statement. the value of admin approved : ${ls.mySession.adminApproved} and thevalue of reg completed ${ls.mySession.regCompleted}');
    } finally {
      adminApproved = RxBool(ls.getAdminAprovalStatus());
      regCompleted = RxBool(ls.getProfileCompletionStatus());
      showProduct =
          ls.getProfileCompletionStatus() && ls.getAdminAprovalStatus()
              ? RxBool(true)
              : RxBool(false);
      print('status function completed');
    }
  }

  hideProductPrice(bool hide) {
    showProduct(!hide);
    adminApproved(!hide);
    Get.find<LocalSessionController>().mySession.adminApproved = !hide;
    PrefData.setAdminApproved(!hide);
  }

  testToggleVisibility() {
    if (showProduct.value) {
      showProduct(false);
    } else {
      showProduct(true);
    }
  }

  void getProductList({catcheck = '', term = ''}) async {
    List<Product> MyProductList = [];
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      products.value = MyProductList;
    } else {
      try {
        loaded(false);
        var newProducts = await ApiService.getAllProduct(
            sessionID: _sessionID, catId: catcheck, productName: term);
        if (newProducts != null) {
          products.assignAll(newProducts);
        }
      } finally {
        print(
            'Trying to set product  admin approved to ${ls.getAdminAprovalStatus()}');
        adminApproved = RxBool(ls.getAdminAprovalStatus());
        regCompleted = RxBool(ls.getProfileCompletionStatus());
        showProduct =
            ls.getProfileCompletionStatus() && ls.getAdminAprovalStatus()
                ? RxBool(true)
                : RxBool(false);

        loaded.value = true;
      }
    }

    //products.value = MyProductList;
  }
}
