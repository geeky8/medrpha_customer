import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';

class WriteReviewPage extends StatefulWidget {
  @override
  _WriteReviewPage createState() {
    return _WriteReviewPage();
  }
}

class _WriteReviewPage extends State<WriteReviewPage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }



  int themMode;

  setThemePosition() async {
    themMode = await PrefData.getThemeMode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    setThemePosition();
    double margin=ConstantWidget.getScreenPercentSize(context, 1.5);
    double icon=ConstantWidget.getScreenPercentSize(context, 3.5);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).writeReviewPage),



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
            child: Container(
              margin: EdgeInsets.only(
                  left: margin,
                  right: margin,
                  top: margin,
                  bottom: MediaQuery.of(context).size.width * 0.01),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:
                      Image.asset(ConstantData.assetsPath+'rate.png',height: SizeConfig.safeBlockVertical * 25,),

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: margin, bottom: margin),
                    child: Align(
                      alignment: Alignment.center,
                      child: RatingBar.builder(
                        itemSize: icon,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        tapOnlyMode: true,
                        updateOnDrag: true,
                        itemPadding: EdgeInsets.symmetric(horizontal: margin),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: icon,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(margin),
                    decoration: new BoxDecoration(
                        color: ConstantData.cellColor,
                        boxShadow: [
                          BoxShadow(
                            color: ConstantData.shadowColor,

                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular((margin/1.5)))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: margin),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: ConstantWidget.getCustomText(S.of(context).yourName, ConstantData.textColor, 1, TextAlign.start, FontWeight.bold, ConstantData.font12Px),)

                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: margin),
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.mainTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: ConstantData.font15Px),

                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(top: 3, left: (margin/2)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: margin),
                          child: Align(
                              alignment: Alignment.topLeft,
                            child: ConstantWidget.getCustomText(S.of(context).writeYourReview,
                                ConstantData.textColor, 1, TextAlign.start, FontWeight.bold, ConstantData.font12Px),)


                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: margin),
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.mainTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: ConstantData.font15Px),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.only(top: 3, left: (margin/2)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantData.textColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                    Colors.white),
                              ),
                            ),
                          ),
                        ),


               ConstantWidget.getCustomText(S.of(context).minimumCharacter, ConstantData.textColor, 1,
                   TextAlign.start, FontWeight.w500, ConstantData.font15Px)





            ],
                    ),
                  ),

                  InkWell(
                    child: Container(
                        margin: EdgeInsets.only(top: (margin*2)),
                        height: ConstantWidget.getScreenPercentSize(context, 8),
                        decoration: BoxDecoration(
                            color: (themMode==1)?ConstantData.cellColor:ConstantData.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular((margin/2)))),
                        child: InkWell(
                          child: Center(
                            child: ConstantWidget.getCustomTextWithoutAlign(S.of(context).submit,
                                Colors.white, FontWeight.w900, ConstantData.font18Px),

                          ),
                        )),
                    onTap: () {
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
