import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:get/get.dart';

import 'controller/order_history_controller.dart';
import 'model/order_history.dart';
import 'myWidget/no_item_found.dart';
import 'my_order_details.dart';
import 'view/my_getx_home_page.dart';

class MyOrderHistory extends StatelessWidget {
  var showDate, filterText;
  OrderHistoryController ohC;
  void toggleSearch() {
    if (showDate.value == true) {
      showDate.value = false;
    } else {
      showDate.value = true;
    }
  }

  String getDateString(DateTime tempDate) {
    return tempDate.day.toString() +
        "/" +
        tempDate.month.toString() +
        "/" +
        tempDate.year.toString();
  }

  void showAllData() {
    ohC.loadOrderHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    showDate = false.obs;
    filterText = "All".obs;
    bool filterOn = false;
    ohC = Get.put(OrderHistoryController());
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh_sharp),
            onPressed: showAllData,
            backgroundColor: Colors.cyan,
            foregroundColor: Colors.white,
          ),
          // appBar: AppBar(
          //   backgroundColor: Color.fromRGBO(0, 143, 181, 1.0),
          //   title: Text('Order History'),
          // ),
          body: Obx(
            () => ohC.loaded.value
                ? ohC.orderHistory == null || ohC.orderHistory.length == 0
                    ? Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                tileColor: Color.fromRGBO(0, 143, 181, 1.0),
                                leading: GestureDetector(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyNewHomePage(),
                                        ));
                                  },
                                ),
                                title: Text(
                                  'Back To Home',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      NoItemFound(
                                          msg:
                                              'You have not placed any order!!'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ohC.filter.value
                                          ? Text(
                                              'Date Range: ${ohC.startDate} - ${ohC.endDate}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : SizedBox(
                                              height: 1,
                                            )
                                    ]),
                              ),
                              ohC.filter.value
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          ElevatedButton(
                                            style:
                                                ConstantData.btnStyleSecondary,
                                            onPressed: showAllData,
                                            child: Text('Show all Orders'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ])
                                  : SizedBox(
                                      width: 1,
                                    ),
                            ]),
                      )
                    : Container(
                        child: Column(
                          children: [
                            ListTile(
                              tileColor: Color.fromRGBO(0, 143, 181, 1.0),
                              leading: GestureDetector(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyNewHomePage(),
                                      ));
                                },
                              ),
                              title: Text(
                                'Order History',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              trailing: GestureDetector(
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.white,
                                ),
                                onTap: toggleSearch,
                              ),
                            ),
                            Obx(() {
                              if (showDate.value == true) {
                                return DateRangeField(
                                  enabled: true,
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now(),
                                  initialValue: DateTimeRange(
                                      start: DateTime.now()
                                          .add(Duration(days: -30)),
                                      end: DateTime.now()),
                                  decoration: InputDecoration(
                                    labelText: 'Find Orders Between',
                                    prefixIcon: Icon(Icons.date_range),
                                    hintText:
                                        'Please select a start and end date',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value.start.isAfter(DateTime.now())) {
                                      return 'The end date can not be greater than Today';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    print("date changed");
                                    DateTime startDate = val.start;
                                    DateTime endDate = val.end;

                                    filterText.value =
                                        getDateString(startDate) +
                                            "-" +
                                            getDateString(endDate);
                                    showDate.value = false;
                                    ohC.loaded.value = false;
                                    ohC.filterOrderHistoryData(
                                        StartDate: getDateString(startDate),
                                        EndDate: getDateString(endDate));
                                    print(val);
                                  },
                                  onSaved: (value) {
                                    print("save clicked");
                                  },
                                );
                              } else {
                                return Container(
                                  color: Colors.cyan.shade50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 15, height: 50),
                                      Text(
                                        "Showing Orders: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17),
                                      ),
                                      Obx(
                                        () => Text(
                                          filterText.value,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: ohC.orderHistory.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    OrderHistory tempOrder =
                                        ohC.orderHistory.value[index];
                                    return GestureDetector(
                                      onTap: () {
                                        print(
                                            'The order tapped: ${ohC.orderHistory.value[index].orderId}');
                                        String orderId = ohC
                                            .orderHistory.value[index].orderId;
                                        print(
                                            'Calling order details for order id : ${orderId}');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            // builder: (context) => OrderDetailPage(),
                                            builder: (context) =>
                                                MyOrderDetails(
                                                    orderId: orderId),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: Colors.blueGrey.shade50,
                                        elevation: 4.0,
                                        margin: EdgeInsets.fromLTRB(7, 8, 7, 8),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text(
                                                'Order# ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(tempOrder.orderNo),
                                            ],
                                          ),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              orderHistoryInfo(
                                                orderDate: tempOrder.placedDate,
                                                val: '${tempOrder.orderAmount}',
                                                paid: tempOrder.paymentStatus,
                                                order_status:
                                                    tempOrder.orderStatus,
                                                dispatchDate:
                                                    tempOrder.deliveredDate,
                                                deliveryDate:
                                                    tempOrder.deliveredDate,
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                : Container(child: Center(child: CircularProgressIndicator())),
          )),
    );
  }
}

class orderHistoryInfo extends StatelessWidget {
  orderHistoryInfo(
      {Key key,
      this.orderDate,
      this.val,
      this.paid,
      this.order_status,
      this.dispatchDate,
      this.deliveryDate})
      : super(key: key);
  String orderDate, val, dispatchDate, deliveryDate;
  var order_status, paid;
  @override
  Widget build(BuildContext context) {
    orderDate ??= 'NA';
    //val = "\u{20B9}" + ((double.parse(val) * 100).round() / 100).toString();
    String payStatusStr;
    Color payColor;
    if (paid == "1") {
      payStatusStr = "Payment Pending";
      payColor = Colors.red;
    } else if (paid == "2") {
      payStatusStr = "Paid";
      payColor = Colors.green;
    } else {
      payStatusStr = "Pending/Pay Later";
      payColor = Colors.cyan;
    }
    Widget paidW = Text(
      payStatusStr,
      style: TextStyle(color: payColor),
    );
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
            Text(
              'Pay Status :',
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              'Order status :',
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              'Dispatch Date :',
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              'Delivery Date :',
              style: TextStyle(color: Colors.black87),
            )
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
            paidW,
            Obx(
              () => Text(order_status.value),
            ),
            Text(dispatchDate ?? 'Not Dispatched'),
            Text(deliveryDate ?? 'Not Delivered')
          ],
        ),
      ],
    );
  }
}
