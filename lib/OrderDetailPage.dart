

import 'util/ConstantWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'util/DataFile.dart';
import 'generated/l10n.dart';
import 'model/SubCategoryModel.dart';
import 'util/ConstantData.dart';
import 'util/SizeConfig.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPage createState() {
    return _OrderDetailPage();
  }
}

class _OrderDetailPage extends State<OrderDetailPage>
    with SingleTickerProviderStateMixin {
  List<SubCategoryModel> myOrderList = DataFile.getMyOrderList();


  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double margin = SizeConfig.safeBlockVertical * 2;
    double padding = SizeConfig.safeBlockVertical * 0.9;

    double leftMargin = MediaQuery
        .of(context)
        .size
        .width * 0.05;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,


            title: ConstantWidget.getAppBarText(S.of(context).orderDetails),

            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(left: leftMargin, right: leftMargin),
            padding: EdgeInsets.only(top: margin),
            child: ListView(
              children: [
                Row(
                  children: [
                    ConstantWidget.getCustomText(
                        S.of(context).orderId+": ",
                        ConstantData.textColor,
                        1,
                        TextAlign.start,
                        FontWeight.w500,
                        ConstantData.font15Px),
                    ConstantWidget.getCustomText("#2CE5DW", ConstantData.mainTextColor, 1,
                        TextAlign.start, FontWeight.bold,   ConstantData.font15Px),
                    new Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: padding),
                      child: Icon(
                        Icons.timelapse_outlined,
                        size:   ConstantData.font15Px,
                      ),
                    ),
                    ConstantWidget.getCustomText(
                        "07/01/2021",
                        ConstantData.textColor,
                        1,
                        TextAlign.start,
                        FontWeight.w500,
                        ConstantData.font15Px),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: margin),
                  child: Row(
                    children: [
                      ConstantWidget.getCustomText(
                          S.of(context).items+": ",
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w500,
                          ConstantData.font15Px),
                      ConstantWidget.getCustomText(
                          myOrderList.length.toString(),
                          ConstantData.accentColor,
                          1,
                          TextAlign.start,
                          FontWeight.bold,
                          ConstantData.font15Px),
                    ],
                  ),
                ),
                onDelivery(),

                Padding(
                  padding: EdgeInsets.only(top: margin, bottom: padding),
                  child: ConstantWidget.getCustomText(
                      S.of(context).description,
                      ConstantData.mainTextColor,
                      1,
                      TextAlign.start,
                      FontWeight.bold,
                      ConstantData.font18Px),
                ),

                ConstantWidget.getCustomText(
                    "Rice ,Alo Borta.Bagon Borta.Vegetables,Beef Curry.Dal.",
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    ConstantData.font15Px),


                Padding(
                  padding: EdgeInsets.only(top: margin, bottom: padding),
                  child: ConstantWidget.getCustomText(
                      S.of(context).size,
                      ConstantData.mainTextColor,
                      1,
                      TextAlign.start,
                      FontWeight.bold,
                      ConstantData.font18Px),
                ),

                ConstantWidget.getCustomText(
                    "12",
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    ConstantData.font15Px),


                Container(
                  height: 0.3,
                  color: ConstantData.textColor,
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                ),

                Row(
                  children: [
                    ConstantWidget.getCustomText(
                        S
                            .of(context)
                            .totalAmount,
                        ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.bold,
                        16),


                    new Spacer(),
                    ConstantWidget.getCustomText(
                        "\$24.20",
                        ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.bold,
                        16),
                  ],
                ),

                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context,2),


                ),

              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }



  Widget onDelivery() {
    double imageSize = SizeConfig.safeBlockVertical * 9;
    double smallTextSize = ConstantWidget.getScreenPercentSize(context, 1.6);
    double margin = SizeConfig.safeBlockVertical * 2;

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: myOrderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(


                  child: Column(
                    children: [
                      Container(
                        height: 0.3,
                        color: ConstantData.textColor,
                        margin: EdgeInsets.only(bottom: margin, top: margin),
                      ),
                      Row(
                        children: [
                          Container(
                            height: imageSize,
                            width: imageSize,
                            margin: EdgeInsets.only(right: margin),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: ConstantData.cellColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(margin),
                              ),
                                image: DecorationImage(
                                    image: AssetImage(ConstantData.assetsPath + myOrderList[index].image),
                                    fit: BoxFit.cover)

                            ),
                            // child: Image.asset(ConstantData.assetsPath +
                            //     myOrderList[index].image),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ConstantWidget.getCustomText(
                                        myOrderList[index].name,
                                        ConstantData.mainTextColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w800,
                                        smallTextSize),
                                    new Spacer(),
                                    ConstantWidget.getCustomText(
                                        "Quantity: ",
                                        ConstantData.textColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        smallTextSize),
                                    ConstantWidget.getCustomText(
                                        "2",
                                        ConstantData.accentColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.bold,
                                        smallTextSize),
                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: ConstantWidget.getCustomText(
                                      myOrderList[index].price,
                                      ConstantData.accentColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      ConstantWidget.getScreenPercentSize(context, 2.1)),
                                ),


                                Row(
                                  children: [
                                    Icon(
                                      Icons.brightness_1,
                                      color: Colors.grey,
                                      size: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: ConstantWidget.getCustomText(
                                          "Delivered at 11:14 am",
                                          ConstantData.textColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w500,
                                          ConstantWidget.getScreenPercentSize(context, 1.8)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            flex: 1,
                          )
                        ],
                      ),


                      //   ],
                      // )
                    ],
                  ),
                ),
                onTap: () {},
              );
            }));
  }

}
