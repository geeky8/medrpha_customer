
import 'util/ConstantWidget.dart';
import 'model/Message.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'util/ConstantData.dart';
import 'util/SizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChatScreen.dart';


class OrderTrackingPage extends StatefulWidget {
  @override
  _OrderTrackingPage createState() {
    return _OrderTrackingPage();
  }
}

class _OrderTrackingPage extends State<OrderTrackingPage>
    with SingleTickerProviderStateMixin {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  // List<TimelineModel> items = [
  //   TimelineModel(Placeholder(),
  //       position: TimelineItemPosition.random,
  //       iconBackground: ConstantData.primaryColor,
  //       icon: Icon(CupertinoIcons.checkmark_alt)),
  //   TimelineModel(Placeholder(),
  //       position: TimelineItemPosition.random,
  //       iconBackground: ConstantData.primaryColor,
  //       icon: Icon(CupertinoIcons.checkmark_alt)),
  //   TimelineModel(Placeholder(),
  //       position: TimelineItemPosition.random,
  //       iconBackground: ConstantData.primaryColor,
  //       icon: Icon(CupertinoIcons.checkmark_alt)),
  //   TimelineModel(Placeholder(),
  //       position: TimelineItemPosition.random,
  //       iconBackground: ConstantData.primaryColor,
  //       icon: Icon(CupertinoIcons.checkmark_alt)),
  //
  // ];
  //
  Color color1 = ConstantData.accentColor;

  @override
  Widget build(BuildContext context) {
    double imageSize = SizeConfig.safeBlockVertical * 5;
    double leftMargin = SizeConfig.safeBlockVertical * 1.8;

    SizeConfig().init(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: ConstantData.bgColor,
            // title: ConstantWidget.getCustomTextWithoutAlign(
            //     S.of(context).orderTracking,
            //     ConstantData.textColor,
            //     FontWeight.bold,
            //     ConstantData.font18Px),

            title: ConstantWidget.getAppBarText(
                S.of(context).orderTracking,
                ),
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
            margin:
                EdgeInsets.only(top: 10, left: leftMargin, right: leftMargin),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 15),
                  padding: EdgeInsets.all(15),
                  // decoration: BoxDecoration(
                  //     color: ConstantData.whiteColor,
                  //     borderRadius: BorderRadius.circular(15),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.shade200,
                  //         blurRadius: 10,
                  //       )
                  //     ]),

                  decoration: BoxDecoration(
                      color: ConstantData.bgColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: ConstantData.borderColor,
                          width: ConstantWidget.getWidthPercentSize(
                              context, 0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                        )
                      ]),

                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: ConstantWidget.getCustomText(
                                  "Delivery Man",
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w500,
                                  10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 15),
                                  height: imageSize,
                                  width: imageSize,
                                  // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          ConstantData.assetsPath + "hugh.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: ConstantWidget.getCustomText(
                                          "Harry Daniles",
                                          ConstantData.textColor,
                                          1,
                                          TextAlign.start,
                                          FontWeight.bold,
                                          ConstantData.font15Px),
                                    ),
                                    RatingBar.builder(
                                      itemSize: 15,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      tapOnlyMode: true,
                                      updateOnDrag: true,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        flex: 1,
                      ),InkWell(
                        child:  Container(
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.all(10),

                          // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ConstantData.cellColor,
                          ),

                          child: Icon(
                            Icons.message,
                            color: ConstantData.textColor,
                            size: 20,
                          ),
                        ),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder:(context) => ChatScreen(user:chats[0].sender),));

                        },
                      ),
                     InkWell(
                       child:  Container(
                         margin: EdgeInsets.only(right: 8),
                         padding: EdgeInsets.all(10),

                         // margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: ConstantData.cellColor,
                         ),

                         child: Icon(
                           Icons.call,
                           color: ConstantData.textColor,
                           size: 20,
                         ),
                       ),
                       onTap: (){
                         _callNumber("45454545");

                       },
                     )
                    ],
                  ),
                ),

                // Timeline(children: items, position: TimelinePosition.center)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      timelineRow("Order Accepted","10:32 am",true),
                      timelineRow("Preparing package","10:35 am",true),
                      timelineRow("On the way","12:32 pm",true),
                      timelineRow("Delivered","4:00 pm",true),
                      // getTimeLine(
                      //     true,
                      //     false,
                      //     _Child(
                      //       text: 'Order Accepted',
                      //       subText: "10:32 am",
                      //
                      //     )),
                      // getTimeLine(
                      //     false,
                      //     false,
                      //     _Child(
                      //       text: 'Preparing package',
                      //       subText: "10:35 am",
                      //
                      //     )),
                      // getTimeLine(
                      //     false,
                      //     false,
                      //
                      //     _Child(
                      //       text: 'On the way',
                      //       subText: "12:32 pm",
                      //
                      //     )
                      //
                      //   ),
                      // getTimeLine(
                      //     false,
                      //     true,
                      //     _Child(
                      //       text: 'Delivered',
                      //       subText: "4:00 pm",
                      //
                      //     )),
                    ],
                  ),
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  void _callNumber(String s) async {

    // launch("tel:"+s);
    // launch("tel://"+s);
    String url = "tel:"+s;
      await launch(url);

  }


  TimelineTile getTimeLine(bool isFirst, bool isLast, Widget widget) {
    return TimelineTile(
        alignment: TimelineAlign.start,
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          indicator: getCheckWidget(),
        ),
        isFirst: isFirst,
        isLast: isLast,


        beforeLineStyle:
            LineStyle(color: ConstantData.accentColor, thickness: 2),
        afterLineStyle:
            LineStyle(color: ConstantData.accentColor, thickness: 2),
        lineXY: 100,
        endChild: widget);
  }

  Widget timelineRow(String title,String subTitle,bool isSelect) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 18,
                height: 18,
                decoration: new BoxDecoration(
                  color: isSelect?(ConstantData.primaryColor):Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Text(""),
              ),
              Container(
                width: 3,
                height: 50,
                decoration: new BoxDecoration(
                  color: isSelect?(ConstantData.primaryColor):Colors.grey,
                  shape: BoxShape.rectangle,
                ),
                child: Text(""),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$title',
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontSize: ConstantData.font18Px,
                      fontWeight: FontWeight.w500,
                      color: ConstantData.mainTextColor)),

              new Spacer(),

              Text('$subTitle',
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontSize: ConstantData.font15Px,
                      fontWeight: FontWeight.w500,
                      color: ConstantData.mainTextColor)),



            ],
          ),
        ),
      ],
    );
  }



  Widget mapWidget(String text,String subText){
   return Container(
      height: SizeConfig.safeBlockVertical * 30,
      padding: EdgeInsets.only(left: 15),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstantWidget.getCustomTextWithoutAlign(
                text, ConstantData.textColor, FontWeight.w800, 14),
            new Spacer(),
            ConstantWidget.getCustomText(subText, ConstantData.textColor, 1,
                TextAlign.start, FontWeight.w500, 10)
          ],
        ),
      ),
    );
  }

  Widget getCheckWidget() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ConstantData.accentColor,
      ),
      child: Center(
        child: Icon(
          CupertinoIcons.checkmark_alt,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}


