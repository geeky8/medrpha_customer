import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'MyOrderPage.dart';
import 'TabWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'model/AddressModel.dart';
import 'model/CardModel.dart';
import 'util/ConstantData.dart';
import 'util/SizeConfig.dart';

import 'util/DataFile.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';

class ThankYouPage extends StatefulWidget {


  @override
  _ThankYouPage createState() {
    return _ThankYouPage();
  }
}

class _ThankYouPage extends State<ThankYouPage> {
  AddressModel addressList = DataFile.getAddressList()[0];
  CardModel cardList = DataFile.getCardList()[0];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    cardList = DataFile.getCardList()[0];
    addressList = DataFile.getAddressList()[0];
    setState(() {});
  }

  Future<bool> _requestPop() {
    // Navigator.of(context).pop();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TabWidget()));

    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double size = SizeConfig.safeBlockVertical * 30;
    double bottomHeight = ConstantWidget.getScreenPercentSize(context, 8);

    double subRadius = ConstantWidget.getPercentSize(bottomHeight, 10);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: Text(""),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: ConstantData.mainTextColor,
                ),
                onPressed: () {
                  _requestPop();
                },
              )
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Image.asset(ConstantData.assetsPath+'thank_you.png',height: size),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            style: new TextStyle(
                              // fontWeight: FontWeight.w600,
                              fontSize: ConstantData.font12Px,
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.mainTextColor,
                            ),
                            children: <TextSpan>[
                              new TextSpan(text: 'Your order'),
                              new TextSpan(
                                  text: ' #345678 ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ConstantData.textColor)),
                              new TextSpan(text: 'is Completed.'),
                            ],
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          style: new TextStyle(
                            fontSize: ConstantData.font12Px,
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.mainTextColor,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Please check the Delivery status at',

                                style: new TextStyle(
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w500,
                                    fontSize: ConstantData.font18Px,
                                    color: ConstantData.textColor)
                            ),
                            new TextSpan(
                                recognizer: new TapGestureRecognizer()..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyOrderPage(false),
                                      ));
                                },

                                text: '\nOrder Tracking ',
                                style: new TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ConstantData.font22Px,
                                    color: ConstantData.accentColor)),
                            new TextSpan(text: ' pages.',


                                style: new TextStyle(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                fontSize: ConstantData.font18Px,
                                color: ConstantData.textColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),

                InkWell(
                  child: Container(
                    height: bottomHeight,
                    margin: EdgeInsets.symmetric(
                        vertical: ConstantWidget.getPercentSize(
                            bottomHeight, 30),horizontal: ConstantWidget.getPercentSize(
                        bottomHeight, 40)),
                    decoration: BoxDecoration(
                      color: ConstantData.primaryColor,
                      borderRadius:
                      BorderRadius.all(Radius.circular(subRadius)),
                    ),
                    child: Center(
                      child: ConstantWidget.getTextWidget(
                          S.of(context).continueShopping,
                          Colors.white,
                          TextAlign.start,
                          FontWeight.bold,
                          ConstantWidget.getPercentSize(
                              bottomHeight, 25)),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabWidget()));
                  },
                )


              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
