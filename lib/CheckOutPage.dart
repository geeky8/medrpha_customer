import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/AddNewCardPage.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'AddNewAddressPage.dart';
import 'generated/l10n.dart';
import 'model/AddressModel.dart';
import 'model/PaymentCardModel.dart';
import 'util/ThankYouDialog.dart';

class CheckOutPage extends StatefulWidget {



  @override
  _CheckOutPage createState() {
    return _CheckOutPage();
  }
}

class _CheckOutPage extends State<CheckOutPage> {
  List<AddressModel> addressList = DataFile.getAddressList();

  int currentStep = 0;
  int _selectedAddress = 0;
  int _selectedCard = 0;
  List<PaymentCardModel> paymentModelList = DataFile.getPaymentCardList();

  @override
  void initState() {
    super.initState();
    addressList = DataFile.getAddressList();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  getOption() {
    return [
      S.of(context).personalInfo,
      S.of(context).payment,
      S.of(context).confirmation
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double topMargin = ConstantWidget.getScreenPercentSize(context, 1);

    double cellHeight = MediaQuery.of(context).size.width * 0.2;


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


            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThankYouDialog(context, (v) {
                    setState(() {

                    });
                  });
                });

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => PaymentPage()));

          }),



          body: Container(
            child: ListView(
              children: [
                // Expanded(
                //   child: ListView(
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.symmetric(horizontal: leftMargin),
                //         child: ReviewSlider(
                //             optionStyle: TextStyle(
                //               fontFamily: ConstantData.fontFamily,
                //               fontSize: ConstantWidget.getScreenPercentSize(
                //                   context, 1.5),
                //               color: ConstantData.textColor,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             onChange: (index) {},
                //             initialValue: 0,
                //             isCash: false,
                //             width: double.infinity,
                //             options: getOption()),
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(top: leftMargin),
                //         padding: EdgeInsets.only(
                //             left: leftMargin,
                //             right: leftMargin,
                //             top: leftMargin),
                //         color: ConstantData.cellColor,
                //         child: Column(
                //           children: [
                //             Container(
                //               child: Row(
                //                 children: [
                //                   ConstantWidget.getTextWidget(
                //                       S.of(context).addressTitle,
                //                       ConstantData.mainTextColor,
                //                       TextAlign.start,
                //                       FontWeight.w800,
                //                       ConstantWidget.getScreenPercentSize(
                //                           context, 2.5)),
                //                   new Spacer(),
                //                   InkWell(
                //                     child: ConstantWidget.getUnderlineText(
                //                         S.of(context).newAddress,
                //                         Colors.orange,
                //                         1,
                //                         TextAlign.start,
                //                         FontWeight.bold,
                //                         ConstantWidget.getScreenPercentSize(
                //                             context, 2)),
                //                     onTap: () {
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (context) =>
                //                                   AddNewAddressPage()));
                //                     },
                //                   )
                //                 ],
                //               ),
                //             ),
                //             SizedBox(
                //               height: ConstantWidget.getScreenPercentSize(
                //                   context, 3),
                //             ),
                //             Container(
                //               color: ConstantData.mainTextColor,
                //               height: ConstantWidget.getScreenPercentSize(
                //                   context, 0.02),
                //             ),
                //             Container(
                //               child: ListView.builder(
                //                   shrinkWrap: true,
                //                   physics: NeverScrollableScrollPhysics(),
                //                   itemCount: addressList.length,
                //                   itemBuilder: (context, index) {
                //                     return InkWell(
                //                       child: Column(
                //                         children: [
                //                           Container(
                //                             height: cellHeight,
                //                             child: Column(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.center,
                //                               children: [
                //                                 Row(
                //                                   children: [
                //                                     Expanded(
                //                                       child: Row(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .start,
                //                                         crossAxisAlignment:
                //                                             CrossAxisAlignment
                //                                                 .center,
                //                                         children: [
                //                                           Column(
                //                                             mainAxisAlignment:
                //                                                 MainAxisAlignment
                //                                                     .start,
                //                                             crossAxisAlignment:
                //                                                 CrossAxisAlignment
                //                                                     .start,
                //                                             children: [
                //                                               ConstantWidget.getCustomTextWithoutAlign(
                //                                                   addressList[
                //                                                           index]
                //                                                       .name,
                //                                                   ConstantData
                //                                                       .mainTextColor,
                //                                                   FontWeight
                //                                                       .w700,
                //                                                   ConstantWidget
                //                                                       .getPercentSize(
                //                                                           cellHeight,
                //                                                           20)),
                //                                               Padding(
                //                                                 padding: EdgeInsets
                //                                                     .only(
                //                                                         top: (topMargin /
                //                                                             2)),
                //                                                 child: ConstantWidget.getCustomTextWithoutAlign(
                //                                                     addressList[
                //                                                             index]
                //                                                         .location,
                //                                                     ConstantData
                //                                                         .textColor,
                //                                                     FontWeight
                //                                                         .w500,
                //                                                     ConstantWidget
                //                                                         .getPercentSize(
                //                                                             cellHeight,
                //                                                             15)),
                //                                               )
                //                                             ],
                //                                           ),
                //                                           new Spacer(),
                //                                           Align(
                //                                             alignment: Alignment
                //                                                 .centerRight,
                //                                             child: Padding(
                //                                               padding: EdgeInsets
                //                                                   .only(
                //                                                       right: 3),
                //                                               child: Icon(
                //                                                 (index ==
                //                                                         _selectedPosition)
                //                                                     ? Icons
                //                                                         .radio_button_checked
                //                                                     : Icons
                //                                                         .radio_button_unchecked,
                //                                                 color: (index ==
                //                                                         _selectedPosition)
                //                                                     ? ConstantData
                //                                                         .textColor
                //                                                     : Colors.grey,
                //                                                 size: ConstantWidget
                //                                                     .getPercentSize(
                //                                                         cellHeight,
                //                                                         25),
                //                                               ),
                //                                             ),
                //                                           )
                //                                         ],
                //                                       ),
                //                                       flex: 1,
                //                                     )
                //                                   ],
                //                                 ),
                //                               ],
                //                             ),
                //                           ),
                //                           Visibility(
                //                             child: Container(
                //                               height: ConstantWidget
                //                                   .getScreenPercentSize(
                //                                       context, 0.02),
                //                               color: ConstantData.textColor,
                //                               margin: EdgeInsets.only(
                //                                   bottom: topMargin),
                //                             ),
                //                             visible: (index !=
                //                                 (addressList.length - 1)),
                //                           )
                //                         ],
                //                       ),
                //                       onTap: () {
                //                         _selectedPosition = index;
                //                         setState(() {});
                //                       },
                //                     );
                //                   }),
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                //   flex: 1,
                // ),


                Container(
                  padding: EdgeInsets.only(left: leftMargin,right: leftMargin),
                  // padding: EdgeInsets.only(left: leftMargin,right: leftMargin,top: leftMargin),

                  // color: ConstantData.cellColor,

                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [


                            ConstantWidget.getTextWidget(
                                S.of(context).addressTitle,
                                ConstantData.mainTextColor,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.5)),




                            new Spacer(),
                            InkWell(

                              child:       ConstantWidget.getUnderlineText(S.of(context).newAddress,
                                  Colors.orange,
                                  1,
                                  TextAlign.start, FontWeight.bold, ConstantWidget.getScreenPercentSize(
                                      context, 2)),



                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddNewAddressPage()));
                              },
                            )
                          ],
                        ),
                      ),


                      SizedBox(
                        height:
                        ConstantWidget.getScreenPercentSize(context, 3),
                      ),

                      Container(

                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: addressList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child:  Container(

                                  margin: EdgeInsets.only(bottom:ConstantWidget.getWidthPercentSize(
                                      context,3) ),
                                  padding: EdgeInsets.all(ConstantWidget.getPercentSize(
                                      cellHeight,10 )),
                                  decoration: BoxDecoration(
                                      color: ConstantData.bgColor,
                                      borderRadius: BorderRadius.circular(ConstantWidget.getPercentSize(
                                          cellHeight,10 )),
                                      border: Border.all(
                                          color: ConstantData.borderColor,
                                          width: ConstantWidget.getWidthPercentSize(
                                              context, 0.08)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                        )
                                      ]),

                                  height:
                                  cellHeight,

                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [

                                                    ConstantWidget.getCustomTextWithoutAlign(addressList[index].name,
                                                        ConstantData.mainTextColor, FontWeight.w700, ConstantWidget.getPercentSize(cellHeight,
                                                            20)),

                                                    Padding(
                                                      padding:
                                                      EdgeInsets.only(
                                                          top: (topMargin/2)),

                                                      child:ConstantWidget.getCustomTextWithoutAlign(addressList[index].location,
                                                          ConstantData.textColor, FontWeight.w500, ConstantWidget.getPercentSize(cellHeight,
                                                              15)),

                                                    )
                                                  ],
                                                ),
                                                new Spacer(),
                                                Align(
                                                  alignment:
                                                  Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                        right: 3),
                                                    child: Icon(
                                                      (index ==
                                                          _selectedAddress)
                                                          ? Icons
                                                          .radio_button_checked
                                                          : Icons
                                                          .radio_button_unchecked,
                                                      color: (index ==
                                                          _selectedAddress)
                                                          ? ConstantData
                                                          .primaryColor
                                                          : Colors.grey,
                                                      size: ConstantWidget.getPercentSize(cellHeight,
                                                          30),
                                                    ),
                                                  ),
                                                )
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
                                  _selectedAddress = index;
                                  setState(() {});
                                },
                              );
                            }),
                      ),


                      SizedBox(
                        height:
                        ConstantWidget.getScreenPercentSize(context, 3),
                      ),

                      Container(
                        child: Row(
                          children: [


                            ConstantWidget.getTextWidget(
                                S.of(context).paymentMethods,
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
                        ConstantWidget.getScreenPercentSize(context, 3),
                      ),



                      ListView.builder(
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
                                              new Spacer(),
                                              Align(
                                                alignment:
                                                Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      right: 3),
                                                  child: Icon(
                                                    (index ==
                                                        _selectedCard)
                                                        ? Icons
                                                        .radio_button_checked
                                                        : Icons
                                                        .radio_button_unchecked,
                                                    color: (index ==
                                                        _selectedCard)
                                                        ? ConstantData
                                                        .primaryColor
                                                        : Colors.grey,
                                                    size: ConstantWidget.getPercentSize(cellHeight,
                                                        30),
                                                  ),
                                                ),
                                              )
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
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
