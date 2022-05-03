import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_medical_ui/controller/checkout_controller.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'controller/customer_controller.dart';
import 'model/customer.dart';
import 'model/navigation_service.dart';
import 'my_order_history.dart';
import 'view/my_getx_home_page.dart';

class MyCheckoutResult extends StatelessWidget {
  String orderId;
  MyCheckoutResult({this.paymentType, this.payLater}) {
    print('in constructor');
  }

  int paymentType;
  int payLater;

  @override
  Widget build(BuildContext context) {
    // print('creatinging order details controller for order ID ${orderId}');
    final CustomerController cust = Get.find<CustomerController>();
    Customer cs = cust.customer.value;
    final CartController cc = Get.find<CartController>();
    final CheckoutController checkOut = CheckoutController();
    checkOut.checkoutCart(
        checkOutType: paymentType,
        payLater: payLater,
        finalPrice: cc.finalPrice.value);
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          NavigationService.navigatorKey.currentContext,
          MaterialPageRoute(
            builder: (context) => MyNewHomePage(),
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Your Order Status'),
            ),
            body: Obx(
              () => checkOut.loaded.value
                  ? checkOut.orderId.value == "0"
                      ? Container(
                          child: Center(
                              child: Text(
                                  'Issue with checkout, kindly try later')),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 50),
                              child: Text(
                                'Order Placed successfully, thank you!',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green.shade700),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your Order ID is: ${checkOut.orderId.value}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    primary: Colors.white,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                  child: const Text('View Order Details'),
                                  onPressed: () {
                                    print('Order History clicked');
                                    // Navigator.pop(context);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        // builder: (context) => OrderDetailPage(),
                                        builder: (context) => MyOrderHistory(),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    primary: Colors.white,
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                  child: const Text('Shop more Items'),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          //old template page
                                          //builder: (context) => MyHome(),
                                          builder: (context) => MyNewHomePage(),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                  : Container(
                      child: Center(child: CircularProgressIndicator())),
            )),
      ),
    );
  }
}
