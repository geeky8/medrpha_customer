import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:get/get.dart';

import 'local_session_controller.dart';

class ProductController extends GetxController {
  String medicineName, categoryId;
  var products = <Product>[].obs;
  String _sessionID;
  var cartCount = RxInt(0);
  var loaded = false.obs;
  var showProduct = false.obs;
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
