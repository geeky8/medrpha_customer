import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/StepModel.dart';

import 'generated/l10n.dart';
import 'UploadPrescription.dart';

class PrescriptionSteps extends StatefulWidget {
  @override
  _PrescriptionSteps createState() {
    return _PrescriptionSteps();
  }
}

class _PrescriptionSteps extends State<PrescriptionSteps> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  List<StepModel> stepModelList = DataFile.getStepsModel();

  @override
  Widget build(BuildContext context) {
    ConstantData.setThemePosition();
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            centerTitle: true,
            title:
                ConstantWidget.getAppBarText(S.of(context).uploadPrescription),
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
                margin: EdgeInsets.all(
                    ConstantWidget.getScreenPercentSize(context, 2)),
                child: ListView(
                  children: [
                    ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).howPharmacyWork,
                        ConstantData.mainTextColor,
                        FontWeight.w700,
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 2.5),
                    ),
                    getList(),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 2.5),
                    ),
                    ConstantWidget.getCustomTextWithoutAlign(
                        S.of(context).validPrescriptionGuide,
                        ConstantData.mainTextColor,
                        FontWeight.w700,
                        ConstantWidget.getScreenPercentSize(context, 2.5)),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 1.5),
                    ),
                    getRow("Don't crop out of any part of the image"),
                    getRow("Avoid blurred image"),
                    getRow(
                        "Include details of doctor and patient + clinic visit date"),
                    getRow("Medicine will be dispensed as per prescription"),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 4),
                    ),
                    ConstantWidget.getBottomText(
                        context, S.of(context).next, () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPrescription(),));



                    }),

                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 4),
                    ),

                  ],
                )),
          ),
        ),
        onWillPop: _requestPop);
  }

  getRow(String s) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.brightness_1,
            color: ConstantData.textColor,
            size: ConstantWidget.getScreenPercentSize(context, 1.5),
          ),
          SizedBox(
            width: ConstantWidget.getScreenPercentSize(context, 1.5),
          ),
          ConstantWidget.getCustomTextWithoutAlign(
              s,
              ConstantData.textColor,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 1.7)),
        ],
      ),
    );
  }

  getList() {
    SizeConfig().init(context);

    double _crossAxisSpacing = 0;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 3;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = SizeConfig.safeBlockVertical * 22;
    var _aspectRatio = _width / cellHeight;

    var imgHeight = ConstantWidget.getPercentSize(cellHeight, 25);

    double remainSize = cellHeight -
        imgHeight -
        ConstantWidget.getScreenPercentSize(context, 1);

    return Container(
        child: GridView.count(
      crossAxisCount: _crossAxisCount,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      primary: false,
      mainAxisSpacing: ConstantWidget.getScreenPercentSize(context, 2),
      crossAxisSpacing: ConstantWidget.getScreenPercentSize(context, 1),
      childAspectRatio: _aspectRatio,
      children: List.generate(stepModelList.length, (index) {
        return InkWell(
          child: Container(
            padding:
                EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight, 5)),
            height: cellHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                   ConstantData.assetsPath
                    +stepModelList[index].image,
                    height: imgHeight,
                    width: imgHeight,
                    color: ConstantData.primaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ConstantWidget.getPercentSize(cellHeight, 8)),
                  child: ConstantWidget.getCustomText(
                      stepModelList[index].name.toUpperCase(),
                      ConstantData.mainTextColor,
                      1,
                      TextAlign.start,
                      FontWeight.bold,
                      ConstantWidget.getPercentSize(remainSize, 15)),
                ),



                Padding(
                  padding: EdgeInsets.only(
                      top: ConstantWidget.getPercentSize(cellHeight, 3)),
                  child: ConstantWidget.getSpaceTextWidgetWithMaxLine(
                      stepModelList[index].desc,
                      ConstantData.textColor,
                      TextAlign.center,
                      2,
                      FontWeight.w300,
                      ConstantWidget.getPercentSize(remainSize, 12)),
                )



              ],
            ),
          ),
          onTap: () {},
        );
      }),
    ));
  }
}
