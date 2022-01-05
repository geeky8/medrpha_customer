import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';

class AddNewAddressPage extends StatefulWidget {


  @override
  _AddNewAddressPage createState() {
    return _AddNewAddressPage();
  }
}

class _AddNewAddressPage extends State<AddNewAddressPage> {
  int _selectedRadio = 0;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController zipController = new TextEditingController();
  TextEditingController addController = new TextEditingController();

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
    double topMargin = ConstantWidget.getScreenPercentSize(context, 1);


    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).address),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),

          bottomNavigationBar:
              ConstantWidget.getBottomText(context, S.of(context).save, () {
            Navigator.of(context).pop(true);
          }),




          body: Container(

            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(leftMargin),

                        child: Column(
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: (topMargin * 2)),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: ConstantWidget.getTextWidget(
                            //         S.of(context).deliverTo,
                            //         ConstantData.mainTextColor,
                            //         TextAlign.start,
                            //         FontWeight.w800,
                            //         ConstantWidget.getScreenPercentSize(
                            //             context, 2.5)),
                            //   ),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.only(
                            //       bottom: (topMargin * 2), top: topMargin),
                            //   height: editTextHeight,
                            //   child: TextField(
                            //     maxLines: 1,
                            //     controller: nameController,
                            //     style: TextStyle(
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.mainTextColor,
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: ConstantData.font18Px),
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
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.textColor
                            //       ),
                            //       labelText: 'Full Name',
                            //
                            //       // hintText: 'Full Name',
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.only(bottom: (topMargin * 2)),
                            //   height: editTextHeight,
                            //   child: TextField(
                            //     maxLines: 1,
                            //     controller: phoneNumberController,
                            //     keyboardType: TextInputType.number,
                            //     style: TextStyle(
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.mainTextColor,
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: ConstantData.font18Px),
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
                            //       labelText: 'Phone Number',
                            //       // hintText: 'Full Name',
                            //     ),
                            //   ),
                            // ),

                            ConstantWidget.getDefaultTextFiledWidget(
                                context, S.of(context).yourName, nameController),
                            ConstantWidget.getDefaultTextFiledWidget(
                                context, S.of(context).phoneNumber, phoneNumberController),


                            Row(
                              children: [
                                Expanded(child:  ConstantWidget.getDefaultTextFiledWidget(
                                    context, S.of(context).cityDistrict, cityController),flex: 1,),
SizedBox(width: ConstantWidget.getScreenPercentSize(context, 1),),
                                Expanded(child:  ConstantWidget.getDefaultTextFiledWidget(
                                    context, S.of(context).zip, zipController),flex: 1,)
                              ],
                            ),

                            ConstantWidget.getPrescriptionDesc(
                                context, S.of(context).address, addController),


                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Column(
                            //         children: [
                            //           Container(
                            //             margin: EdgeInsets.only(
                            //                 bottom: (topMargin * 2)),
                            //             height: editTextHeight,
                            //             child: TextField(
                            //               controller: cityController,
                            //               maxLines: 1,
                            //               style: TextStyle(
                            //                   fontFamily:
                            //                       ConstantData.fontFamily,
                            //                   color:
                            //                       ConstantData.mainTextColor,
                            //                   fontWeight: FontWeight.w400,
                            //                   fontSize: ConstantData.font18Px),
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
                            //                 labelText:
                            //                     S.of(context).cityDistrict,
                            //                 // hintText: 'Full Name',
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       flex: 1,
                            //     ),
                            //     Expanded(
                            //       child: Column(
                            //         children: [
                            //           Container(
                            //             margin: EdgeInsets.only(
                            //                 bottom: (topMargin * 2),
                            //                 left: topMargin),
                            //             height: editTextHeight,
                            //             child: TextField(
                            //               maxLines: 1,
                            //               controller: zipController,
                            //               style: TextStyle(
                            //                   fontFamily:
                            //                       ConstantData.fontFamily,
                            //                   color:
                            //                       ConstantData.mainTextColor,
                            //                   fontWeight: FontWeight.w400,
                            //                   fontSize: ConstantData.font18Px),
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
                            //                 labelText: S.of(context).zip,
                            //                 // hintText: 'Full Name',
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       flex: 1,
                            //     )
                            //   ],
                            // ),
                            // Container(
                            //   margin: EdgeInsets.only(bottom: (topMargin * 2)),
                            //   height: editTextHeight,
                            //   child: TextField(
                            //     maxLines: 1,
                            //     controller: addController,
                            //     style: TextStyle(
                            //         fontFamily: ConstantData.fontFamily,
                            //         color: ConstantData.mainTextColor,
                            //         fontWeight: FontWeight.w400,
                            //         fontSize: ConstantData.font18Px),
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
                            //       labelText: S.of(context).address,
                            //       // hintText: 'Full Name',
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: topMargin, bottom: topMargin),
                              child: _radioView(S.of(context).houseApartment,
                                  (_selectedRadio == 0), 0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: topMargin, bottom: topMargin),
                              child: _radioView(S.of(context).agencyCompany,
                                  (_selectedRadio == 1), 1),
                            ),
                          ],
                        ),
                      )
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

  Widget _radioView(String s, bool isSelected, int position) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelected
                ? ConstantData.textColor
                : Colors.grey,
            size: ConstantWidget.getScreenPercentSize(context, 2),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: ConstantWidget.getScreenPercentSize(context, 2.5)),
            child: Text(
              s,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: ConstantData.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: ConstantData.font18Px,
                  color: ConstantData.mainTextColor),
            ),
          )
        ],
      ),
      onTap: () {
        if (position != _selectedRadio) {
          if (_selectedRadio == 0) {
            _selectedRadio = 1;
          } else {
            _selectedRadio = 0;
          }
        }
        setState(() {});
      },
    );
  }
}
