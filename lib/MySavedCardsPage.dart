import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'AddNewCardPage.dart';
import 'generated/l10n.dart';
import 'model/CardModel.dart';
import 'model/PaymentCardModel.dart';

class MySavedCardsPage extends StatefulWidget {
  @override
  _MySavedCardsPage createState() {
    return _MySavedCardsPage();
  }
}

class _MySavedCardsPage extends State<MySavedCardsPage> {
  List<CardModel> cardList = DataFile.getCardList();
  List<PaymentCardModel> paymentModelList = DataFile.getPaymentCardList();



  @override
  void initState() {
    super.initState();
    cardList = DataFile.getCardList();
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
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).mySavedCards),
            // title: ConstantWidget.getCustomTextWithoutAlign(S.of(context).mySavedCards,ConstantData.textColor, FontWeight.bold, ConstantData.font18Px),

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
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ConstantWidget.getScreenPercentSize(context, 2)),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: paymentModelList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: ConstantWidget.getWidthPercentSize(
                                      context, 3.5)),
                              padding: EdgeInsets.all(
                                  ConstantWidget.getScreenPercentSize(
                                      context, 2)),
                              decoration: BoxDecoration(
                                  color: ConstantData.bgColor,
                                  borderRadius: BorderRadius.circular(
                                      ConstantWidget.getScreenPercentSize(
                                          context, 1.5)),
                                  border: Border.all(
                                      color: ConstantData.borderColor,
                                      width: ConstantWidget.getWidthPercentSize(
                                          context, 0.08)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        paymentModelList[index].image,
                                        height:
                                            ConstantWidget.getScreenPercentSize(
                                                context, 4),
                                      ),
                                      SizedBox(
                                        width:
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ConstantWidget
                                                    .getCustomTextWithoutAlign(
                                                        paymentModelList[index]
                                                            .name,
                                                        ConstantData
                                                            .mainTextColor,
                                                        FontWeight.w700,
                                                        ConstantData.font22Px),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 0.5)),
                                                  child: ConstantWidget
                                                      .getCustomTextWithoutAlign(
                                                          paymentModelList[
                                                                  index]
                                                              .desc,
                                                          ConstantData
                                                              .textColor,
                                                          FontWeight.w500,
                                                          ConstantData
                                                              .font18Px),
                                                )
                                              ],
                                            ),
                                            // new Spacer(),
                                            // Align(
                                            //   alignment:
                                            //   Alignment.centerRight,
                                            //   child: Padding(
                                            //     padding:
                                            //     EdgeInsets.only(
                                            //         right: 3),
                                            //     child: Icon(
                                            //       (index ==
                                            //           _selectedAddress)
                                            //           ? Icons
                                            //           .radio_button_checked
                                            //           : Icons
                                            //           .radio_button_unchecked,
                                            //       color: (index ==
                                            //           _selectedAddress)
                                            //           ? ConstantData
                                            //           .textColor
                                            //           : Colors.grey,
                                            //       size: ConstantWidget.getPercentSize(cellHeight,
                                            //           25),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              // _selectedAddress = index;
                              // setState(() {});
                            },
                          );
                        }),
                    flex: 1,
                  ),

                  ConstantWidget.getBottomText(context, S.of(context).newCard,
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNewCardPage(),
                        ));
                  })

//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//
//
//                       Container(
//
//                         margin: EdgeInsets.only(top: defMargin),
//                         padding: EdgeInsets.all(defMargin),
//                         color: ConstantData.cellColor,
//                         child: Column(
//                           children: [
//
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: (defMargin)),
//                               child: Row(
//                                 children: [
//
//
//                                   ConstantWidget.getTextWidget(
//                                       S.of(context).savedCards,
//                                       ConstantData.mainTextColor,
//                                       TextAlign.start,
//                                       FontWeight.w800,
//                                       ConstantWidget.getScreenPercentSize(
//                                           context, 2.5)),
//
//
//
//
//                                   new Spacer(),
//                                   InkWell(
//
//                                     child:       ConstantWidget.getUnderlineText(S.of(context).newCard,
//                                         Colors.orange,
//                                         1,
//                                         TextAlign.start, FontWeight.bold, ConstantWidget.getScreenPercentSize(
//                                             context, 2)),
//
//
//
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   AddNewCardPage()));
//                                     },
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height:
//                               defMargin,
//                             ),
//                             Container(
//                               color: ConstantData.mainTextColor,
//                               height: ConstantWidget.getScreenPercentSize(
//                                   context, 0.02),
//                             ),
//                             SizedBox(
//                               height:
//                               defMargin,
//                             ),
//
//                             Container(
//                               margin: EdgeInsets.only(
//                                   bottom: MediaQuery.of(context).size.width * 0.01,top: defMargin),
//                               child: ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemCount: cardList.length,
//                                   padding: EdgeInsets.zero,
//                                   itemBuilder: (context, index) {
//                                     return InkWell(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(horizontal:defMargin),
//
//                                         child: Column(
//                                           children: [
//
//                                             Row(
//                                               children: [
//                                                 InkWell(
//                                                     child: Icon(
//                                                       CupertinoIcons.checkmark_alt_circle_fill,
//                                                       color: (_selectedCards==index)?ConstantData.accentColor:Colors.grey.shade400,
//                                                       size: iconSize ,
//                                                     ),
//                                                     onTap:(){
//                                                       _selectedCards = index;
//                                                       setState(() {});
//                                                     }
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(left: defMargin),
//                                                   child: Text(
//                                                     "XXXX XXXX XXXX 1234",
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                         fontFamily: ConstantData.fontFamily,
//                                                         color: ConstantData.mainTextColor,
//                                                         fontWeight: FontWeight.w700,
//                                                         decoration: TextDecoration.none,
//                                                         fontSize: ConstantData.font18Px),
//                                                   ),
//                                                 ),
//                                                 new Spacer(),
//                                                 Image.asset(
//                                                   cardList[index].image,
//                                                   width: (iconSize*1.5),
//                                                   height: (iconSize*1.5),
//                                                 ),
//
//                                               ],
//                                             ),
//
//                                             Padding(
//                                               padding: EdgeInsets.only(top: defMargin),
//                                               child: Row(
//                                                 children: [
//
//
//                                                   Icon(
//                                                     Icons.credit_card,
//                                                     size: iconSize,
//                                                     color: ConstantData.accentColor,
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(left: defMargin),
//                                                     child: Text(
//                                                       "Valid from".toUpperCase(),
//                                                       style: TextStyle(
//                                                           fontFamily: ConstantData.fontFamily,
//                                                           color: ConstantData.textColor,
//                                                           fontWeight: FontWeight.bold,
//                                                           decoration: TextDecoration.none,
//                                                           fontSize: ConstantData.font15Px),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(left: defMargin),
//                                                     child: Text(
//                                                       cardList[index].expDate,
//                                                       style: TextStyle(
//                                                           fontFamily: ConstantData.fontFamily,
//                                                           color: ConstantData.textColor,
//                                                           fontWeight: FontWeight.bold,
//                                                           decoration: TextDecoration.none,
//                                                           fontSize: ConstantData.font15Px),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//
//                                             Padding(
//                                               padding: EdgeInsets.only(top: defMargin,left: (defMargin/5)),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     cardList[index].name
//
//                                                         .toUpperCase(),
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                         fontFamily: ConstantData.fontFamily,
//                                                         color: ConstantData.textColor,
//                                                         fontWeight: FontWeight.w500,
//                                                         decoration: TextDecoration.none,
//                                                         fontSize: ConstantData.font15Px),
//                                                   ),
//                                                   new Spacer(),
//                                                   Text(
//                                                     "CVV",
//                                                     style: TextStyle(
//                                                         fontFamily: ConstantData.fontFamily,
//                                                         color: ConstantData.textColor,
//                                                         fontWeight: FontWeight.w500,
//                                                         decoration: TextDecoration.none,
//                                                         fontSize: ConstantData.font15Px),
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.symmetric(vertical: (defMargin/2),horizontal: defMargin),
//                                                     margin: EdgeInsets.only(left: (defMargin)),
//                                                     decoration: BoxDecoration(
//                                                       color: ConstantData.primaryColor,
//                                                       borderRadius: BorderRadius.circular((defMargin/2)),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         "789",
//                                                         style: TextStyle(
//                                                             fontFamily: ConstantData.fontFamily,
//                                                             color: Colors.white,
//                                                             fontWeight: FontWeight.w800,
//                                                             fontSize: ConstantWidget.getScreenPercentSize(context, 1.5)),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )
//
//
//
//                                             ,
//                                             Visibility(child: Container(
//                                               height: ConstantWidget.getScreenPercentSize(context,0.02),
//                                               color: ConstantData.textColor,
//                                               margin: EdgeInsets.symmetric(vertical: (defMargin*3)),
//                                             ),visible: (index!=(cardList.length-1)),)
// ,
//
//                                             Visibility(child: SizedBox(
//                                               height: defMargin*1.5,
//                                             ),visible: (index==(cardList.length-1)),)
//
//                                           ],
//                                         ),
//                                       ),
//
//
//                                       onTap: () {},
//                                     );
//                                   }),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
