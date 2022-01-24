import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/OrderDescModel.dart';
import 'package:flutter_medical_ui/model/OrderModel.dart';
import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'OrderDetailPage.dart';
import 'ProductDetailPage.dart';
import 'generated/l10n.dart';

class MyOrderPage extends StatefulWidget {
  final bool isHomePage;

  MyOrderPage(this.isHomePage);

  @override
  _MyOrderPage createState() {
    return _MyOrderPage();
  }
}

class _MyOrderPage extends State<MyOrderPage>
    with SingleTickerProviderStateMixin {
  List<SubCategoryModel> myOrderList = DataFile.getMyOrderList();

  List<OrderDescModel> orderList = DataFile.getOrderDescList();
  List<OrderModel> allOrderList = DataFile.getOrderList();
  TabController _controller;

  // PermissionStatus _permissionStatus = PermissionStatus.unknown;

  int expandPosition = -1;

  List<Widget> list = [
    Tab(
        icon: Icon(
      Icons.card_travel,
      color: Colors.transparent,
    )),
    Tab(
        icon: Icon(
      Icons.card_travel,
      color: Colors.transparent,
    )),
    Tab(
        icon: Icon(
      Icons.add_shopping_cart,
      color: Colors.transparent,
    )),
  ];

  void checkPermissions() async {}

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: list.length, vsync: this);
// _listenForPermissionStatus();
    _controller.addListener(() {
      setState(() {});
      print("Selected Index: " + _controller.index.toString());
    });
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(
              S.of(context).myOrderHistory,
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return Visibility(
                  child: IconButton(
                    icon: ConstantWidget.getAppBarIcon(),
                    onPressed: _requestPop,
                  ),
                  visible: (!widget.isHomePage),
                );
              },
            ),
            bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: ConstantData.primaryColor,
              unselectedLabelColor: ConstantData.textColor,
              labelColor: ConstantData.primaryColor,
              labelStyle: TextStyle(
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w500,
                fontSize: ConstantWidget.getScreenPercentSize(context, 2),
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w200,
                fontSize: ConstantWidget.getScreenPercentSize(context, 2),
              ),
              controller: _controller,
              tabs: [
                Tab(
                  text: S.of(context).all,
                ),
                Tab(
                  text: S.of(context).onDelivery,
                ),
                Tab(text: S.of(context).history),
              ],
            ),
          ),
          body: Container(
            child: TabBarView(
              controller: _controller,
              children: [allOrder(), onDelivery(), onCompleted()],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget onCompleted() {
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double imageSize = SizeConfig.safeBlockVertical * 8;

    double cellHeight = SizeConfig.safeBlockVertical * 5.5;
    double radius = SizeConfig.safeBlockVertical * 2;
    double subRadius = SizeConfig.safeBlockVertical * 1.5;

    double margin = SizeConfig.safeBlockVertical * 2;
    double padding = SizeConfig.safeBlockVertical * 1.5;
    double fontSize = ConstantWidget.getPercentSize(cellHeight, 35);

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: myOrderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: ConstantData.bgColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(
                          color: ConstantData.borderColor,
                          width: ConstantWidget.getWidthPercentSize(
                              context, 0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                        )
                      ]),
                  margin: EdgeInsets.only(
                      left: leftMargin, top: margin, right: leftMargin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: imageSize,
                            width: imageSize,
                            margin: EdgeInsets.all(radius),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: ConstantData.cellColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(radius),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(ConstantData.assetsPath +
                                        myOrderList[index].image),
                                    fit: BoxFit.cover)),
                            // child: Image.asset(ConstantData.assetsPath +
                            //     myOrderList[index].image),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).orderId + " : #2CE5DW",
                                    ConstantData.mainTextColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w800,
                                    ConstantWidget.getPercentSize(
                                        cellHeight, 40)),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: (padding / 1.8)),
                                  child: ConstantWidget.getCustomText(
                                      "3 " + S.of(context).items,
                                      ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 34)),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: padding,
                            bottom: margin,
                            left: margin,
                            right: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: cellHeight,
                                  margin: EdgeInsets.only(right: margin),
                                  decoration: BoxDecoration(
                                    color: ConstantData.cellColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(subRadius),
                                    // border: Border.all(
                                    //     width: 0.5,
                                    //     color: Colors.grey.shade400)
                                  ),
                                  child: Center(
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                            S.of(context).review,
                                            ConstantData.mainTextColor,
                                            FontWeight.w700,
                                            fontSize),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: cellHeight,
                                  margin: EdgeInsets.only(left: margin),
                                  decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(subRadius),
                                  ),
                                  child: Center(
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                            S.of(context).reOrder,
                                            Colors.white,
                                            FontWeight.w700,
                                            fontSize),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                            myOrderList[index]),
                                      ));
                                },
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      )

                      //   ],
                      // )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailPage()));
                },
              );
            }));
  }

  Widget onDelivery() {
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double imageSize = SizeConfig.safeBlockVertical * 8;

    double cellHeight = SizeConfig.safeBlockVertical * 5.5;
    double radius = SizeConfig.safeBlockVertical * 2;
    double subRadius = SizeConfig.safeBlockVertical * 1.5;

    double margin = SizeConfig.safeBlockVertical * 2;
    double padding = SizeConfig.safeBlockVertical * 1.5;
    double fontSize = ConstantWidget.getPercentSize(cellHeight, 35);

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: myOrderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  // decoration: BoxDecoration(
                  //     color: ConstantData.whiteColor,
                  //     borderRadius: BorderRadius.circular(radius),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.shade200,
                  //         blurRadius: 10,
                  //       )
                  //     ]),

                  decoration: BoxDecoration(
                      color: ConstantData.bgColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(
                          color: ConstantData.borderColor,
                          width: ConstantWidget.getWidthPercentSize(
                              context, 0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                        )
                      ]),
                  margin: EdgeInsets.only(
                      left: leftMargin, top: margin, right: leftMargin),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: imageSize,
                            width: imageSize,
                            margin: EdgeInsets.all(radius),
                            padding: EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: ConstantData.cellColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(radius),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(ConstantData.assetsPath +
                                        myOrderList[index].image),
                                    fit: BoxFit.cover)),
                            // child: Image.asset(ConstantData.assetsPath +
                            //     myOrderList[index].image),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).orderId + " : #2CE5DW",
                                    ConstantData.mainTextColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w800,
                                    ConstantWidget.getPercentSize(
                                        cellHeight, 40)),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: (padding / 1.8)),
                                  child: ConstantWidget.getCustomText(
                                      "3 " + S.of(context).items,
                                      ConstantData.textColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w500,
                                      ConstantWidget.getPercentSize(
                                          cellHeight, 34)),
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: padding,
                            bottom: margin,
                            left: margin,
                            right: margin),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: cellHeight,
                                  margin: EdgeInsets.only(right: margin),
                                  decoration: BoxDecoration(
                                    color: ConstantData.cellColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(subRadius),
                                    // border: Border.all(
                                    //     width: 0.5,
                                    //     color: Colors.grey.shade400)
                                  ),
                                  child: Center(
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                            S.of(context).cancelOrder,
                                            ConstantData.mainTextColor,
                                            FontWeight.w700,
                                            fontSize),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: cellHeight,
                                  margin: EdgeInsets.only(left: margin),
                                  decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(subRadius),
                                  ),
                                  child: Center(
                                    child: ConstantWidget
                                        .getCustomTextWithoutAlign(
                                            S.of(context).trackOrder,
                                            Colors.white,
                                            FontWeight.w700,
                                            fontSize),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => OrderTrackMap(),
                                  //     ));
                                },
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      )

                      //   ],
                      // )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailPage()));
                },
              );
            }));
  }

  Widget allOrder() {
    double imageSize = SizeConfig.safeBlockVertical * 6;
    double margin = SizeConfig.safeBlockVertical * 2;
    double leftMargin = SizeConfig.safeBlockVertical * 3;
    double radius = ConstantWidget.getPercentSize(imageSize, 30);
    double padding = ConstantWidget.getPercentSize(imageSize, 10);
    double dotSize = ConstantWidget.getPercentSize(imageSize, 15);
    double circleSize = ConstantWidget.getScreenPercentSize(context, 2);

    return Container(
        margin: EdgeInsets.only(top: leftMargin),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: allOrderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: margin, right: margin),
                        child: InkWell(
                          child: Row(
                            children: [
                              Container(
                                height: imageSize,
                                width: imageSize,
                                margin: EdgeInsets.all(margin),
                                padding: EdgeInsets.all(padding),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: ConstantData.getOrderColor(
                                      allOrderList[index].type),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(radius),
                                  ),
                                ),
                                // child: Icon(
                                //   CupertinoIcons.medi,
                                //   color: ConstantData.getIconColor(
                                //       allOrderList[index].type),
                                // ),

                                child: Center(
                                  child: Image.asset(
                                    ConstantData.assetsPath + "pills.png",
                                    color: ConstantData.getIconColor(
                                        allOrderList[index].type),
                                    height: ConstantWidget.getPercentSize(
                                        imageSize, 50),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: padding),
                                      child: ConstantWidget.getCustomText(
                                          S.of(context).orderId +
                                              " " +
                                              allOrderList[index].orderId,
                                          ConstantData.mainTextColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w800,
                                          ConstantData.font22Px),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ConstantWidget.getCustomText(
                                            allOrderList[index].items,
                                            ConstantData.textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w500,
                                            ConstantData.font18Px),
                                        Container(
                                          height: dotSize,
                                          width: dotSize,
                                          margin: EdgeInsets.only(
                                              left: margin, right: margin),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ConstantData.textColor),
                                        ),
                                        ConstantWidget.getCustomText(
                                            allOrderList[index].type,
                                            ConstantData.textColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w500,
                                            ConstantData.font18Px),
                                      ],
                                    )
                                  ],
                                ),
                                flex: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: margin, right: margin),
                                child: Icon(
                                  (index == expandPosition)
                                      ? CupertinoIcons.chevron_up
                                      : CupertinoIcons.chevron_down,
                                  color: ConstantData.textColor,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            if (expandPosition == index) {
                              expandPosition = -1;
                            } else {
                              expandPosition = index;
                            }

                            setState(() {});
                          },
                        ),
                      ),
                      Visibility(
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: orderList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: margin, bottom: margin),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: leftMargin, right: leftMargin),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: circleSize,
                                            width: circleSize,
                                            margin: EdgeInsets.only(
                                              right: margin,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (orderList[index]
                                                          .completed ==
                                                      1)
                                                  ? ConstantData.primaryColor
                                                  : Colors.grey,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: padding),
                                                  child: ConstantWidget
                                                      .getCustomText(
                                                          orderList[index].name,
                                                          ConstantData
                                                              .mainTextColor,
                                                          1,
                                                          TextAlign.start,
                                                          FontWeight.w600,
                                                          ConstantWidget
                                                              .getScreenPercentSize(
                                                                  context,
                                                                  1.8)),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ConstantWidget.getCustomText(
                                                        orderList[index].desc,
                                                        ConstantData.textColor,
                                                        1,
                                                        TextAlign.start,
                                                        FontWeight.w500,
                                                        ConstantWidget
                                                            .getScreenPercentSize(
                                                                context, 1.5)),
                                                  ],
                                                )
                                              ],
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                );
                              }),
                        ),
                        visible: (index == expandPosition),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: margin, bottom: margin),
                        color: ConstantData.textColor,
                        height:
                            ConstantWidget.getScreenPercentSize(context, 0.08),
                      )
                    ],
                  ),
                ),
                onTap: () {},
              );
            }));
  }
}
