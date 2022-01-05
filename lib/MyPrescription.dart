
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/UploadPrescription.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';

import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/PrescriptionModel.dart';

import 'generated/l10n.dart';

class MyPrescription extends StatefulWidget {
  @override
  _MyPrescription createState() {
    return _MyPrescription();
  }
}

class _MyPrescription extends State<MyPrescription> {
  List<PrescriptionModel> modelList = DataFile.getPrescriptionList();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();




    double height = ConstantWidget.getScreenPercentSize(context, 15);
    double imageSize = ConstantWidget.getPercentSize(height, 80);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);
    double radius = ConstantWidget.getScreenPercentSize(context, 1.5);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            centerTitle: true,
            title: ConstantWidget.getAppBarText(S.of(context).myPrescription),
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
                margin: EdgeInsets.symmetric(
                    horizontal:
                        ConstantWidget.getScreenPercentSize(context, 2)),
                child: Column(
                  children: [
                    Expanded(child: ListView.builder(
                      itemCount: modelList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        PrescriptionModel subCategoryModel = modelList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(
                                color: ConstantData.borderColor,
                                width: ConstantWidget.getWidthPercentSize(
                                    context, 0.08)),
                          ),
                          margin: EdgeInsets.only(top: margin, bottom: margin),
                          height: height,
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: imageSize,
                                  width: imageSize,
                                  margin: EdgeInsets.all(margin),
                                  padding: EdgeInsets.all((margin / 5)),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: ConstantData.bgColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(radius),
                                    ),
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          ConstantData.assetsPath +
                                              subCategoryModel.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: (margin * 1.2)),
                                  // child: Row(
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: ConstantWidget.getPercentSize(
                                                height, 3),
                                          ),
                                          ConstantWidget.getCustomText(
                                              subCategoryModel.name,
                                              Colors.grey,
                                              1,
                                              TextAlign.start,
                                              FontWeight.w800,
                                              ConstantWidget.getPercentSize(
                                                  height, 14)),
                                          SizedBox(
                                            height: ConstantWidget.getPercentSize(
                                                height, 3),
                                          ),
                                          Row(
                                            children: [
                                              ConstantWidget.getCustomText(
                                                  subCategoryModel.date,
                                                  ConstantData.mainTextColor,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.w500,
                                                  ConstantWidget.getPercentSize(
                                                      height, 14)),
                                              SizedBox(
                                                width: ConstantWidget
                                                    .getWidthPercentSize(
                                                    context, 0.5),
                                              ),
                                              ConstantWidget.getCustomText(
                                                  subCategoryModel.time,
                                                  Colors.grey,
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.w500,
                                                  ConstantWidget.getPercentSize(
                                                      height, 12))
                                            ],
                                          ),
                                          new Spacer(),
                                          Row(
                                            children: [
                                              ConstantWidget.getCustomText(
                                                  subCategoryModel.type,
                                                  ConstantData.getPrescriptionColor(
                                                      subCategoryModel.type),
                                                  1,
                                                  TextAlign.start,
                                                  FontWeight.w500,
                                                  ConstantWidget.getPercentSize(
                                                      height, 14)),
                                              new Spacer()
                                            ],
                                          ),
                                          SizedBox(
                                            height: ConstantWidget.getPercentSize(
                                                height, 3),
                                          ),
                                        ],
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child:Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child:  InkWell(
                                              child: Icon(
                                                CupertinoIcons.delete,
                                                color: ConstantData.accentColor,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  modelList.remove(subCategoryModel);
                                                });
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),),
                    ConstantWidget.getBottomText(context, S.of(context).addNew, (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPrescription(),));
                    })
                  ],
                )),
          ),
        ),
        onWillPop: _requestPop);
  }
}
