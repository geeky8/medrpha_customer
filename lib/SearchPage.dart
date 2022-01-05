import 'package:flutter/material.dart';

import 'package:flutter_medical_ui/ProductDetailPage.dart';
import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';
import 'FilterPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  List<SubCategoryModel> productList = DataFile.getSubCategoryModel();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.safeBlockVertical * 8;
    double imageSize = SizeConfig.safeBlockVertical * 8;

    double imageSize1 = ConstantWidget.getPercentSize(imageSize, 50);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).search),
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
            padding: EdgeInsets.symmetric(vertical: margin),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: (margin * 1.5)),
                          height: height,
                          padding: EdgeInsets.only(left: (margin / 2)),
                          decoration: BoxDecoration(
                              color: ConstantData.cellColor,
                              borderRadius: BorderRadius.circular(
                                  ConstantWidget.getPercentSize(imageSize, 10)),
                              boxShadow: [
                                BoxShadow(
                                  color: ConstantData.shadowColor,
                                )
                              ]),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: ConstantData.textColor,
                                size: ConstantWidget.getPercentSize(height, 40),
                              ),
                              SizedBox(
                                width: ConstantWidget.getScreenPercentSize(
                                    context, 1),
                              ),
                              Expanded(
                                  child: TextField(
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: ConstantData.fontFamily,
                                    color: ConstantData.mainTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: ConstantData.font18Px),
                                decoration: InputDecoration(
                                  hintText: S.of(context).typeHere,
                                  hintStyle: TextStyle(
                                      fontFamily: ConstantData.fontFamily,
                                      color: ConstantData.mainTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: ConstantData.font18Px),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              )),
                              SizedBox(
                                width: ConstantWidget.getScreenPercentSize(
                                    context, 1),
                              ),
                              InkWell(
                                child: Container(
                                    height: imageSize,
                                    margin: EdgeInsets.symmetric(
                                        vertical: ConstantWidget.getPercentSize(
                                            imageSize, 12)),
                                    padding: EdgeInsets.all(
                                        ConstantWidget.getPercentSize(
                                            imageSize, 10)),
                                    decoration: BoxDecoration(
                                        color: ConstantData.bgColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ConstantWidget.getPercentSize(
                                                    imageSize, 10)))),
                                    child: Row(
                                      children: [
                                        ConstantWidget.getCustomText(
                                            S.of(context).filter,
                                            ConstantData.mainTextColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w800,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.9)),
                                        SizedBox(
                                          width: ConstantWidget
                                              .getScreenPercentSize(context, 1),
                                        ),
                                        Center(
                                            child: Icon(
                                          Icons.filter_list,
                                          color: ConstantData.mainTextColor,
                                          size: imageSize1,
                                        )),
                                      ],
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FilterPage(),
                                      ));
                                },
                              ),
                              SizedBox(
                                width: ConstantWidget.getScreenPercentSize(
                                    context, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return getSearchCell(productList[index], index);
                      }),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget getSearchCell(SubCategoryModel model, int index) {
    double imageSize = SizeConfig.safeBlockVertical * 8;
    double radius = ConstantWidget.getPercentSize(imageSize, 15);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);

    return InkWell(
      child: Container(
        color: ConstantData.viewColor,
        margin: EdgeInsets.symmetric(vertical: (margin / 4)),

        child: Stack(
          children: [


            Visibility(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  color: ConstantData.accentColor,
                  padding: EdgeInsets.all(margin / 4),


                  child: ConstantWidget.getCustomText(
                      (model.offer != null)
                          ? model.offer
                          : "",
                      Colors.white,
                      // ConstantData.accentColor,
                      1,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantData.font18Px),
                ),
              ),
              visible:
              (model.offer.isNotEmpty),
            ),


           Container(
             padding: EdgeInsets.symmetric(
                 horizontal: (margin / 2), vertical: ((margin / 2))),
             child:  Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   children: [
                     Container(
                       height: imageSize,
                       width: imageSize,
                       decoration: BoxDecoration(
                         shape: BoxShape.rectangle,
                         color: ConstantData.cellColor,
                         borderRadius: BorderRadius.all(
                           Radius.circular((radius / 1.5)),
                         ),
                         image: DecorationImage(
                           image: ExactAssetImage(
                               ConstantData.assetsPath + model.image),
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),

                     SizedBox(width: (margin/2),),
                     Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             ConstantWidget.getCustomText(
                                 model.name,
                                 ConstantData.mainTextColor,
                                 1,
                                 TextAlign.start,
                                 FontWeight.w800,
                                 ConstantWidget.getScreenPercentSize(context, 2.6)),
                             ConstantWidget.getCustomText(
                                 productList[index].desc,
                                 Colors.grey,
                                 1,
                                 TextAlign.start,
                                 FontWeight.w500,
                                 ConstantWidget.getScreenPercentSize(context, 1.8)),
                           ],
                         ))
                   ],
                 ),
                 SizedBox(
                   height: (margin*1.2),
                 ),
                 Row(
                   children: [
                     SizedBox(
                       width: imageSize,
                     ),

                     SizedBox(width: (margin/2),),
                     ConstantWidget.getCustomText(
                         model.price,
                         ConstantData.mainTextColor,
                         1,
                         TextAlign.start,
                         FontWeight.w500,
                         ConstantWidget.getScreenPercentSize(context, 2.3)),


                     ConstantWidget.getLineTextView(
                         model.offPrice,
                         Colors.grey,
                         ConstantWidget.getScreenPercentSize(context, 1.8)),
                     // SizedBox(
                     //   width:
                     //   ConstantWidget.getWidthPercentSize(context, 1),
                     // ),
                     // ConstantWidget.getCustomText(
                     //     model.offer,
                     //     ConstantData.primaryColor,
                     //     1,
                     //     TextAlign.start,
                     //     FontWeight.w400,
                     //     ConstantWidget.getScreenPercentSize(context, 2)),
                     //
                     // // new Spacer(),

                     Expanded(child: ConstantWidget.getCustomText(
                         S.of(context).addToCart.toUpperCase(),
                         ConstantData.accentColor,
                         2,
                         TextAlign.end,
                         FontWeight.w500,
                         ConstantWidget.getScreenPercentSize(context, 2)))

                   ],
                 )
               ],
             ),
           )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetailPage(model)));
      },
    );
  }
}
