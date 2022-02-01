import 'dart:convert';

import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var myCart = <Product>[].obs;
  var cartCount = RxInt(0);
  var finalPrice = RxDouble(0.0);
  var loaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    fillCart();
  }

  fillCart() async {
    List<Product> tempCart = [];
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    if (_sessionID == 'no' || _sessionID == '') {
      print('session missing');
      myCart.value = tempCart;
    } else {
      print('session present');
      try {
        loaded(false);
        var itemsResult = await ApiService.getCartItems(sessionID: _sessionID);
        if (itemsResult != null) {
          // categoryList.assignAll(cats);
          // if(itemsResult)
          if (itemsResult["status"] == "1") {
            cartCount.value = int.parse(itemsResult["cartCount"]);
            myCart.assignAll(
                productFromJson(json.encode(itemsResult["cartItems"])));
            finalPrice.value = double.parse(itemsResult["finalPrice"]);
          }
        }
      } finally {
        // getCatCount();
        loaded(true);
      }
    }
  }

  double getTotalMRP() {
    double totalMRP = 0;
    return myCart.value.fold(
        totalMRP,
        (previousValue, element) =>
            previousValue + (element.cartquantity.value * element.oldmrp));
  }

  int incrementCartQuantity(String cartQty) {
    return int.tryParse(cartQty) == null ? 1 : int.parse(cartQty) + 1;
  }

  int decrementCartQuantity(String cartQty) {
    return int.tryParse(cartQty) == null ? 0 : int.parse(cartQty) - 1;
  }

  void updateFinalPrice(double price, String action,
      {bool allQty = false, int qty}) {
    if (action == "add") {
      finalPrice.value = finalPrice.value + price;
    } else if (action == "less") {
      if (allQty) {
        finalPrice.value = finalPrice.value - (price * qty);
      } else {
        finalPrice.value = finalPrice.value - price;
      }
    } else if (action == "update") {
      finalPrice.value = finalPrice.value + (price * qty);
    }
  }

  String getItemCount(Product searchProduct) {
    List<Product> products = myCart.value;
    Product match = products.firstWhere(
        (element) => element.pid == searchProduct.pid,
        orElse: () => Product());
    if (match.pid == null) {
      return "0";
    } else {
      return match.cartquantity.value.toString();
    }
  }

  int findIndexOfProduct(Product findProduct) {
    List<Product> products = myCart.value;
    int productIndex =
        products.indexWhere((product) => product.pid == findProduct.pid);
    return productIndex;
  }

  void incrementCount(Product findProduct) {
    int productIndex = findIndexOfProduct(findProduct);
    if (productIndex < 0) {
      //product not fount so add the product in the cart array
      findProduct.cartquantity.value = 1;
      findProduct.subtotal.value = findProduct.newmrp;
      myCart.value.add(findProduct);
      cartCount.value = cartCount.value + 1;
      finalPrice.value = finalPrice.value + findProduct.newmrp;
    } else {
      myCart.value[productIndex].cartquantity.value++;
      myCart.value[productIndex].subtotal.value =
          (myCart.value[productIndex].cartquantity.value *
              myCart.value[productIndex].newmrp);
      updateFinalPrice(myCart.value[productIndex].newmrp, "add");
    }
  }

  void updateCount(Product findProduct, int oldQty, int newQty) {
    int productIndex = findIndexOfProduct(findProduct);
    if (productIndex < 0) {
      //product not fount so nothing tdo do
    } else {
      myCart.value[productIndex].cartquantity.value = newQty;
      myCart.value[productIndex].subtotal.value =
          newQty * myCart.value[productIndex].newmrp;

      updateFinalPrice(myCart.value[productIndex].newmrp, "update",
          qty: (newQty - oldQty));
    }
    if (myCart.value[productIndex].cartquantity.value == 0) {
      removeFromCart(findProduct);
    }
  }

  void decrementCount(Product findProduct) {
    int productIndex = findIndexOfProduct(findProduct);
    if (productIndex < 0) {
      //product not fount so nothing tdo do
    } else {
      myCart.value[productIndex].cartquantity.value--;
      myCart.value[productIndex].subtotal.value =
          myCart.value[productIndex].subtotal.value -
              myCart.value[productIndex].newmrp;
      updateFinalPrice(myCart.value[productIndex].newmrp, "less");
    }
    if (myCart.value[productIndex].cartquantity.value == 0) {
      removeFromCart(findProduct);
    }
  }

  void removeFromCart(Product findProduct, {bool allQty = false}) {
    int productIndex = findIndexOfProduct(findProduct);
    if (productIndex < 0) {
      //product not fount so nothing tdo do
    } else {
      if (allQty) {
        int totalQty = myCart.value[productIndex].cartquantity.value;
        double mrp = myCart.value[productIndex].newmrp;
        updateFinalPrice(mrp, "less", allQty: true, qty: totalQty);
      }
      cartCount.value = cartCount.value - 1;
      myCart.value.removeAt(productIndex);
      print('Cart Count new : ${cartCount.value}');
    }
  }
}
