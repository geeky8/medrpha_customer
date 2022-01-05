import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'AddNewAddressPage.dart';
import 'generated/l10n.dart';
import 'model/AddressModel.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressPage createState() {
    return _ShippingAddressPage();
  }
}

class _ShippingAddressPage extends State<ShippingAddressPage> {
  List<AddressModel> addressList = DataFile.getAddressList();

  int _selectedAddress = 0;

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double cellHeight = MediaQuery.of(context).size.width *0.2;
    double topMargin = ConstantWidget.getScreenPercentSize(context, 1);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).shippingAddress),


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
              margin: EdgeInsets.only(



                  bottom: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [



                  Container(
                    margin: EdgeInsets.only(top: (defaultMargin)),
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
                        // Container(
                        //   color: ConstantData.mainTextColor,
                        //   height: ConstantWidget.getScreenPercentSize(
                        //       context, 0.02),
                        // ),


                        // Container(
                        //
                        //   child: ListView.builder(
                        //       shrinkWrap: true,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       itemCount: addressList.length,
                        //       itemBuilder: (context, index) {
                        //         return InkWell(
                        //           child: Column(
                        //             children: [
                        //               Container(
                        //                 height:
                        //                 cellHeight,
                        //
                        //                 child: Column(
                        //                   mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //                   crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //                   children: [
                        //                     Row(
                        //                       children: [
                        //                         Expanded(
                        //                           child: Row(
                        //                             mainAxisAlignment:
                        //                             MainAxisAlignment.start,
                        //                             crossAxisAlignment:
                        //                             CrossAxisAlignment.center,
                        //                             children: [
                        //                               Column(
                        //                                 mainAxisAlignment:
                        //                                 MainAxisAlignment
                        //                                     .start,
                        //                                 crossAxisAlignment:
                        //                                 CrossAxisAlignment
                        //                                     .start,
                        //                                 children: [
                        //
                        //                                   ConstantWidget.getCustomTextWithoutAlign(addressList[index].name,
                        //                                       ConstantData.mainTextColor, FontWeight.w700, ConstantWidget.getPercentSize(cellHeight,
                        //                                           20)),
                        //
                        //                                   Padding(
                        //                                     padding:
                        //                                     EdgeInsets.only(
                        //                                         top: (topMargin/2)),
                        //
                        //                                     child:ConstantWidget.getCustomTextWithoutAlign(addressList[index].location,
                        //                                         ConstantData.textColor, FontWeight.w500, ConstantWidget.getPercentSize(cellHeight,
                        //                                             15)),
                        //
                        //                                   )
                        //                                 ],
                        //                               ),
                        //                               new Spacer(),
                        //                               Align(
                        //                                 alignment:
                        //                                 Alignment.centerRight,
                        //                                 child: Padding(
                        //                                   padding:
                        //                                   EdgeInsets.only(
                        //                                       right: 3),
                        //                                   child: Icon(
                        //                                     (index ==
                        //                                         _selectedAddress)
                        //                                         ? Icons
                        //                                         .radio_button_checked
                        //                                         : Icons
                        //                                         .radio_button_unchecked,
                        //                                     color: (index ==
                        //                                         _selectedAddress)
                        //                                         ? ConstantData
                        //                                         .textColor
                        //                                         : Colors.grey,
                        //                                     size: ConstantWidget.getPercentSize(cellHeight,
                        //                                         25),
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                             ],
                        //                           ),
                        //                           flex: 1,
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Visibility(child: Container(
                        //                 height: ConstantWidget.getScreenPercentSize(context,0.02),
                        //                 color: ConstantData.textColor,
                        //                 margin: EdgeInsets.only(bottom: topMargin),
                        //               ),visible: (index != (addressList.length-1)),)
                        //
                        //             ],
                        //           ),
                        //           onTap: () {
                        //             _selectedAddress = index;
                        //             setState(() {});
                        //           },
                        //         );
                        //       }),
                        // )

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
                                                            .textColor
                                                            : Colors.grey,
                                                        size: ConstantWidget.getPercentSize(cellHeight,
                                                            25),
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
                        )


                        ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
