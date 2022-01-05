import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';

import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';


import 'model/ArticleModel.dart';

class ArticleDetailPage extends StatefulWidget {
  final ArticleModel articleModel;

  ArticleDetailPage(this.articleModel);

  _ArticleDetailPage createState() {
    return _ArticleDetailPage();
  }
}

class _ArticleDetailPage extends State<ArticleDetailPage> {
  ScrollController _scrollController;

  List<ArticleModel> articleList = DataFile.getArticleModel();

  ArticleModel sModel;

  _scrollListener() {
    setState(() {});
  }

  int position = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    sModel = widget.articleModel;

    setState(() {});
    super.initState();
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }




  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 45);
    double secHeight = ConstantWidget.getScreenPercentSize(context, 39);
    double subHeight = ConstantWidget.getScreenPercentSize(context, 24.5);
    double defMargin = (subHeight / 8);

    double radius = ConstantWidget.getScreenPercentSize(context, 6);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);

    return Scaffold(
      backgroundColor: ConstantData.bgColor,

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
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  ConstantData.assetsPath + sModel.image),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

                                        ConstantWidget.getSpaceTextWidget(
                                            sModel.type,
                                            Colors.grey,
                                            TextAlign.start,
                                            FontWeight.w400,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 1.8)),

                                        SizedBox(
                                          height: ConstantWidget
                                              .getScreenPercentSize(
                                                  context, 0.5),
                                        ),
                                        ConstantWidget.getCustomText(
                                            sModel.question,
                                            ConstantData.mainTextColor,
                                            2,
                                            TextAlign.start,
                                            FontWeight.bold,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2.8)),

                                        SizedBox(
                                          height: ConstantWidget
                                              .getScreenPercentSize(context, 2),
                                        ),

                                        ConstantWidget.getSpaceTextWidget(
                                            sModel.desc,
                                            Colors.grey,
                                            TextAlign.start,
                                            FontWeight.w400,
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2)),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: (margin * 1.2),
                                ),
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
                                      S.of(context).allPost,
                                      ConstantData.mainTextColor,
                                      TextAlign.start,
                                      FontWeight.w800,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2.5)),
                                ),
                                topArticleList(),
                              ],
                            ),
                          ),
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

  topArticleList() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = SizeConfig.safeBlockHorizontal * 40;

    double width = ConstantWidget.getWidthPercentSize(context, 60);
    double sideMargin = margin * 1.2;
    double firstHeight = ConstantWidget.getPercentSize(height, 60);
    double remainHeight = height - firstHeight;

    double radius = ConstantWidget.getPercentSize(height, 5);

    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: margin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: articleList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: width,
                  child: Container(
                    margin: EdgeInsets.only(left: sideMargin),
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
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: firstHeight,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(radius),
                                  topLeft: Radius.circular(radius),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(ConstantData.assetsPath +
                                        articleList[index].image),
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: (sideMargin / 2),vertical: (sideMargin / 4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantWidget.getCustomText(
                                        articleList[index].type,
                                        Colors.grey,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getPercentSize(
                                            remainHeight, 15)),
                                    SizedBox(
                                      height: ConstantWidget.getPercentSize(
                                          remainHeight, 2),
                                    ),
                                    Expanded(
                                      child: ConstantWidget.getCustomText(
                                          articleList[index].question,
                                          ConstantData.mainTextColor,
                                          2,
                                          TextAlign.start,
                                          FontWeight.w600,
                                          ConstantWidget.getPercentSize(
                                              remainHeight, 20)),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailPage(articleList[index])));
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
