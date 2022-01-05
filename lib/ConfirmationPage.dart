import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/ReviewSlider.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'ThankYouPage.dart';

import 'generated/l10n.dart';
import 'model/AddressModel.dart';

import 'model/CardModel.dart';

class ConfirmationPage extends StatefulWidget {
  final bool isCash;

  ConfirmationPage(this.isCash);

  @override
  _ConfirmationPage createState() {
    return _ConfirmationPage();
  }
}

class _ConfirmationPage extends State<ConfirmationPage> {
  AddressModel addressList = DataFile.getAddressList()[0];
  CardModel cardList = DataFile.getCardList()[0];

  int currentStep = 0;

  getOption() {
    // return (widget.isCash)?[
    // S.of(context).personalInfo,
    // S.of(context).confirmation
    // ]:

    return [
      S.of(context).personalInfo,
      S.of(context).payment,
      S.of(context).confirmation
    ];
  }

  @override
  void initState() {
    super.initState();
    cardList = DataFile.getCardList()[0];
    addressList = DataFile.getAddressList()[0];
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double padding = ConstantWidget.getScreenPercentSize(context, 1.5);

    double bottomHeight = ConstantWidget.getScreenPercentSize(context, 8);
    double iconSize = ConstantWidget.getScreenPercentSize(context, 3);

    double subRadius = ConstantWidget.getPercentSize(bottomHeight, 10);

    double radius = ConstantWidget.getScreenPercentSize(context, 4);
    double allRadius = ConstantWidget.getScreenPercentSize(context, 1.8);

    print("option=====${getOption().length}");
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).confirmation),
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
            color: ConstantData.bgColor,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: leftMargin),
                          child: ReviewSlider(
                              optionStyle: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                fontSize: ConstantWidget.getScreenPercentSize(
                                    context, 1.5),
                                color: ConstantData.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              onChange: (index) {},
                              initialValue: 2,
                              isCash: widget.isCash,
                              // initialValue: widget.isCash?1:2,

                              width: double.infinity,
                              options: getOption()),
                        ),

                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom: padding,
                              left: defMargin,
                              right: defMargin,
                              top: defMargin),
                          padding: EdgeInsets.only(
                              left: padding,
                              right: padding,
                              top: defMargin,
                              bottom: defMargin),
                          decoration: new BoxDecoration(
                              color: ConstantData.cellColor,
                              boxShadow: [
                                BoxShadow(
                                  color: ConstantData.shadowColor,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(allRadius))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstantWidget.getCustomTextWithoutAlign(
                                  addressList.name,
                                  ConstantData.mainTextColor,
                                  FontWeight.w700,
                                  ConstantData.font18Px),
                              Padding(
                                padding: EdgeInsets.only(top: (defMargin / 5)),
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    addressList.location,
                                    ConstantData.textColor,
                                    FontWeight.w500,
                                    ConstantData.font15Px),
                              )
                            ],
                          ),
                        ),

                        Visibility(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: padding, horizontal: defMargin),
                            padding: EdgeInsets.all(padding),
                            decoration: new BoxDecoration(
                                color: ConstantData.cellColor,
                                boxShadow: [
                                  BoxShadow(color: ConstantData.shadowColor)
                                ],
                                borderRadius: BorderRadius.all(
                                    Radius.circular(allRadius))),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.checkmark_alt_circle_fill,
                                      color: ConstantData.accentColor,
                                      size: iconSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: defMargin),
                                      child: Text(
                                        "XXXX XXXX XXXX 1234",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.mainTextColor,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.none,
                                            fontSize: ConstantData.font18Px),
                                      ),
                                    ),
                                    new Spacer(),
                                    Image.asset(
                                      cardList.image,
                                      width: (iconSize * 1.5),
                                      height: (iconSize * 1.5),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: defMargin),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.credit_card,
                                        size: iconSize,
                                        color: ConstantData.accentColor,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: defMargin),
                                        child: Text(
                                          "Valid from".toUpperCase(),
                                          style: TextStyle(
                                              fontFamily:
                                                  ConstantData.fontFamily,
                                              color: ConstantData.textColor,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                              fontSize: ConstantData.font15Px),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: defMargin),
                                        child: Text(
                                          cardList.expDate,
                                          style: TextStyle(
                                              fontFamily:
                                                  ConstantData.fontFamily,
                                              color: ConstantData.textColor,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none,
                                              fontSize: ConstantData.font15Px),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: defMargin, left: (defMargin / 5)),
                                  child: Row(
                                    children: [
                                      Text(
                                        cardList.name.toUpperCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.textColor,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontSize: ConstantData.font15Px),
                                      ),
                                      new Spacer(),
                                      Text(
                                        "CVV",
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.textColor,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.none,
                                            fontSize: ConstantData.font15Px),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: (defMargin / 2),
                                            horizontal: defMargin),
                                        margin:
                                            EdgeInsets.only(left: (defMargin)),
                                        decoration: BoxDecoration(
                                          color: ConstantData.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              (defMargin / 2)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "789",
                                            style: TextStyle(
                                                fontFamily:
                                                    ConstantData.fontFamily,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                                fontSize: ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 1.5)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          visible: (!widget.isCash),
                        ),


                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: leftMargin),
                  decoration: BoxDecoration(
                      color: ConstantData.cellColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius)),
                      boxShadow: [
                        BoxShadow(
                          color: ConstantData.shadowColor,
                        )
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: leftMargin,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: defMargin),
                          height:
                              ConstantWidget.getScreenPercentSize(context, 0.5),
                          width:
                              ConstantWidget.getWidthPercentSize(context, 30),
                          color: Colors.grey,
                        ),
                      ),
                      getRoWCell(S.of(context).subTotal, "\$88.10"),
                      Padding(
                        padding: EdgeInsets.only(top: padding, bottom: padding),
                        child: getRoWCell(S.of(context).shippingFee, "\$9.90"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: padding),
                        child:
                            getRoWCell(S.of(context).estimatingTax, "\$6.50"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ConstantWidget.getCustomText(
                                S.of(context).total,
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.3)),
                            flex: 1,
                          ),
                          Expanded(
                            child: ConstantWidget.getCustomText(
                                "\$104.50",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.end,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.3)),
                            flex: 1,
                          )
                        ],
                      ),
                      InkWell(
                        child: Container(
                          height: bottomHeight,
                          margin: EdgeInsets.symmetric(
                              vertical: ConstantWidget.getPercentSize(
                                  bottomHeight, 25)),
                          decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(subRadius)),
                          ),
                          child: Center(
                            child: ConstantWidget.getTextWidget(
                                S.of(context).done,
                                Colors.white,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantWidget.getPercentSize(
                                    bottomHeight, 25)),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThankYouPage()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getRoWCell(String s, String s1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ConstantWidget.getCustomText(s, ConstantData.textColor, 1,
              TextAlign.start, FontWeight.w800, ConstantData.font18Px),
          flex: 1,
        ),
        Expanded(
          child: ConstantWidget.getCustomText(s1, ConstantData.textColor, 1,
              TextAlign.end, FontWeight.w800, ConstantData.font18Px),
          flex: 1,
        )
      ],
    );
  }
}
