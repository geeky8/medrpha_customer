import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';


class AddNewCardPage extends StatefulWidget {
  @override
  _AddNewCardPage createState() {
    return _AddNewCardPage();
  }
}

class _AddNewCardPage extends State<AddNewCardPage> {


  TextEditingController cardNumberController = new TextEditingController();
  TextEditingController cardHolderNameController = new TextEditingController();
  TextEditingController expDateController = new TextEditingController();
  TextEditingController cvvController = new TextEditingController();

  @override
  void initState() {
    super.initState();


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


    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).newCard),

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
              context, S.of(context).savedCards, () {
            Navigator.of(context).pop(true);
          }),

          body: Container(
            // margin: EdgeInsets.only(
            //    top: leftMargin),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [


                      // Padding(padding: EdgeInsets.symmetric(horizontal: leftMargin),child:  ReviewSlider(
                      //
                      //     optionStyle: TextStyle(
                      //       fontFamily: ConstantData.fontFamily,
                      //       fontSize: ConstantWidget.getScreenPercentSize(context, 1.5),
                      //       color: ConstantData.textColor,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     onChange: (index) {},
                      //     initialValue: 0,
                      //     isCash: false,
                      //
                      //     width: double.infinity,
                      //     options: [
                      //       S.of(context).personalInfo,
                      //       S.of(context).payment,
                      //       S.of(context).confirmation
                      //     ]),),


                      Container(
                        // margin: EdgeInsets.only(top: leftMargin),
                        padding: EdgeInsets.all(leftMargin),


                        child: Column(
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: (topMargin*2)),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //
                            //
                            //     child: ConstantWidget.getTextWidget(
                            //         S.of(context).payment,
                            //         ConstantData.mainTextColor,
                            //         TextAlign.start,
                            //         FontWeight.w800,
                            //         ConstantWidget.getScreenPercentSize(
                            //             context, 2.5)),
                            //
                            //
                            //
                            //   ),
                            // ),






                            ConstantWidget.getDefaultTextFiledWidget(
                                context, S.of(context).cardNumber, cardNumberController),
                            ConstantWidget.getDefaultTextFiledWidget(
                                context, S.of(context).cardHolderName, cardHolderNameController),
                            Row(
                              children: [
                                Expanded(child:  ConstantWidget.getDefaultTextFiledWidget(
                                    context, S.of(context).expDateHint, expDateController),flex: 1,),
                                SizedBox(width: ConstantWidget.getScreenPercentSize(context, 1),),
                                Expanded(child:  ConstantWidget.getDefaultTextFiledWidget(
                                    context, S.of(context).cvvHint, cvvController),flex: 1,)
                              ],
                            ),

                            // Container(
                            //   margin: EdgeInsets.only(bottom: (topMargin*2),top:topMargin),
                            //   height: editTextHeight,
                            //   child: TextField(
                            //     maxLines: 1,
                            //     controller: cardNumberController,
                            //     style: TextStyle(
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.mainTextColor,
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: ConstantData.font18Px),
                            //
                            //     decoration: InputDecoration(
                            //       enabledBorder:  OutlineInputBorder(
                            //         // width: 0.0 produces a thin "hairline" border
                            //         borderSide:  BorderSide(
                            //             color: ConstantData.textColor, width: 0.0),
                            //       ),
                            //
                            //       border: OutlineInputBorder(
                            //         borderSide:  BorderSide(
                            //             color: ConstantData.textColor, width: 0.0),
                            //       ),
                            //
                            //       labelStyle: TextStyle(
                            //           fontFamily: ConstantData.fontFamily,
                            //           color: ConstantData.textColor
                            //       ),
                            //       labelText: S.of(context).cardNumber,
                            //       // hintText: 'Full Name',
                            //     ),
                            //
                            //
                            //   ),
                            // ),
                            //
                            // Container(
                            //   margin: EdgeInsets.only(bottom: (topMargin*2)),
                            //   height: editTextHeight,
                            //
                            //   child: TextField(
                            //     maxLines: 1,
                            //     controller: cardHolderNameController,
                            //     style: TextStyle(
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.mainTextColor,
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: ConstantData.font18Px),
                            //
                            //     decoration: InputDecoration(
                            //       enabledBorder:  OutlineInputBorder(
                            //         // width: 0.0 produces a thin "hairline" border
                            //         borderSide:  BorderSide(
                            //             color: ConstantData.textColor, width: 0.0),
                            //       ),
                            //
                            //       border: OutlineInputBorder(
                            //         borderSide:  BorderSide(
                            //             color: ConstantData.textColor, width: 0.0),
                            //       ),
                            //
                            //       labelStyle: TextStyle(
                            //           fontFamily: ConstantData.fontFamily,
                            //           color: ConstantData.textColor
                            //       ),
                            //       labelText: S.of(context).cardHolderName,
                            //
                            //       // hintText: 'Full Name',
                            //     ),
                            //
                            //   ),
                            // ),
                            //
                            //
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         children: [
                            //
                            //           Container(
                            //             height: editTextHeight,
                            //             child: TextField(
                            //               controller: expDateController,
                            //               maxLines: 1,
                            //               style: TextStyle(
                            //                   fontFamily: ConstantData.fontFamily,
                            //                   color: ConstantData.mainTextColor,
                            //                   fontWeight: FontWeight.w400,
                            //                   fontSize: ConstantData.font18Px),
                            //
                            //               decoration: InputDecoration(
                            //                 enabledBorder:  OutlineInputBorder(
                            //                   // width: 0.0 produces a thin "hairline" border
                            //                   borderSide:  BorderSide(
                            //                       color: ConstantData.textColor, width: 0.0),
                            //                 ),
                            //
                            //                 border: OutlineInputBorder(
                            //                   borderSide:  BorderSide(
                            //                       color: ConstantData.textColor, width: 0.0),
                            //                 ),
                            //
                            //                 labelStyle: TextStyle(
                            //                     fontFamily: ConstantData.fontFamily,
                            //                     color: ConstantData.textColor
                            //                 ),
                            //                 labelText: S.of(context).expDateHint,
                            //                 // hintText: 'Full Name',
                            //               ),
                            //
                            //
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       flex: 1,
                            //     ),
                            //     Expanded(
                            //       child: Column(
                            //         children: [
                            //
                            //           Container(
                            //             margin: EdgeInsets.only(left: topMargin),
                            //
                            //             height: editTextHeight,
                            //             child: TextField(
                            //               maxLines: 1,
                            //               controller: cvvController,
                            //
                            //               style: TextStyle(
                            //                   fontFamily: ConstantData.fontFamily,
                            //                   color: ConstantData.mainTextColor,
                            //                   fontWeight: FontWeight.w400,
                            //                   fontSize: ConstantData.font18Px),
                            //
                            //               decoration: InputDecoration(
                            //                 enabledBorder:  OutlineInputBorder(
                            //                   // width: 0.0 produces a thin "hairline" border
                            //                   borderSide:  BorderSide(
                            //                       color: ConstantData.textColor, width: 0.0),
                            //                 ),
                            //
                            //                 border: OutlineInputBorder(
                            //                   borderSide:  BorderSide(
                            //                       color: ConstantData.textColor, width: 0.0),
                            //                 ),
                            //
                            //                 labelStyle: TextStyle(
                            //                     fontFamily: ConstantData.fontFamily,
                            //                     color: ConstantData.textColor
                            //                 ),
                            //                 labelText: S.of(context).cvvHint,
                            //                 // hintText: 'Full Name',
                            //               ),
                            //
                            //
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       flex: 1,
                            //     )
                            //   ],
                            // ),

                          ],
                        ),
                      )
                      ,









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


}
