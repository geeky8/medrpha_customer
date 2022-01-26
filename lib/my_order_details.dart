import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/myWidget/loading.dart';
import 'package:get/get.dart';

import 'controller/order_details_controller.dart';
import 'model/order_details.dart';
import 'myWidget/no_item_found.dart';

class MyOrderDetails extends StatelessWidget {
  String orderId;
  MyOrderDetails({this.orderId}) {
    print('in constructor');
  }

  @override
  Widget build(BuildContext context) {
    const base_url = "https://partner.medrpha.com/product_image/";
    // print('creatinging order details controller for order ID ${orderId}');
    final OrderDetailsController ohC = OrderDetailsController();
    ohC.loadOrderDetailsData(orderId);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Your Order Details'),
          ),
          body: Obx(
            () => ohC.loaded.value
                ? ohC.order_amount == "0"
                    ? NoItemFound()
                    : Column(
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 0,
                            margin: EdgeInsets.fromLTRB(20, 15, 7, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order Summary',
                                    style: TextStyle(fontSize: 25)),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text('Order Date   :     ',
                                        style: TextStyle(fontSize: 16)),
                                    Text(ohC.order_datetime,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Order#          :     ',
                                        style: TextStyle(fontSize: 16)),
                                    Text(ohC.order_no,
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Order total   :     ',
                                        style: TextStyle(fontSize: 16)),
                                    Text('\u{20B9}${ohC.order_amount}',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: ohC.orderDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  OrderDetails product =
                                      ohC.orderDetails[index];
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
                                                product.categoryName +
                                                    '/' +
                                                    product.compnayName,
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
                                                          product.mrp,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.blueGrey,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          ' X ',
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
                                                          product.quantity,
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
                                                              product
                                                                  .totalqtymrp,
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          'Batch No : ',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 13,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                          ),
                                                        ),
                                                        Text(
                                                          product.batchNumber,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          'Exp Date : ',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 13,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                          ),
                                                        ),
                                                        Text(
                                                          product.dtExpiryDate,
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
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
                        ],
                      )
                : loading(),
          )),
    );
  }
}
