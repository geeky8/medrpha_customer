import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:get/get.dart';

import 'controller/product_details_controller.dart';
import 'myWidget/no_item_found.dart';
import 'util/ConstantWidget.dart';

class MyProductDetails extends StatelessWidget {
  MyProductDetails({this.p_id, this.price_id});
  String p_id, price_id;
  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 45);
    double secHeight = ConstantWidget.getScreenPercentSize(context, 39);
    double subHeight = ConstantWidget.getScreenPercentSize(context, 24.5);
    double defMargin = (subHeight / 8);
    double radius = ConstantWidget.getScreenPercentSize(context, 6);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    print('The value passed was ${p_id} & ${price_id}');
    // TODO: change product image path
    final base_url = 'https://partnertest.medrpha.com/product_image/';
    final ProductDetailsController pdC =
        ProductDetailsController(p_id: p_id, price_id: price_id);
    pdC.loadProductDetails();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Obx(
              () => pdC.loaded.value
                  ? Text('${pdC.productDetails.value.productName}')
                  : Container(
                      child: Center(child: CircularProgressIndicator())),
            ),
          ),
          body: Obx(
            () => pdC.loaded.value
                ? pdC.productDetails == null || pdC.productDetails == ''
                    ? Center(
                        child: NoItemFound(
                            msg: 'Can\'t Show details. please try later!!'))
                    : Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(base_url +
                                            pdC.productDetails.value
                                                .productImg),
                                        fit: BoxFit.scaleDown)),
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: (defMargin / 2),
                                          vertical: (margin * 2)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: ConstantWidget
                                                .getWidthPercentSize(
                                                    context, 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: secHeight),
                                decoration: BoxDecoration(
                                    color: ConstantData.bgColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radius),
                                        topRight: Radius.circular(radius))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: margin),
                                      padding: EdgeInsets.symmetric(
                                          vertical: (margin)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: (margin),
                                          ),
                                          Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Expanded(
                                                  //   child:

                                                  ConstantWidget.getSpaceTextWidget(
                                                      pdC.productDetails.value
                                                              .categorystr +
                                                          '/' +
                                                          pdC.productDetails
                                                              .value.compnaystr,
                                                      Colors.grey,
                                                      TextAlign.start,
                                                      FontWeight.w400,
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 1.8)),

                                                  SizedBox(
                                                    height: ConstantWidget
                                                        .getScreenPercentSize(
                                                            context, 0.5),
                                                  ),
                                                  ConstantWidget.getCustomText(
                                                      pdC.productDetails.value
                                                          .productName,
                                                      ConstantData
                                                          .mainTextColor,
                                                      2,
                                                      TextAlign.start,
                                                      FontWeight.bold,
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 2.8)),

                                                  SizedBox(
                                                    height: ConstantWidget
                                                        .getScreenPercentSize(
                                                            context, 1),
                                                  ),

                                                  ConstantWidget.getSpaceTextWidget(
                                                      pdC.productDetails.value
                                                              .saleqtytypestr +
                                                          ' of ' +
                                                          pdC
                                                              .productDetails
                                                              .value
                                                              .prodsaletypedetails,
                                                      Colors.grey,
                                                      TextAlign.start,
                                                      FontWeight.w400,
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 2)),
                                                  SizedBox(
                                                    height: ConstantWidget
                                                        .getScreenPercentSize(
                                                            context, 0.5),
                                                  ),

                                                  ConstantWidget.getSpaceTextWidget(
                                                      'Exp Date: ' +
                                                          pdC
                                                              .productDetails
                                                              .value
                                                              .dtExpiryDate,
                                                      Colors.grey.shade600,
                                                      TextAlign.start,
                                                      FontWeight.w500,
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 2)),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: (margin * 1.2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: margin, bottom: (margin)),
                                            child: Text(pdC.productDetails.value
                                                .description),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                : Container(child: Center(child: CircularProgressIndicator())),
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
