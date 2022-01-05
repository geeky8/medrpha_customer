import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';

import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/EditDialog.dart';
import 'package:flutter_medical_ui/util/EditAddressDialog.dart';

import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/AddressModel.dart';
import 'package:flutter_medical_ui/model/PatientModel.dart';
import 'package:flutter_medical_ui/model/PaymentSelectModel.dart';

import 'generated/l10n.dart';
import 'OrderSummary.dart';

class SelectPrescriptionAddress extends StatefulWidget {
  @override
  _SelectPrescriptionAddress createState() {
    return _SelectPrescriptionAddress();
  }
}

class _SelectPrescriptionAddress extends State<SelectPrescriptionAddress> {
  List<PatientModel> patientList = DataFile.getPatientList();
  List<AddressModel> addressList = DataFile.getHomeAddressList();

  List<PaymentSelectModel> list = DataFile.getPaymentSelect();

  bool isCash = true;

  int selectPatientIndex = 1;
  int selectAddressIndex = 1;

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
            title: ConstantWidget.getAppBarText(
                S.of(context).selectPatientAddress),
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
                      S.of(context).patient,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),
                Container(
                    height: height,
                    margin: EdgeInsets.only(bottom: leftMargin),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: patientList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          PatientModel model = patientList[index];

                          return (index == 0)
                              ? getAddCell(model.name, () {
                                  showPatientDialog(false, model);
                                })
                              : getPatientCell(model.name, model.type,
                                  (selectPatientIndex == index), () {
                                  setState(() {
                                    selectPatientIndex = index;
                                  });
                                }, () {
                                  showPatientDialog(true, model);
                                });
                        })),
                Padding(
                  padding: EdgeInsets.only(
                      left: leftMargin,
                      bottom: leftMargin,
                      top: (leftMargin / 2)),
                  child: ConstantWidget.getTextWidget(
                      S.of(context).address,
                      ConstantData.mainTextColor,
                      TextAlign.start,
                      FontWeight.w800,
                      ConstantWidget.getScreenPercentSize(context, 2.5)),
                ),
                Container(
                    height: height,
                    margin: EdgeInsets.only(bottom: leftMargin),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: addressList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          AddressModel model = addressList[index];

                          return (index == 0)
                              ? getAddCell(model.name, () {
                                  showAddressDialog(false, model);
                                })
                              : getPatientCell(model.type, model.location,
                                  (selectAddressIndex == index), () {
                                  setState(() {
                                    selectAddressIndex = index;
                                  });
                                }, () {
                                  showAddressDialog(true, model);
                                });
                        })),
                Padding(
                  padding: EdgeInsets.only(
                      left: leftMargin,
                      bottom: leftMargin,
                      top: (leftMargin / 2)),
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
                SizedBox(
                  height: leftMargin,
                ),
                ConstantWidget.getBottomText(
                    context, S.of(context).continueText, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSummary(),
                      ));
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

  getAddCell(String s, Function function) {
    double width = ConstantWidget.getWidthPercentSize(context, 18);
    double sideMargin = MediaQuery.of(context).size.width * 0.04;
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double subHeight = ConstantWidget.getPercentSize(height, 30);

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
                s,
                ConstantData.mainTextColor,
                2,
                TextAlign.center,
                FontWeight.w400,
                ConstantWidget.getPercentSize(height, 10)),
          ],
        ),
      ),
      onTap: function,
    );
  }

  getPatientCell(String s, String s1, bool isSelect, Function function,
      Function editFunction) {
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double width = ConstantWidget.getWidthPercentSize(context, 50);
    double sideMargin = MediaQuery.of(context).size.width * 0.04;
    double radius = ConstantWidget.getPercentSize(height, 8);

    Color textColor = isSelect ? Colors.white : ConstantData.mainTextColor;
    return InkWell(
      child: Container(
        width: width,
        height: height,
        child: Container(
          margin: EdgeInsets.only(left: sideMargin),
          padding: EdgeInsets.all((sideMargin / 1.2)),
          decoration: BoxDecoration(
            color: isSelect ? ConstantData.accentColor : Colors.transparent,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
                color: isSelect
                    ? ConstantData.accentColor
                    : ConstantData.textColor,
                width: ConstantWidget.getWidthPercentSize(context, 0.08)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstantWidget.getCustomText(s, textColor, 1, TextAlign.start,
                  FontWeight.w500, ConstantWidget.getPercentSize(height, 15)),
              ConstantWidget.getCustomText(s1, textColor, 2, TextAlign.start,
                  FontWeight.w300, ConstantWidget.getPercentSize(height, 10)),
              new Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: ConstantWidget.getCustomText(
                        S.of(context).edit,
                        textColor,
                        1,
                        TextAlign.start,
                        FontWeight.w500,
                        ConstantWidget.getPercentSize(height, 10)),
                    onTap: editFunction,
                  ),
                  new Spacer(),
                  Visibility(
                    child: Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: Colors.white,
                    ),
                    visible: isSelect,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: function,
    );
  }
}
