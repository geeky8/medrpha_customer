import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_medical_ui/AddToCartPage.dart';
import 'package:flutter_medical_ui/SearchPage.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/EditDialog.dart';
import 'package:flutter_medical_ui/util/EditAddressDialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/PaymentSelectModel.dart';

import 'generated/l10n.dart';
import 'OrderStatus.dart';

class OrderSummary extends StatefulWidget {
  @override
  _OrderSummary createState() {
    return _OrderSummary();
  }
}

class _OrderSummary extends State<OrderSummary> {
  List<PaymentSelectModel> list = DataFile.getPaymentSelect();
  List<PickedFile> imageList = DataFile.getImageList();

  bool isCash = true;

  int selectPatientIndex = 1;
  int selectAddressIndex = 1;

  final picker = ImagePicker();

  _imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {

      imageList.add(image);
    });
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double image = ConstantWidget.getScreenPercentSize(context, 3);

    double height = ConstantWidget.getScreenPercentSize(context, 18);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            title: ConstantWidget.getAppBarText(S.of(context).orderSummary),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: SafeArea(
            child: Container(
                child: ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: leftMargin, bottom: leftMargin),
                  child: ConstantWidget.getTextWidget(
                      S.of(context).medicines,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),
                Row(
                  children: [
                    Expanded(
                        child: ConstantWidget.getEditButton(
                            context, S.of(context).editMedicine, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToCartPage(),
                          ));
                    })),
                    SizedBox(
                      width: leftMargin,
                    ),
                    Expanded(
                        child: ConstantWidget.getEditButton(
                            context, S.of(context).addMedicine, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPage(),
                          ));
                    })),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: leftMargin,

                      top: (leftMargin / 2)),
                  child: ConstantWidget.getTextWidget(
                      S.of(context).prescriptions,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),
                Container(
                    height: height,

                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: imageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return (index == 0)
                              ? getAddCell()
                              : getPatientCell(imageList[index]);
                        })),
                Padding(
                  padding: EdgeInsets.only(
                      left: leftMargin,
                      bottom: leftMargin,
                     ),
                  child: ConstantWidget.getTextWidget(
                      S.of(context).paymentMethods,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: leftMargin),
                  child: ListView.separated(
                    itemCount: list.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container(
                        height:
                            ConstantWidget.getScreenPercentSize(context, 0.02),
                        color: ConstantData.textColor,
                        margin: EdgeInsets.symmetric(vertical: (leftMargin)),
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: (leftMargin / 2)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  list[index].icon,
                                  color: ConstantData.textColor,
                                  size: leftMargin,
                                ),
                                SizedBox(
                                  width: leftMargin,
                                ),
                                ConstantWidget.getCustomText(
                                    list[index].name,
                                    ConstantData.textColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    ConstantWidget.getScreenPercentSize(
                                        context, 2.3)),
                                new Spacer(),
                                InkWell(
                                  child: Icon(
                                    (list[index].select == 1)
                                        ? CupertinoIcons
                                            .checkmark_alt_circle_fill
                                        : Icons.radio_button_off,
                                    color: (list[index].select == 1)
                                        ? Colors.orange
                                        : ConstantData.textColor,
                                    size: image,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      list[index].select = 1;

                                      if (index == 0) {
                                        list[1].select = 0;
                                      } else {
                                        list[0].select = 0;
                                      }

                                      if (list[0].select == 1) {
                                        isCash = true;
                                      } else {
                                        isCash = false;
                                      }
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),


                Container(

                  margin: EdgeInsets.symmetric(vertical: leftMargin),
                  color: ConstantData.cellColor,
                  padding: EdgeInsets.symmetric(vertical: leftMargin,horizontal: leftMargin),

                  child: Row(
                    children: [
                      ConstantWidget.getTextWidget("Estimate Delivery",
                          ConstantData.mainTextColor, TextAlign.start, FontWeight.w500, ConstantData.font22Px),
                      new Spacer(),
                      ConstantWidget.getTextWidget("24 - 25 May", ConstantData.mainTextColor, TextAlign.end, FontWeight.w500, ConstantData.font22Px),

                    ],
                  ),

                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: leftMargin,

                      top: (leftMargin / 2)),
                  child: ConstantWidget.getTextWidget(
                      S.of(context).deliverTo,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),

                Container(margin: EdgeInsets.symmetric(horizontal: leftMargin)
                  ,
                  child: ConstantWidget.getCustomText(DataFile.getAddressList()[0].location,
                      ConstantData.textColor, 2,TextAlign.start, FontWeight.w500, ConstantData.font18Px),

                ),


                SizedBox(height: (leftMargin/2),),



                ConstantWidget.getBottomText(
                    context, S.of(context).continueText, () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => OrderStatus(),));
                })
              ],
            )),
          ),
        ),
        onWillPop: _requestPop);
  }

  showAddressDialog(bool isEdit, var model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditAddressDialog(context, isEdit, model, (v) {
            setState(() {});
          });
        });
  }

  showPatientDialog(bool isEdit, var model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditDialog(context, isEdit, model, (v) {
            setState(() {});
          });
        });
  }

  getAddCell() {
    double width = ConstantWidget.getWidthPercentSize(context, 18);
    double sideMargin = MediaQuery.of(context).size.width * 0.04;
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double subHeight = ConstantWidget.getPercentSize(height, 28);

    return InkWell(
      child: Container(
        width: width,
        margin: EdgeInsets.only(left: sideMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.add_circled,
              color: ConstantData.accentColor,
              size: subHeight,
            ),
            SizedBox(
              height: ConstantWidget.getPercentSize(height, 2),
            ),
            ConstantWidget.getCustomText(
                S.of(context).addnimage,
                ConstantData.mainTextColor,
                2,
                TextAlign.center,
                FontWeight.w400,
                ConstantWidget.getPercentSize(height, 10)),
          ],
        ),
      ),
      onTap: () {
        _imgFromGallery();
      },
    );
  }

  getPatientCell(PickedFile file) {
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double width = ConstantWidget.getWidthPercentSize(context, 32);
    double sideMargin = MediaQuery.of(context).size.width * 0.04;
    double radius = ConstantWidget.getPercentSize(height, 18);
    double subHeight = ConstantWidget.getPercentSize(height, 25);

    return Container(
      width: width,
      height: height,
      child: Container(
        margin: EdgeInsets.only(left: (sideMargin/2)),
        padding: EdgeInsets.all((sideMargin / 1.2)),


        child: Stack(children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(radius),

              image: new DecorationImage(
                  image: new FileImage(new File(file.path)),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(child: Container(
              height: subHeight,
              width: subHeight,
              margin: EdgeInsets.only(right: 2),


              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                      color: ConstantData.accentColor,
                      width: ConstantWidget.getWidthPercentSize(context, 0.3   ))
              ),

              child: Center(
                child: Icon(Icons.close,color: ConstantData.accentColor,size: ConstantWidget.getPercentSize(subHeight, 50),),
              ),
            ),
            onTap: (){
              setState(() {
                imageList.remove(file);
              });
            },),
          )
        ]),
      ),
    );
  }
}
