import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/view/open_pdf.dart';
import 'package:get/get.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:internet_file/storage_io.dart';

import 'controller/customer_controller.dart';
import 'controller/local_session_controller.dart';
import 'controller/order_details_controller.dart';
import 'controller/order_history_controller.dart';
import 'model/order_details.dart';
import 'myWidget/no_item_found.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:internet_file/internet_file.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'my_order_history.dart';

class MyOrderDetails extends StatelessWidget {
  String orderId;
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay = Razorpay();
  MyOrderDetails({this.orderId}) {
    print('in constructor');
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  var options = {};
  OrderDetailsController orderDetailsController;

  //Call this function for payment
  void openCheckout() async {
    CustomerController cs = Get.find<CustomerController>();
    // 'key' : 'rzp_test_DgTJRx7VR36Tvl',
    // 'key': 'rzp_live_kfbonxeuRfZYaL',
    var options = {
      'key': 'rzp_live_kfbonxeuRfZYaL',
      'amount':
          (double.parse(orderDetailsController.order_amount) * 100).round(),
      'name': 'Mederpha',
      'description': 'Online Medical Hub',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': cs.customer.value.phoneno,
        'email': cs.customer.value.txtemail,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    print(options);

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // also update the OrderHistoryController patment status to 2
    print("SUCCESS: " + response.paymentId);
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _sessionID = ls.getSessionValue();
    OrderHistoryController oListcontroller = Get.find<OrderHistoryController>();
    oListcontroller.updatePaymentStatus(
        orderNo: orderDetailsController.order_no);
    orderDetailsController.payment_status.value = "2";
    ApiService.updatePaymentStatus(
        sessionID: _sessionID, orderId: orderDetailsController.order_no);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("ERROR in payment: " +
        response.code.toString() +
        " - " +
        response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("EXTERNAL_WALLET: " + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    Razorpay _razorpay;

    ///TODO:  Change the image url
    const base_url = "https://partnertest.medrpha.com/product_image/";
    // print('creatinging order details controller for order ID ${orderId}');
    orderDetailsController = OrderDetailsController();
    orderDetailsController.loadOrderDetailsData(orderId);
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Your Order Details'),
          // ),
          body: Obx(
        () => orderDetailsController.loaded.value
            ? orderDetailsController.order_amount == "0"
                ? NoItemFound()
                : Column(
                    children: [
                      ListTile(
                        tileColor: Color.fromRGBO(0, 143, 181, 1.0),
                        leading: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Back to Order History',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onTap: () {
                          print('Order History clicked');
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => OrderDetailPage(),
                              builder: (context) => MyOrderHistory(),
                            ),
                          );
                        },
                        // onTap: () => Navigator.pop(context),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: EdgeInsets.fromLTRB(20, 15, 7, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your Order', style: TextStyle(fontSize: 25)),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Order Date   :     ',
                                    style: TextStyle(fontSize: 16)),
                                Text(orderDetailsController.order_datetime,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Order#          :     ',
                                    style: TextStyle(fontSize: 16)),
                                Text(orderDetailsController.order_no,
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Order total   :     ',
                                    style: TextStyle(fontSize: 16)),
                                Text(
                                    '\u{20B9}${((double.parse(orderDetailsController.order_amount) * 100).round() / 100).toString()}',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount:
                                orderDetailsController.orderDetails.length,
                            itemBuilder: (BuildContext context, int index) {
                              OrderDetails product =
                                  orderDetailsController.orderDetails[index];
                              return Card(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
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
                                                          ((double.parse(product
                                                                              .mrp) *
                                                                          100)
                                                                      .round() /
                                                                  100)
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
                                                              ((double.parse(product.totalqtymrp) *
                                                                              100)
                                                                          .round() /
                                                                      100)
                                                                  .toString(),
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
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Obx(
                        () => orderDetailsController.payment_status.value == "1"
                            ? ElevatedButton(
                                onPressed: openCheckout, child: Text('Pay Now'))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OpenPDF(
                                                  'https://test.medrpha.com/pdf/sss.pdf')));
                                    },
                                    child: Text(
                                      'View Invoice',
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () async {
                                      Map<Permission, PermissionStatus>
                                          statuses = await [
                                        Permission.storage,
                                        //add more permission to request here.
                                      ].request();

                                      if (statuses[Permission.storage]
                                          .isGranted) {
                                        var dir = await DownloadsPathProvider
                                            .downloadsDirectory;
                                        if (dir != null) {
                                          String savename = savedFileName;
                                          String savePath =
                                              dir.path + "/$savename";
                                          print(savePath);
                                          //output:  /storage/emulated/0/Download/banner.png

                                          try {
                                            await Dio()
                                                .download(fileurl, savePath,
                                                    onReceiveProgress:
                                                        (received, total) {
                                              if (total != -1) {
                                                print((received / total * 100)
                                                        .toStringAsFixed(0) +
                                                    "%");
                                                //you can build progressbar feature too
                                              }
                                            });
                                            print(
                                                "File(${savedFileName}) is saved to download folder.");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.teal,
                                              content: Text(
                                                  'File(${savedFileName}) is saved to download folder'),
                                            ));
                                          } on DioError catch (e) {
                                            print(e.message);
                                          }
                                        }
                                      } else {
                                        print(
                                            "No permission to read and write.");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.teal,
                                          content: Text(
                                              'No permission to save file'),
                                        ));
                                      }
                                    },
                                    child: Icon(Icons.download_outlined),
                                  )
                                ],
                              ),
                      ),
                    ],
                  )
            : Container(child: Center(child: CircularProgressIndicator())),
      )),
    );
  }

  String fileurl = "https://test.medrpha.com/pdf/sss.pdf";
  String savedFileName = "invoice.pdf";
  void downloadLink(link) async {
    final storageIO = InternetFileStorageIO();
    Directory appDocDirectory = await getTemporaryDirectory();

//     new Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true)
// // The created directory is returned as a Future.
//         .then((Directory directory) {
//       print('Path of New Dir: ' + directory.path);
//     });
    print('the path to be saves is: ' + appDocDirectory.path);
    await InternetFile.get(
      link,
      storage: storageIO,
      storageAdditional: {
        'filename': 'invoice.pdf',
        'location': appDocDirectory.path,
      },
    );
  }

  Future<Directory> _tempDirectory;
  void _requestTempDirectory() {
    _tempDirectory = getTemporaryDirectory();
  }
}
