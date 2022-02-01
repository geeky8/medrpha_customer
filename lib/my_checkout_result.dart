import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_medical_ui/controller/checkout_controller.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'controller/customer_controller.dart';
import 'model/customer.dart';
import 'my_order_history.dart';
import 'view/my_getx_home_page.dart';

class MyCheckoutResult extends StatelessWidget {
  String orderId;
  MyCheckoutResult({this.paymentType}) {
    print('in constructor');
  }

  int paymentType;

  @override
  Widget build(BuildContext context) {
    const base_url = "https://partner.medrpha.com/product_image/";
    // print('creatinging order details controller for order ID ${orderId}');
    final CustomerController cust = Get.find<CustomerController>();
    Customer cs = cust.customer.value;
    final CartController cc = Get.find<CartController>();
    final CheckoutController checkOut = CheckoutController();
    checkOut.checkoutCart(
        checkOutType: paymentType, finalPrice: cc.finalPrice.value);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Your Order Status'),
          ),
          body: Obx(
            () => cust.loaded.value
                ? checkOut.orderId.value == "0"
                    ? Container(
                        child: Center(
                            child:
                                Text('Issue with checkout, kindly try later')),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                              padding: EdgeInsets.only(left: 20, right: 20),
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
                      )
                : Container(child: Center(child: CircularProgressIndicator())),
          )),
    );
  }
}
