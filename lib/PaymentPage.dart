import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/ReviewSlider.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';
import 'model/CardModel.dart';
import 'model/PaymentModel.dart';
import 'AddNewCardPage.dart';
import 'ConfirmationPage.dart';



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPage createState() {
    return _PaymentPage();
  }
}

class _PaymentPage extends State<PaymentPage> {
  List<PaymentModel> paymentList = DataFile.getPaymentList();
  List<CardModel> cardList = DataFile.getCardList();

  int currentStep = 0;
  int _paymentPosition = 0;
  int _cardPosition = 0;

  @override
  void initState() {
    super.initState();
    cardList = DataFile.getCardList();
    paymentList = DataFile.getPaymentList();
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

    double defMargin = ConstantWidget.getScreenPercentSize(context, 1.5);
    double iconSize = ConstantWidget.getScreenPercentSize(context,3);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,


            title: ConstantWidget.getAppBarText(S.of(context).checkout),

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
                    builder: (context) => ConfirmationPage(false)));
          }),




          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [


                      Padding(padding: EdgeInsets.symmetric(horizontal: leftMargin),child:  ReviewSlider(

                          optionStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            fontSize: ConstantWidget.getScreenPercentSize(context, 1.5),
                            color: ConstantData.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          onChange: (index) {},
                          initialValue: 1,

                          isCash: false,
                          width: double.infinity,
                          options: [
                            S.of(context).personalInfo,
                            S.of(context).payment,
                            S.of(context).confirmation
                          ]),),



                    Container(
                        padding: EdgeInsets.symmetric(horizontal: defMargin,vertical: (defMargin*2)),
                      margin: EdgeInsets.symmetric(vertical: defMargin),
                      color: ConstantData.cellColor,
                      child:   Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Padding(
                            padding: EdgeInsets.only(bottom: (defMargin*2)),


                          child: ConstantWidget.getTextWidget(
                              S.of(context).paymentMethods,
                              ConstantData.mainTextColor,
                              TextAlign.start,
                              FontWeight.w800,
                              ConstantWidget.getScreenPercentSize(
                                  context, 2.5)),


                        ),
                          getList(),],
                      )
                    ),


                      Container(

                        margin: EdgeInsets.only(top: defMargin),
                        padding: EdgeInsets.all(defMargin),
                        color: ConstantData.cellColor,
                        child: Column(
                          children: [

                            Container(
                              padding: EdgeInsets.symmetric(vertical: (defMargin)),
                              child: Row(
                                children: [


                                  ConstantWidget.getTextWidget(
                                      S.of(context).savedCards,
                                      ConstantData.mainTextColor,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2.5)),




                                  new Spacer(),
                                  InkWell(

                                    child:       ConstantWidget.getUnderlineText(S.of(context).newCard,
                                        Colors.orange,
                                        1,
                                        TextAlign.start, FontWeight.bold, ConstantWidget.getScreenPercentSize(
                                            context, 2)),



                                    onTap: () {
                                      Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddNewCardPage()));
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                              defMargin,
                            ),
                            Container(
                              color: ConstantData.mainTextColor,
                              height: ConstantWidget.getScreenPercentSize(
                                  context, 0.02),
                            ),
                            SizedBox(
                              height:
                              defMargin,
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.width * 0.01,top: defMargin),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: cardList.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal:defMargin),

                                        child: Column(
                                          children: [

                                            Row(
                                              children: [
                                                InkWell(
                                                    child: Icon(
                                                      CupertinoIcons.checkmark_alt_circle_fill,
                                                      color: (_cardPosition==index)?ConstantData.accentColor:Colors.grey.shade400,
                                                      size: iconSize ,
                                                    ),
                                                    onTap:(){
                                                      _cardPosition = index;
                                                      setState(() {});
                                                    }
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
                                                  cardList[index].image,
                                                  width: (iconSize*1.5),
                                                  height: (iconSize*1.5),
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
                                                    padding: EdgeInsets.only(left: defMargin),
                                                    child: Text(
                                                      "Valid from".toUpperCase(),
                                                      style: TextStyle(
                                                          fontFamily: ConstantData.fontFamily,
                                                          color: ConstantData.textColor,
                                                          fontWeight: FontWeight.bold,
                                                          decoration: TextDecoration.none,
                                                          fontSize: ConstantData.font15Px),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: defMargin),
                                                    child: Text(
                                                      cardList[index].expDate,
                                                      style: TextStyle(
                                                          fontFamily: ConstantData.fontFamily,
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
                                              padding: EdgeInsets.only(top: defMargin,left: (defMargin/5)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    cardList[index].name

                                                        .toUpperCase(),
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
                                                    padding: EdgeInsets.symmetric(vertical: (defMargin/2),horizontal: defMargin),
                                                    margin: EdgeInsets.only(left: (defMargin)),
                                                    decoration: BoxDecoration(
                                                      color: ConstantData.primaryColor,
                                                      borderRadius: BorderRadius.circular((defMargin/2)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "789",
                                                        style: TextStyle(
                                                            fontFamily: ConstantData.fontFamily,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w800,
                                                            fontSize: ConstantWidget.getScreenPercentSize(context, 1.5)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )



                                            ,
                                            Visibility(child: Container(
                                              height: ConstantWidget.getScreenPercentSize(context,0.02),
                                              color: ConstantData.textColor,
                                              margin: EdgeInsets.symmetric(vertical: (defMargin*3)),
                                            ),visible: (index!=(cardList.length-1)),)


                                          ],
                                        ),
                                      ),


                                      onTap: () {},
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: defMargin,)
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getList() {




    SizeConfig().init(context);

    double _crossAxisSpacing = 0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = SizeConfig.safeBlockVertical * 12.5;
    var _aspectRatio = _width / cellHeight;
    // var height = ConstantWidget.getPercentSize(cellHeight, 30);
    var imgHeight = ConstantWidget.getPercentSize(cellHeight, 40);

    double remainSize = cellHeight-imgHeight-ConstantWidget.getScreenPercentSize(context,1);

    return Container(
        child: GridView.count(
          crossAxisCount: _crossAxisCount,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          primary: false,
          mainAxisSpacing: ConstantWidget.getScreenPercentSize(context,2),
            crossAxisSpacing: ConstantWidget.getScreenPercentSize(context,1),
          childAspectRatio: _aspectRatio,
          children: List.generate(paymentList.length, (index) {
            return InkWell(
              child: Container(


                padding:
                EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight, 5)),

                decoration: BoxDecoration(
                  color: (index == _paymentPosition)
                      ? ConstantData.primaryColor
                      : Colors.transparent,
                  borderRadius:
                  BorderRadius.all(Radius.circular(ConstantWidget.getScreenPercentSize(context,1))),
                  border: Border.all(
                      color: (index == _paymentPosition)
                          ? ConstantData.primaryColor
                          : Colors.grey,
                      width: ConstantWidget.getScreenPercentSize(context,0.08)),
                ),


                height: cellHeight,
                child:Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        paymentList[index].image,
                        height: imgHeight,
                        width: imgHeight,
                        color: (index == _paymentPosition)
                            ? Colors.white
                            : ConstantData.textColor,
                      ),

                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ConstantWidget.getPercentSize(cellHeight, 3)),



                      child: ConstantWidget.getCustomText(
                          paymentList[index].name.toUpperCase(),
                          (index == _paymentPosition) ? Colors.white : ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w500,
                          ConstantWidget.getPercentSize(remainSize, 28)),
                    )
                  ],
                ),
              ),
              onTap: () {
                setState(() {

                  _paymentPosition = index;


                });
              },
            );
          }),
        ));
  }


}
