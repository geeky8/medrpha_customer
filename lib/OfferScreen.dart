import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/AddToCartPage.dart';
import 'package:flutter_medical_ui/MyVouchers.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';


import 'generated/l10n.dart';

class OfferScreen extends StatefulWidget {


  OfferScreen();

  @override
  _OfferScreen createState() {
    return _OfferScreen();
  }
}

class _OfferScreen extends State<OfferScreen> {



  bool isCash=true;
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double image = ConstantWidget.getScreenPercentSize(context, 3);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: ConstantWidget.getAppBarText(S.of(context).addGiftCards),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),

          bottomNavigationBar: ConstantWidget.getBottomText(
              context, S.of(context).continueText, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToCartPage(),
                ));
          }),


          body: Container(
            child: ListView(
              children: [
                InkWell(

                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: margin),
                    padding: EdgeInsets.symmetric(horizontal: margin,vertical: (margin*1.5)),
                    color: ConstantData.cellColor,
                    child: Row(
                      children: [
                        Image.asset(
                          ConstantData.assetsPath + "offer.png",
                          width: image,
                          color: ConstantData.textColor,
                        ),
                        SizedBox(
                          width: margin,
                        ),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstantWidget.getCustomText(
                                    S.of(context).offersPromoCodeAndGiftCards,
                                    ConstantData.textColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    ConstantWidget.getScreenPercentSize(
                                        context, 2.3)),
                                SizedBox(
                                  height: (margin / 3),
                                ),
                                ConstantWidget.getCustomText(
                                    S.of(context).OffersAvailable,
                                    ConstantData.textColor,
                                    2,
                                    TextAlign.start,
                                    FontWeight.w400,
                                    ConstantWidget.getScreenPercentSize(context, 2)),
                              ],
                            )),
                        Icon(
                          Icons.navigate_next,
                          color: ConstantData.textColor,
                          size: image,
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyVouchers(true),));
                  },
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: margin,vertical: (margin*1.5)),
                  color: ConstantData.cellColor,
                  child: Column(
                    children: [
                      Row(
                          children: [
                            ConstantWidget.getCustomText(
                                S.of(context).itemTotal,
                                ConstantData.textColor,
                                2,
                                TextAlign.start,
                                FontWeight.w600,
                                ConstantWidget.getScreenPercentSize(context, 2)),

                            new Spacer(),

                            ConstantWidget.getCustomText(
                                "\$299",
                                ConstantData.textColor,
                                2,
                                TextAlign.start,
                                FontWeight.w600,
                                ConstantWidget.getScreenPercentSize(context, 2)),
                          ],
                      ),SizedBox(height: (margin),),
                      Row(
                        children: [
                          ConstantWidget.getCustomText(
                              "Partner welfare fees",
                              ConstantData.textColor,
                              2,
                              TextAlign.start,
                              FontWeight.w600,
                              ConstantWidget.getScreenPercentSize(context, 2)),

                          new Spacer(),

                          ConstantWidget.getCustomText(
                              "\$49",
                              ConstantData.textColor,
                              2,
                              TextAlign.start,
                              FontWeight.w600,
                              ConstantWidget.getScreenPercentSize(context, 2)),
                        ],
                      ),


                      Container(height: ConstantWidget.getScreenPercentSize(context,0.02),
                      color: ConstantData.textColor,
                      margin: EdgeInsets.symmetric(vertical:(margin)),),



                      Row(
                        children: [
                          ConstantWidget.getCustomText(
                              "Total",
                              ConstantData.mainTextColor,
                              2,
                              TextAlign.start,
                              FontWeight.bold,
                              ConstantWidget.getScreenPercentSize(context, 2.5)),

                          new Spacer(),

                          ConstantWidget.getCustomText(
                              "\$348",
                              ConstantData.mainTextColor,
                              2,
                              TextAlign.start,
                              FontWeight.bold,
                              ConstantWidget.getScreenPercentSize(context, 2.5)),
                        ],
                      ),


                    ],
                  ),
                )


                ,




              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
