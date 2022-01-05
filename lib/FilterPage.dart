import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/ProductDetailPage.dart';
import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';
import 'ChipWidget.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPage createState() {
    return _FilterPage();
  }
}

class _FilterPage extends State<FilterPage> {
  List<String> stringList = DataFile.getFilterPage();

  var selectedTags = ["Wellness"];
  var sortByList = ["Most Popular", "Cost Low to High", "Cost High to Low"];
  var discountList = ["20%", "30%", "40%","50%","60%","70%","80"];
  var selectSort = "Most Popular";
  int selectDiscount = 0;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  generateTags() {
    return stringList.map((tag) => getChip(tag)).toList();
  }

  generateShortBy() {
    return sortByList.map((tag) => getListCell(tag)).toList();
  }

  getListCell(name) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          bottom: ConstantWidget.getScreenPercentSize(context, 1.7  )),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ConstantWidget.getTextWidget(
                    name,
                    (selectSort == name)
                        ? ConstantData.accentColor
                        : ConstantData.mainTextColor,
                    TextAlign.start,
                    FontWeight.w300,
                    ConstantWidget.getScreenPercentSize(context,2))),
            Icon(
              Icons.check,
              color: (selectSort == name)
                  ? ConstantData.accentColor
                  : ConstantData.mainTextColor,
              size: ConstantData.font22Px,
            )
          ],
        ),
        onTap: (){
          setState(() {
            selectSort = name;
          });
        },
      ),
    );
  }

  getChip(name) {

    return ChipWidget(
      selected: selectedTags.contains(name),
          showCheckmark: false,
          selectedColor: ConstantData.accentColor,
          disabledColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          labelStyle: TextStyle(
              color: selectedTags.contains(name) ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold),
          onSelected: (value) {
            setState(() {
              if (selectedTags.contains(name)) {
                selectedTags.remove(name);
              } else {
                selectedTags.add(name);
              }
            });
          },
          label: Text("$name")

    );


    // return FilterChip(
    //     selected: selectedTags.contains(name),
    //     showCheckmark: false,
    //     selectedColor: ConstantData.accentColor,
    //     disabledColor: Colors.transparent,
    //     elevation: 0,
    //     backgroundColor: Colors.transparent,
    //     labelStyle: TextStyle(
    //         color: selectedTags.contains(name) ? Colors.white : Colors.grey,
    //         fontWeight: FontWeight.bold),
    //     onSelected: (value) {
    //       setState(() {
    //         if (selectedTags.contains(name)) {
    //           selectedTags.remove(name);
    //         } else {
    //           selectedTags.add(name);
    //         }
    //       });
    //     },
    //     label: Text("${name}"));
  }

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.safeBlockVertical * 7;



    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).filter),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
            actions: [

              InkWell(
                child: Padding(padding: EdgeInsets.only(right: margin),
                child: Icon(Icons.check_sharp,color: ConstantData.mainTextColor,),),
                onTap: _requestPop,
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(margin),
            child: ListView(
              children: [
                ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).productType,
                    ConstantData.mainTextColor,
                    FontWeight.w700,
                    ConstantWidget.getScreenPercentSize(context, 2.5)),
                SizedBox(
                  height: margin,
                ),
                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[...generateTags()],
                ),

                SizedBox(
                  height: (margin*4),
                ),
                ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).sortType,
                    ConstantData.mainTextColor,
                    FontWeight.w700,
                    ConstantWidget.getScreenPercentSize(context, 2.5)),


                SizedBox(
                  height: (margin*2),
                ),

                Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[...generateShortBy()],
                ),
                SizedBox(
                  height: (margin*4),
                ),
                ConstantWidget.getCustomTextWithoutAlign(
                    S.of(context).discount,
                    ConstantData.mainTextColor,
                    FontWeight.w700,
                    ConstantWidget.getScreenPercentSize(context, 2.5)),


                SizedBox(
                  height: (margin*2),
                ),



                Container(
                    height: height,
                    margin: EdgeInsets.only(bottom: margin),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: discountList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {

                          return InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: (selectDiscount==index)?ConstantData.accentColor:ConstantData.cellColor,
                                borderRadius: BorderRadius.all(Radius.circular(ConstantWidget.getPercentSize(height, 12))),

                              ),
                              margin: EdgeInsets.only(right: ConstantWidget.getScreenPercentSize(context, 1.5)),
                              padding: EdgeInsets.symmetric(horizontal: ConstantWidget.getScreenPercentSize(context, 3.5)),
                              height: height,
                              child: Center(
                                child: ConstantWidget.getTextWidget(discountList[index], (selectDiscount==index)?Colors.white:ConstantData.mainTextColor,
                                    TextAlign.center, FontWeight.w500, ConstantWidget.getPercentSize(height, 30)),
                              ),
                            ),
                            onTap: () {
                             setState(() {
                               selectDiscount= index;
                             });
                            },
                          );
                        })),
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Widget getSearchCell(SubCategoryModel model, int index) {
    double imageSize = SizeConfig.safeBlockVertical * 12;
    double radius = ConstantWidget.getPercentSize(imageSize, 15);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);


    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
              color: ConstantData.borderColor,
              width: ConstantWidget.getWidthPercentSize(context, 0.08)),
        ),
        margin: EdgeInsets.only(
          top: (index == 0) ? 0 : (radius),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: imageSize,
                  width: imageSize,
                  margin: EdgeInsets.all(margin),
                  padding: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: ConstantData.cellColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                    image: DecorationImage(
                      image: ExactAssetImage(
                          ConstantData.assetsPath + model.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstantWidget.getCustomText(
                          model.name,
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.w800,
                          ConstantData.font18Px),
                      Padding(
                        padding:
                            EdgeInsets.only(top: (radius / 4), bottom: radius),
                        child: ConstantWidget.getCustomText(
                            model.desc,
                            ConstantData.textColor,
                            1,
                            TextAlign.start,
                            FontWeight.w500,
                            ConstantWidget.getScreenPercentSize(context, 1.9)),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            ConstantWidget.getCustomText(
                                model.price,
                                ConstantData.accentColor,
                                1,
                                TextAlign.start,
                                FontWeight.w700,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.3)),
                            SizedBox(
                              width: ConstantWidget.getWidthPercentSize(
                                  context, 1.2),
                            ),
                            ConstantWidget.getLineTextView(
                                model.offPrice,
                                Colors.grey,
                                ConstantWidget.getScreenPercentSize(
                                    context, 1.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
            // Positioned.fill(
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: Container(
            //       height: arrowSize,
            //       width: arrowSize,
            //       decoration: BoxDecoration(
            //         color: ConstantData.primaryColor,
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(radius),
            //             bottomRight: Radius.circular(radius)),
            //       ),
            //       child: Transform.scale(
            //         scale: -1,
            //         child: Center(
            //           child: Icon(Icons.arrow_back_sharp,
            //               color: Colors.white,
            //               size: ConstantWidget.getPercentSize(arrowSize, 50)),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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

class User {
  final String name;
  final String avatar;

  User({this.name, this.avatar});
}
