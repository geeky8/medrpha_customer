
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';
import 'package:flutter_medical_ui/model/CategoryModel.dart';

import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'SubCategoriesPage.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPage createState() {
    return _CategoriesPage();
  }
}

class _CategoriesPage extends State<CategoriesPage> {
  List<CategoryModel> categoryModelList = DataFile.getAllCategoryModel();
  int colorIndex = -1;

  @override
  void initState() {
    super.initState();
    categoryModelList = DataFile.getAllCategoryModel();
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
    var cellHeight = ConstantWidget.getScreenPercentSize(context, 11.5);
    // var cellHeight = _width;

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
                    mainAxisSpacing: (margin / 1.5),
                    crossAxisSpacing: (margin / 1.5),
                    // childAspectRatio: 0.64,
                    primary: false,
                    children: List.generate(categoryModelList.length, (index) {
                      if (colorIndex == (ConstantData.colorList().length - 1)) {
                        colorIndex = 0;
                      } else {
                        colorIndex++;
                      }

                      return new BackGroundTile(
                        subCategoryModel: categoryModelList[index],
                        cellHeight: cellHeight,
                        colorIndex: colorIndex,
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
  final CategoryModel subCategoryModel;
  final double cellHeight;
  final int colorIndex;

  BackGroundTile({this.subCategoryModel, this.cellHeight, this.colorIndex});

  @override
  Widget build(BuildContext context) {
    double imageSize = ConstantWidget.getPercentSize(cellHeight, 70);
    double radius = ConstantWidget.getPercentSize(cellHeight, 10);


    return InkWell(
      child: Container(
        height: cellHeight,
        padding: EdgeInsets.symmetric(
            horizontal: ConstantWidget.getPercentSize(cellHeight, 10)),
        decoration: BoxDecoration(
            color: ConstantData.cellColor,
            borderRadius: BorderRadius.circular(radius),

        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  EdgeInsets.all(ConstantWidget.getPercentSize(imageSize, 25)),
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                color: ConstantData.colorList()[colorIndex],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  ConstantData.assetsPath + subCategoryModel.icon,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: ConstantWidget.getPercentSize(imageSize, 8),
            ),
            Expanded(child: ConstantWidget.getCustomText(
                subCategoryModel.name,
                ConstantData.mainTextColor,
                2,
                TextAlign.start,
                FontWeight.w500,
                ConstantWidget.getPercentSize(cellHeight, 15)))
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Container(
        //       height: imageSize,
        //       width: double.infinity,
        //       margin: EdgeInsets.only(
        //           left: ConstantWidget.getPercentSize(imageSize, 9),
        //           right: ConstantWidget.getPercentSize(imageSize, 9),
        //           top: ConstantWidget.getPercentSize(imageSize, 9)),
        //       padding: EdgeInsets.all(
        //           ConstantWidget.getPercentSize(imageSize, 25)),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.rectangle,
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(radius),
        //         ),
        //
        //           image: DecorationImage(
        //               image: AssetImage(ConstantData.assetsPath + subCategoryModel.image),
        //               fit: BoxFit.cover)
        //
        //       ),
        //
        //     ),
        //
        //     Expanded(child: Container(
        //      height: bottomRemainSize,
        //       child: Center(
        //       child: ConstantWidget.getCustomText(
        //           subCategoryModel.name,
        //           ConstantData.mainTextColor,
        //           1,
        //           TextAlign.center,
        //           FontWeight.w800,
        //           ConstantWidget.getPercentSize(bottomRemainSize, 20)),
        //     ),))
        //
        //   ],
        // ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubCategoriesPage()));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => SubCategoriesPage(subCategoryModel.id)));
      },
    );
  }
}
