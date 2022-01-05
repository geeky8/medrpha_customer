import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'OfferScreen.dart';
import 'generated/l10n.dart';
import 'model/ReviewModel.dart';
import 'model/SubCategoryModel.dart';

class ProductDetailPage extends StatefulWidget {
  final SubCategoryModel serviceModel;

  ProductDetailPage(this.serviceModel);

  _ProductDetailPage createState() {
    return _ProductDetailPage();
  }
}

class _ProductDetailPage extends State<ProductDetailPage> {
  ScrollController _scrollController;

  List<ReviewModel> reViewModelList = DataFile.getReviewList();
  // List<String> galleryList = DataFile.getGalleryList();

  // List<ServiceModel> otherServiceList = DataFile.getOtherServices();
  List<String> sliderList = [];
  List<SubCategoryModel> subCategoryModelList = DataFile.getSubCategoryModel();

  int sliderPosition = 0;

  SubCategoryModel sModel;

  _scrollListener() {
    setState(() {});
  }

  final controller = PageController();

  int position = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    sModel = widget.serviceModel;

    for (int i = 0; i < 4; i++) {
      sliderList.add(subCategoryModelList[i].image);
    }
    setState(() {});
    super.initState();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  _onPageViewChange(int page) {
    position = page;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 45);
    double secHeight = ConstantWidget.getScreenPercentSize(context, 39);
    double subHeight = ConstantWidget.getScreenPercentSize(context, 24.5);
    double defMargin = (subHeight / 8);

    double radius = ConstantWidget.getScreenPercentSize(context, 6);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double closeSize = ConstantWidget.getScreenPercentSize(context, 5);

    return Scaffold(
      backgroundColor: ConstantData.bgColor,

      bottomNavigationBar:
          ConstantWidget.getBottomText(context, S.of(context).addToCart, () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferScreen(),
            ));
      }),

      body: WebScrollbar(
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: defMargin),
            color: ConstantData.bgColor,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: height,
                      // padding: EdgeInsets.only(: margin),

                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image: AssetImage(
                      //             ConstantData.assetsPath + sModel.image),
                      //         fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          // FutureBuilder<Color>(
                          //     future: _updatePaletteGenerator(sliderList[position]),
                          //     //This function return color from Sqlite DB Asynchronously
                          //     builder: (BuildContext context, AsyncSnapshot<Color> snapshot) {
                          //       Color color;
                          //       if (snapshot.hasData) {
                          //         color = snapshot.data;
                          //       } else {
                          //         color = ConstantData.cellColor;
                          //       }
                          //
                          //       return   Container(
                          //         height:double.infinity,
                          //         width: double.infinity,
                          //         color: color,
                          //       );
                          //     }),

                          Container(
                            height: double.infinity,
                            child: PageView.builder(
                              controller: controller,
                              onPageChanged: _onPageViewChange,
                              itemBuilder: (context, position) {
                                return Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                ConstantData.assetsPath +
                                                    sliderList[position]),
                                            fit: BoxFit.cover)));
                              },
                              itemCount: sliderList.length,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: (defMargin / 2),
                                vertical: (margin * 2)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: ConstantWidget.getWidthPercentSize(
                                      context, 2),
                                ),
                                Material(
                                  child: InkWell(
                                    child: Icon(
                                      Icons.keyboard_backspace,
                                      color: ConstantData.mainTextColor,
                                    ),
                                    onTap: _requestPop,
                                  ),
                                  color: Colors.transparent,
                                ),
                                new Spacer(),
                                InkWell(
                                  child: Container(
                                    height: closeSize,
                                    width: closeSize,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(radius),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        (sModel.isFav == 0)
                                            ? Icons.favorite_border
                                            : Icons.favorite,
                                        color: Colors.white,
                                        size: ConstantWidget.getPercentSize(
                                            closeSize, 50),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (sModel.isFav == 1) {
                                        sModel.isFav = 0;
                                      } else {
                                        sModel.isFav = 1;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: ConstantWidget.getWidthPercentSize(
                                      context, 2),
                                ),
                              ],
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.all(defMargin),
                              padding: EdgeInsets.only(bottom: defMargin * 1.5),
                              child: SmoothPageIndicator(
                                count: sliderList.length,
                                effect: WormEffect(
                                    activeDotColor: ConstantData.cellColor,
                                    dotColor: ConstantData.cellColor
                                        .withOpacity(0.5)),
                                controller: controller, // your preferred effect
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Product details with the - & + sign and add to cart
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: secHeight),
                      decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: margin),
                            padding: EdgeInsets.symmetric(vertical: (margin)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: (margin),
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Expanded(
                                        //   child:
                                        ConstantWidget.getCustomText(
                                            sModel.name,
                                            ConstantData.mainTextColor,
                                            2,
                                            TextAlign.start,
                                            FontWeight.bold,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2.8)),

                                        ConstantWidget.getSpaceTextWidget(
                                            sModel.desc,
                                            ConstantData.textColor,
                                            TextAlign.start,
                                            FontWeight.w400,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2)),

                                        // ),

                                        SizedBox(
                                          height: ((margin)),
                                        ),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ConstantWidget.getCustomText(
                                                sModel.price,
                                                ConstantData.mainTextColor,
                                                2,
                                                TextAlign.start,
                                                FontWeight.bold,
                                                ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 2.8)),
                                            SizedBox(
                                              width: ((margin) / 4),
                                            ),
                                            // ConstantWidget.getCustomText(
                                            //     (sModel.offPrice != null)
                                            //         ? sModel.offPrice
                                            //         : "",
                                            //     Colors.grey,
                                            //     2,
                                            //     TextAlign.start,
                                            //     FontWeight.w500,
                                            //     ConstantWidget
                                            //         .getScreenPercentSize(
                                            //             context, 2)),

                                            ConstantWidget.getLineTextView(
                                                (sModel.offPrice != null)
                                                    ? sModel.offPrice
                                                    : "",
                                                Colors.grey,
                                                ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 2)),

                                            Expanded(
                                                child: ConstantWidget
                                                    .getCustomText(
                                                        (sModel.offer != null)
                                                            ? sModel.offer
                                                            : "",
                                                        ConstantData
                                                            .accentColor,
                                                        2,
                                                        TextAlign.end,
                                                        FontWeight.bold,
                                                        ConstantWidget
                                                            .getScreenPercentSize(
                                                                context, 2)))
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: (margin * 1.2),
                                ),
                                // plus and minus sign
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ConstantWidget.getCustomText(
                                        "Select Quantity",
                                        ConstantData.textColor,
                                        2,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getScreenPercentSize(
                                            context, 1.8)),
                                    SizedBox(
                                      width:
                                          ConstantWidget.getScreenPercentSize(
                                              context, 2),
                                    ),
                                    getCartButton(CupertinoIcons.minus, () {
                                      setState(() {
                                        if (sModel.quantity > 1) {
                                          sModel.quantity--;
                                        }
                                      });
                                    }),
                                    SizedBox(
                                      width:
                                          ConstantWidget.getScreenPercentSize(
                                              context, 2),
                                    ),
                                    ConstantWidget.getCustomText(
                                        sModel.quantity.toString(),
                                        ConstantData.mainTextColor,
                                        2,
                                        TextAlign.start,
                                        FontWeight.w500,
                                        ConstantWidget.getScreenPercentSize(
                                            context, 1.8)),
                                    SizedBox(
                                      width:
                                          ConstantWidget.getScreenPercentSize(
                                              context, 2),
                                    ),
                                    getCartButton(Icons.add, () {
                                      setState(() {
                                        sModel.quantity++;
                                      });
                                    }),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: margin, bottom: (margin)),
                                  child: ConstantWidget.getTextWidget(
                                      S.of(context).otherProduct,
                                      ConstantData.mainTextColor,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2.5)),
                                ),
                                trendingList(),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: ConstantWidget.getScreenPercentSize(
                                      context, 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: margin),
                                  child: ConstantWidget.getTextWidget(
                                      S.of(context).allReviews,
                                      ConstantData.mainTextColor,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2.5)),
                                ),
                                SizedBox(
                                  height: (height / 15),
                                ),
                                ListView.builder(
                                  itemCount: reViewModelList.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return _reViewCell(
                                        reViewModelList[index], index, margin);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ...
    );
  }

  trendingList() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = SizeConfig.safeBlockHorizontal * 45;

    double width = ConstantWidget.getWidthPercentSize(context, 60);

    double firstHeight = ConstantWidget.getPercentSize(height, 60);
    double remainHeight = height - firstHeight;

    double radius = ConstantWidget.getPercentSize(height, 5);

    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: margin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: subCategoryModelList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: width,
                  child: Container(
                    margin: EdgeInsets.only(left: margin),
                    decoration: BoxDecoration(
                        color: ConstantData.bgColor,
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                            color: ConstantData.borderColor,
                            width: ConstantWidget.getWidthPercentSize(
                                context, 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                          )
                        ]),
                    child: Stack(
                      children: [
                        Visibility(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(margin / 4),
                              decoration: BoxDecoration(
                                color: ConstantData.accentColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(radius)),
                              ),
                              child: ConstantWidget.getCustomText(
                                  (subCategoryModelList[index].offer != null)
                                      ? subCategoryModelList[index].offer
                                      : "",
                                  Colors.white,
                                  // ConstantData.accentColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w400,
                                  ConstantWidget.getPercentSize(
                                      firstHeight, 12)),
                            ),
                          ),
                          visible:
                              ((subCategoryModelList[index].offer.isNotEmpty)),
                        ),
                        Container(
                          padding: EdgeInsets.all((margin / 2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: firstHeight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: firstHeight,
                                      width: firstHeight,
                                      decoration: BoxDecoration(
                                          color: ConstantData.cellColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(radius),
                                          ),
                                          // ,
                                          image: DecorationImage(
                                              image: AssetImage(ConstantData
                                                      .assetsPath +
                                                  subCategoryModelList[index]
                                                      .image),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            ConstantWidget.getLineTextView(
                                                (subCategoryModelList[index]
                                                            .offPrice !=
                                                        null)
                                                    ? subCategoryModelList[
                                                            index]
                                                        .offPrice
                                                    : "",
                                                Colors.grey,
                                                ConstantWidget.getPercentSize(
                                                    firstHeight, 12)),
                                            SizedBox(
                                              height:
                                                  ConstantWidget.getPercentSize(
                                                      firstHeight, 8),
                                            ),
                                            ConstantWidget.getCustomText(
                                                subCategoryModelList[index]
                                                    .price,
                                                ConstantData.mainTextColor,
                                                1,
                                                TextAlign.start,
                                                FontWeight.w600,
                                                ConstantWidget.getPercentSize(
                                                    firstHeight, 18)),
                                            SizedBox(
                                              height:
                                                  ConstantWidget.getPercentSize(
                                                      firstHeight, 8),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: ConstantWidget.getPercentSize(
                                          remainHeight, 8),
                                    ),
                                    ConstantWidget.getCustomText(
                                        subCategoryModelList[index].name,
                                        ConstantData.mainTextColor,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getPercentSize(
                                            remainHeight, 22)),
                                    SizedBox(
                                      height: ConstantWidget.getPercentSize(
                                          remainHeight, 8),
                                    ),
                                    ConstantWidget.getCustomText(
                                        subCategoryModelList[index].desc,
                                        Colors.grey,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getPercentSize(
                                            remainHeight, 14)),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    sModel = subCategoryModelList[index];

                    sliderList.clear();

                    for (int i = 0; i < 4; i++) {
                      sliderList.add(subCategoryModelList[i].image);
                    }
                  });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ProductDetailPage(subCategoryModelList[index])));
                },
              );
            }));
  }

  getCartButton(var icon, Function function) {
    double height = ConstantWidget.getScreenPercentSize(context, 4);

    return InkWell(
      child: Container(
        height: height,
        // margin: EdgeInsets.symmetric(horizontal: ConstantWidget.getPercentSize(height, 30)),
        width: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
                color: Colors.grey,
                width: ConstantWidget.getPercentSize(height, 2))),
        child: Icon(
          icon,
          size: ConstantWidget.getPercentSize(height, 50),
          color: Colors.grey,
        ),
      ),
      onTap: function,
    );
  }

  getSliderCell(String sliderModel, double height) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ConstantData.assetsPath + sliderModel),
              fit: BoxFit.cover)),
    );
  }

  Widget _reViewCell(ReviewModel reViewModel, int index, double defMargin) {
    double imageSize = SizeConfig.safeBlockVertical * 7;
    double leftMargin = SizeConfig.safeBlockVertical * 1.2;
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    // Widget _colorView(Color color, bool isSelected) {

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: defMargin, right: defMargin),
      padding: EdgeInsets.symmetric(horizontal: allMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: imageSize,
                width: imageSize,
                // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: ExactAssetImage(
                        ConstantData.assetsPath + reViewModel.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: leftMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      ConstantWidget.getCustomText(
                          reViewModel.name,
                          ConstantData.textColor,
                          1,
                          TextAlign.start,
                          FontWeight.bold,
                          ConstantWidget.getScreenPercentSize(context, 2.2)),
                      new Spacer(),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.amber,
                        size: ConstantWidget.getScreenPercentSize(context, 2.5),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: (defMargin / 2)),
                        child: Text(reViewModel.review.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: ConstantData.font18Px,
                                color: ConstantData.mainTextColor,
                                decoration: TextDecoration.none)),
                      ),
                    ]),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 0.5),
                    ),
                    ConstantWidget.getCustomText(
                        reViewModel.date,
                        Colors.grey.shade500,
                        1,
                        TextAlign.start,
                        FontWeight.w600,
                        ConstantData.font15Px),
                  ],
                ),
              ))

              // Padding(
              //     padding: EdgeInsets.only(left: leftMargin),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //
              //         Row(
              //           children: <Widget>[
              //             Text("1"),
              //             Text("2"),
              //           ],
              //         ),
              //
              //
              //
              //         // Row(
              //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         //
              //         //   children:  <Widget>[
              //         //     ConstantWidget.getCustomText(
              //         //         reViewModel.name,
              //         //         ConstantData.textColor,
              //         //         1,
              //         //         TextAlign.start,
              //         //         FontWeight.bold,
              //         //         ConstantWidget.getScreenPercentSize(
              //         //             context, 2.2)),
              //         //
              //         //     SizedBox(width: ConstantWidget.getWidthPercentSize(context, 28)),
              //         //     Icon(
              //         //       CupertinoIcons.star_fill,
              //         //       color: Colors.amber,
              //         //       size: ConstantWidget.getScreenPercentSize(
              //         //           context, 2.5),
              //         //     ),
              //         //     Padding(
              //         //       padding: EdgeInsets.only(left: (defMargin / 2)),
              //         //       child: Text(reViewModel.review.toString(),
              //         //           textAlign: TextAlign.start,
              //         //           style: TextStyle(
              //         //               fontFamily: ConstantData.fontFamily,
              //         //               fontWeight: FontWeight.bold,
              //         //               fontSize: ConstantData.font15Px,
              //         //               color: ConstantData.mainTextColor,
              //         //               decoration: TextDecoration.none)),
              //         //     ),
              //         //         // new Spacer(),
              //         //   ],
              //         // ),
              //         SizedBox(
              //           height:
              //               ConstantWidget.getScreenPercentSize(context, 0.5),
              //         ),
              //         ConstantWidget.getCustomText(
              //             reViewModel.date,
              //             ConstantData.textColor,
              //             1,
              //             TextAlign.start,
              //             FontWeight.w600,
              //             ConstantData.font15Px),
              //       ],
              //     ))
            ],
          ),

          Container(
            margin:
                EdgeInsets.only(left: (imageSize + leftMargin), top: defMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ConstantData.assetsPath + "left-quotes-sign.png",
                  color: "#D5D5D5".toColor(),
                  height: (imageSize / 3),
                ),
                SizedBox(
                  width: ConstantWidget.getScreenPercentSize(context, 1),
                ),
                Expanded(
                  child: Text(
                    reViewModel.desc,
                    style: TextStyle(
                        height: 1.6,
                        decoration: TextDecoration.none,
                        fontSize:
                            ConstantWidget.getScreenPercentSize(context, 2),
                        color: ConstantData.textColor,
                        fontFamily: ConstantData.fontFamily,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  )

                  // ConstantWidget.getTextWidget(
                  //     reViewModel.desc,
                  //     ConstantData.textColor,
                  //     TextAlign.start,
                  //     FontWeight.w500,
                  //     ConstantWidget.getScreenPercentSize(context, 2  ))
                  ,
                  flex: 1,
                )
              ],
            ),
          ),

          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 0.5),
          ),
          // Container(
          //   margin: EdgeInsets.only(left: (imageSize + leftMargin)),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       RatingBar.builder(
          //         itemSize: ConstantWidget.getScreenPercentSize(context, 1.7),
          //         initialRating: reViewModel.review,
          //         minRating: 1,
          //         direction: Axis.horizontal,
          //         allowHalfRating: true,
          //         itemCount: 5,
          //         tapOnlyMode: true,
          //         updateOnDrag: true,
          //         itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
          //         itemBuilder: (context, _) => Icon(
          //           Icons.star,
          //           color: Colors.amber,
          //           size: ConstantWidget.getScreenPercentSize(context, 1.7),
          //         ),
          //         onRatingUpdate: (rating) {
          //           print(rating);
          //         },
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(top: 5),
          //         child: ConstantWidget.getCustomText(
          //             reViewModel.desc,
          //             ConstantData.mainTextColor,
          //             2,
          //             TextAlign.start,
          //             FontWeight.w400,
          //             ConstantWidget.getScreenPercentSize(context, 1.7)),
          //
          //       )
          //     ],
          //   ),
          // ),

          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 2),
          ),
          Visibility(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height:
                          ConstantWidget.getScreenPercentSize(context, 0.02),
                      color: ConstantData.mainTextColor,
                    ),
                    SizedBox(
                      height: ConstantWidget.getScreenPercentSize(context, 2),
                    ),
                  ],
                )
              ],
            ),
            visible: (index != (reViewModelList.length - 1)),
          )
        ],
      ),
    );

    // return Container(
    //   margin: EdgeInsets.only(
    //     left: defMargin, right: defMargin),
    //   padding: EdgeInsets.symmetric(horizontal: allMargin),
    //
    //
    //
    //
    //   child: Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Container(
    //             height: imageSize,
    //             width: imageSize,
    //             // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: Colors.transparent,
    //               image: DecorationImage(
    //                 image: ExactAssetImage(
    //                     ConstantData.assetsPath + reViewModel.image),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(left: leftMargin),
    //             child: ConstantWidget.getCustomText(
    //                 reViewModel.name,
    //                 ConstantData.textColor,
    //                 1,
    //                 TextAlign.start,
    //                 FontWeight.bold,
    //                 ConstantData.font15Px),
    //
    //           )
    //         ],
    //       ),
    //       Container(
    //         margin: EdgeInsets.only(left: (imageSize + leftMargin)),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             RatingBar.builder(
    //               itemSize: ConstantWidget.getScreenPercentSize(context, 1.7),
    //               initialRating: reViewModel.review,
    //               minRating: 1,
    //               direction: Axis.horizontal,
    //               allowHalfRating: true,
    //               itemCount: 5,
    //               tapOnlyMode: true,
    //               updateOnDrag: true,
    //               itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
    //               itemBuilder: (context, _) => Icon(
    //                 Icons.star,
    //                 color: Colors.amber,
    //                 size: ConstantWidget.getScreenPercentSize(context, 1.7),
    //               ),
    //               onRatingUpdate: (rating) {
    //                 print(rating);
    //               },
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(top: 5),
    //               child: ConstantWidget.getCustomText(
    //                   reViewModel.desc,
    //                   ConstantData.mainTextColor,
    //                   2,
    //                   TextAlign.start,
    //                   FontWeight.w400,
    //                   ConstantWidget.getScreenPercentSize(context, 1.7)),
    //
    //             )
    //           ],
    //         ),
    //       ),
    //
    //
    //
    //       SizedBox(
    //         height: ConstantWidget.getScreenPercentSize(context, 2),
    //       ),
    //
    //  Visibility(child: Column(children: [
    //
    //
    //    Column(
    //      children: [
    //
    //
    //        Container(
    //          height: ConstantWidget.getScreenPercentSize(context, 0.02),
    //          color: ConstantData.mainTextColor,
    //        ),
    //        SizedBox(
    //          height: ConstantWidget.getScreenPercentSize(context, 2),
    //        ),
    //
    //      ],
    //    )
    //  ],),visible: (index != (reViewModelList.length-1)),)
    //     ],
    //   ),
    // );
  }

  getDecoration() {
    return BoxDecoration(
        color: ConstantData.cellColor,
        borderRadius: BorderRadius.circular(
            ConstantWidget.getScreenPercentSize(context, 1)),
        boxShadow: [
          BoxShadow(
            color: ConstantData.primaryColor.withOpacity(0.09),
          )
        ]);
  }
}

class WebScrollbar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double heightFraction;
  final double width;
  final bool isAlwaysShown;

  WebScrollbar({
    this.child,
    this.controller,
    this.heightFraction = 0.20,
    this.width = 8,
    this.isAlwaysShown = false,
  }) : assert(heightFraction < 1.0 && heightFraction > 0.0);

  @override
  _WebScrollbarState createState() => _WebScrollbarState();
}

class _WebScrollbarState extends State<WebScrollbar> {
  double _scrollPosition = 0;
  bool _isUpdating;
  Timer timer;

  _scrollListener() {
    setState(() {
      _scrollPosition = widget.controller.position.pixels;
    });
  }

  @override
  void initState() {
    widget.controller.addListener(_scrollListener);
    _isUpdating = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double _scrollerHeight = screenSize.height * widget.heightFraction;

    double _topMargin = widget.controller.hasClients
        ? ((screenSize.height *
                _scrollPosition /
                widget.controller.position.maxScrollExtent) -
            (_scrollerHeight *
                _scrollPosition /
                widget.controller.position.maxScrollExtent))
        : 0;

    return Stack(
      children: [
        widget.child,
        AnimatedOpacity(
          opacity: widget.isAlwaysShown
              ? 1
              : widget.controller.hasClients
                  ? _isUpdating
                      ? 1
                      : 0
                  : 0,
          duration: Duration(milliseconds: 300),
          child: Container(
            alignment: Alignment.centerRight,
            height: MediaQuery.of(context).size.height,
            width: widget.width + 2,
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width - widget.width + 2,
            ),
            color: ConstantData.bgColor,
            child: Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                child: Container(
                  height: _scrollerHeight,
                  width: widget.width,
                  margin: EdgeInsets.only(
                    left: 1.0,
                    right: 1.0,
                    top: _topMargin,
                  ),
                  decoration: BoxDecoration(
                    color: ConstantData.mainTextColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    // ...
  }
}
