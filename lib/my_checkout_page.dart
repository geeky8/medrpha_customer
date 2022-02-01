import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_medical_ui/controller/city_controller.dart';
import 'package:flutter_medical_ui/controller/country_controller.dart';
import 'package:flutter_medical_ui/controller/pin_controller.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';
import 'controller/customer_controller.dart';
import 'controller/state_controller.dart';
import 'model/city.dart';
import 'model/country.dart';
import 'model/customer.dart';
import 'model/navigation_service.dart';
import 'model/pin.dart';
import 'model/product.dart';
import 'model/state.dart';
import 'myWidget/no_item_found.dart';
import 'my_checkout_result.dart';

class MyCheckoutPage extends StatelessWidget {
  String orderId;
  MyCheckoutPage() {
    print('in constructor');
  }

  @override
  Widget build(BuildContext context) {
    const base_url = "https://partner.medrpha.com/product_image/";
    // print('creatinging order details controller for order ID ${orderId}');
    final CustomerController cust = Get.find<CustomerController>();
    final CartController cc = Get.find<CartController>();
    final CityController cityCc = Get.find<CityController>();
    final StateController stateCc = Get.find<StateController>();
    final CountryController countryCc = Get.find<CountryController>();
    final PinController pinCc = Get.find<PinController>();
    Customer cs = cust.customer.value;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Your Order Summary'),
          ),
          body: Obx(
            () => cust.loaded.value
                ? cs.firmName == null
                    ? NoItemFound()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.fromLTRB(20, 15, 7, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Shipping Address',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('Name:',
                                        style: TextStyle(fontSize: 16)),
                                    Text(cs.firmName,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(cs.address,
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        getCityName(
                                                cityCc.cityOptions, cs.cityid) +
                                            ', ',
                                        style: TextStyle(fontSize: 15)),
                                    Text(
                                        '${getStateName(stateCc.stateOptions, cs.stateid)}, ',
                                        style: TextStyle(fontSize: 15)),
                                    Text(
                                        getCountryName(countryCc.countryOptions,
                                                cs.countryid) +
                                            ' - ',
                                        style: TextStyle(fontSize: 15)),
                                    Text(
                                        '${getPin(pinCc.pinOptions, cs.areaid)}',
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Phone: ',
                                        style: TextStyle(fontSize: 15)),
                                    Text('${cs.phoneno}',
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Total Items in cart : ${cc.myCart.length}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: cc.myCart.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Product product = cc.myCart[index];
                                  return Card(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(right: 10),
                                            width: 70,
                                            child: Image.network(
                                                base_url + product.productImg),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.productName,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                product.categorystr +
                                                    '/' +
                                                    product.compnaystr,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                product.saleqtytypestr +
                                                    ' of ' +
                                                    product.prodsaletypedetails,
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '\u{20B9}',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          product.newmrp
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' x ',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          product.cartquantity
                                                              .value
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '\u{20B9} ' +
                                                              (product.newmrp *
                                                                      product
                                                                          .cartquantity
                                                                          .value)
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .pinkAccent
                                                                .shade400,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          width: 15,
                                                          height: 25,
                                                        ),
                                                        // Add button clicked
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    // Add button

                                                    // plus minus btn
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'MRP Total',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '\u{20B9} ${cc.getTotalMRP().toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Less Discount',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      '\u{20B9} - ${cc.getTotalMRP() - cc.finalPrice.value}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.green.shade600),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '\u{20B9} ${cc.finalPrice.value.toString()}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.grey),
                                Text(
                                  '***Shipping charges as per Delivery Address',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Payment Type',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Cash on Delivery',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        primary: Colors.white,
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        textStyle:
                                            const TextStyle(fontSize: 14),
                                      ),
                                      onPressed: cc.myCart.length > 0
                                          ? () {
                                              Navigator.pushReplacement(
                                                NavigationService.navigatorKey
                                                    .currentContext,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyCheckoutResult(
                                                    paymentType: 1,
                                                  ),
                                                ),
                                              );
                                            }
                                          : () {},
                                      child: const Text('Place Order'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                : Container(child: Center(child: CircularProgressIndicator())),
          )),
    );
  }
}
