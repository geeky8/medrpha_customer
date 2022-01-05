import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/AddNewCardPage.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'ProductDetailPage.dart';
import 'model/SubCategoryModel.dart';

class SubCategoriesPage extends StatefulWidget {
  @override
  _SubCategoriesPage createState() {
    return _SubCategoriesPage();
  }
}

class _SubCategoriesPage extends State<SubCategoriesPage> {
  List<SubCategoryModel> subCategoryModelList = DataFile.getSubCategoryModel();

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
    double margin = ConstantWidget.getScreenPercentSize(context, 1.7);

    var _crossAxisSpacing = 1;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;

    var cellHeight = SizeConfig.safeBlockVertical * 36;

    // var cellHeight = SizeConfig.safeBlockVertical * 27;
    var _aspectRatio = _width / cellHeight;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).categories),
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
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.01),
                  padding: EdgeInsets.symmetric(horizontal: margin),
                  child: GridView.count(
                    crossAxisCount: _crossAxisCount,
                    shrinkWrap: true,
                    childAspectRatio: _aspectRatio,
                    mainAxisSpacing: margin,
                    crossAxisSpacing: margin,
                    // childAspectRatio: 0.64,
                    primary: false,
                    children:
                        List.generate(subCategoryModelList.length, (index) {
                      return new BackGroundTile(
                        subCategoryModel: subCategoryModelList[index],
                        cellHeight: cellHeight,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}

class BackGroundTile extends StatelessWidget {
  final SubCategoryModel subCategoryModel;
  final double cellHeight;

  BackGroundTile({this.subCategoryModel, this.cellHeight});

  @override
  Widget build(BuildContext context) {
    double imageSize = ConstantWidget.getPercentSize(cellHeight, 56);
    double subHeight = ConstantWidget.getPercentSize(imageSize, 25);
    double topCellHeight = ConstantWidget.getPercentSize(cellHeight, 12);
    double radius = ConstantWidget.getPercentSize(cellHeight, 5);
    double bottomRemainSize = cellHeight - imageSize - topCellHeight;

    // return InkWell(
    //   child: Container(
    //     height: cellHeight,
    //     margin: EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight, 2)),
    //     decoration: BoxDecoration(
    //         color: ConstantData.cellColor,
    //         borderRadius: BorderRadius.circular(radius),
    //         boxShadow: [
    //           BoxShadow(
    //             color: ConstantData.shadowColor,
    //             // blurRadius: 10,
    //           )
    //         ]),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Container(
    //           height: imageSize,
    //           width: double.infinity,
    //           margin: EdgeInsets.only(
    //               left: ConstantWidget.getPercentSize(imageSize, 6),
    //               right: ConstantWidget.getPercentSize(imageSize, 6),
    //               top: ConstantWidget.getPercentSize(imageSize, 6)),
    //           padding:
    //               EdgeInsets.all(ConstantWidget.getPercentSize(imageSize, 5)),
    //           decoration: BoxDecoration(
    //             shape: BoxShape.rectangle,
    //             color: ConstantData.cellColor,
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(radius),
    //             ),
    //             image: DecorationImage(
    //               image: ExactAssetImage(
    //                   ConstantData.assetsPath + subCategoryModel.image),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           child: Align(alignment: Alignment.topRight,
    //           child: Container(
    //             height: subHeight,
    //             width: subHeight,
    //
    //             decoration: BoxDecoration(
    //               shape: BoxShape.rectangle,
    //               color: Colors.redAccent,
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(radius),
    //               ),
    //             ),
    //
    //             child: Center(child: Icon((subCategoryModel.isFav==0)?Icons.favorite_border:Icons.favorite,color: Colors.white,size: ConstantWidget.getPercentSize(subHeight,50),),),
    //           ),),
    //         ),
    //         Expanded(
    //             child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               ConstantWidget.getCustomText(
    //                   subCategoryModel.name,
    //                   ConstantData.textColor,
    //                   1,
    //                   TextAlign.center,
    //                   FontWeight.w400,
    //                   ConstantWidget.getPercentSize(bottomRemainSize, 17)),
    //               Padding(
    //                 padding: EdgeInsets.only(
    //                   top: ConstantWidget.getPercentSize(cellHeight, 2),
    //                 ),
    //                 child: ConstantWidget.getCustomText(
    //                     subCategoryModel.price,
    //                     ConstantData.mainTextColor,
    //                     1,
    //                     TextAlign.center,
    //                     FontWeight.w700,
    //                     ConstantWidget.getPercentSize(bottomRemainSize, 22)),
    //               ),
    //               //
    //               // Visibility(child: ConstantWidget.getCustomText(
    //               //     (subCategoryModel.offPrice==null)?"":subCategoryModel.offPrice,
    //               //     ConstantData.textColor,
    //               //     1,
    //               //     TextAlign.center,
    //               //     FontWeight.w300,
    //               //     ConstantWidget.getPercentSize(bottomRemainSize, 15)),visible:  (subCategoryModel.offPrice!=null || subCategoryModel.offPrice.isEmpty),)
    //             ],
    //           ),
    //         ))
    //       ],
    //     ),
    //   ),
    //   onTap: () {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => ProductDetailPage(subCategoryModel)));
    //   },
    // );
    return InkWell(
      child: Container(
        height: cellHeight,
        margin: EdgeInsets.all(ConstantWidget.getPercentSize(cellHeight, 1)),
        decoration: BoxDecoration(
            color: ConstantData.bgColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
                color: ConstantData.borderColor,
                width: ConstantWidget.getWidthPercentSize(context, 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
              )
            ]),
        // decoration: BoxDecoration(
        //     color: ConstantData.cellColor,
        //     borderRadius: BorderRadius.circular(radius),
        //     boxShadow: [
        //       BoxShadow(
        //         color: ConstantData.shadowColor,
        //         // blurRadius: 10,
        //       )
        //     ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: imageSize,
              width: double.infinity,
              margin: EdgeInsets.only(
                  left: ConstantWidget.getPercentSize(imageSize, 6),
                  right: ConstantWidget.getPercentSize(imageSize, 6),
                  top: ConstantWidget.getPercentSize(imageSize, 6)),
              padding:
                  EdgeInsets.all(ConstantWidget.getPercentSize(imageSize, 5)),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: ConstantData.cellColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
                image: DecorationImage(
                  image: ExactAssetImage(
                      ConstantData.assetsPath + subCategoryModel.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: subHeight,
                  width: subHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      (subCategoryModel.isFav == 0)
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Colors.white,
                      size: ConstantWidget.getPercentSize(subHeight, 50),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: ConstantWidget.getPercentSize(imageSize, 6)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstantWidget.getCustomText(
                              subCategoryModel.name,
                              ConstantData.textColor,
                              1,
                              TextAlign.center,
                              FontWeight.w500,
                              ConstantWidget.getPercentSize(
                                  bottomRemainSize, 17)),

                          SizedBox(
                            height:
                                ConstantWidget.getPercentSize(cellHeight, 1),
                          ),
                          ConstantWidget.getCustomText(
                              subCategoryModel.desc,
                              Colors.grey,
                              1,
                              TextAlign.center,
                              FontWeight.w400,
                              ConstantWidget.getPercentSize(
                                  bottomRemainSize, 13)),

                          Padding(
                            padding: EdgeInsets.only(
                              top: ConstantWidget.getPercentSize(cellHeight, 1),
                            ),
                            child: Row(
                              children: [
                                ConstantWidget.getCustomText(
                                    subCategoryModel.price,
                                    ConstantData.mainTextColor,
                                    1,
                                    TextAlign.center,
                                    FontWeight.w700,
                                    ConstantWidget.getPercentSize(
                                        bottomRemainSize, 20)),
                                ConstantWidget.getLineTextView(
                                    subCategoryModel.offPrice,
                                    Colors.grey,
                                    ConstantWidget.getPercentSize(
                                        bottomRemainSize, 15)),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     top: ConstantWidget.getPercentSize(cellHeight, 2),
                          //   ),
                          //   child: ConstantWidget.getCustomText(
                          //       subCategoryModel.price,
                          //       ConstantData.mainTextColor,
                          //       1,
                          //       TextAlign.center,
                          //       FontWeight.w700,
                          //       ConstantWidget.getPercentSize(bottomRemainSize, 22)),
                          // ),
                          //
                          // Visibility(child: ConstantWidget.getCustomText(
                          //     (subCategoryModel.offPrice==null)?"":subCategoryModel.offPrice,
                          //     ConstantData.textColor,
                          //     1,
                          //     TextAlign.center,
                          //     FontWeight.w300,
                          //     ConstantWidget.getPercentSize(bottomRemainSize, 15)),visible:  (subCategoryModel.offPrice!=null || subCategoryModel.offPrice.isEmpty),)
                        ],
                      ),
                    )))
          ],
        ),
      ),
      // onTap: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => ProductDetailPage(AddNewCardPage)));
      // },
    );
  }
}
