import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/order_history_controller.dart';
import 'model/order_history.dart';

class MyOrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderHistoryController ohC = Get.put(OrderHistoryController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Order History'),
          ),
          body: Obx(
            () => ohC.loaded.value
                ? ListView.builder(
                    itemCount: ohC.orderHistory.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderHistory tempOrder = ohC.orderHistory.value[index];
                      return Card(
                        color: Colors.blueGrey.shade50,
                        elevation: 4.0,
                        margin: EdgeInsets.fromLTRB(7, 8, 7, 8),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                'Order #',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(tempOrder.orderNo),
                            ],
                          ),
                          trailing: Icon(Icons.more_vert),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              orderHistoryInfo(
                                orderDate: tempOrder.cuurdatetime,
                                val: 'Rs. ${tempOrder.orderAmount}',
                              ),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : CircularProgressIndicator(),
          )),
    );
  }
}

class orderHistoryInfo extends StatelessWidget {
  orderHistoryInfo({Key key, this.orderDate, this.val}) : super(key: key);
  String orderDate, val;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date :',
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              'Amount :',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderDate),
            Text(val),
          ],
        ),
      ],
    );
  }
}
