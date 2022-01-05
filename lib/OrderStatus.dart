
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';

import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import 'generated/l10n.dart';

class OrderStatus extends StatefulWidget {
  @override
  _OrderStatus createState() {
    return _OrderStatus();
  }
}

class _OrderStatus extends State<OrderStatus> {
  List<TimelineModel> items = [
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
    TimelineModel(Placeholder(),
        position: TimelineItemPosition.random,
        iconBackground: Colors.redAccent,
        icon: Icon(Icons.blur_circular)),
  ];

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double leftMargin = MediaQuery.of(context).size.width * 0.04;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            title: ConstantWidget.getAppBarText(S.of(context).orderStatus),
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
              margin: EdgeInsets.only(
                  left: leftMargin, right: leftMargin, top: (leftMargin / 2)),
              child: Card(
                  color: ConstantData.bgColor,
                  elevation: 2,
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(leftMargin / 1.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidget.getCustomText(
                                "We have received your order!",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.5)),
                            ConstantWidget.getCustomText(
                                "We will get in touch with you shortly",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w400,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2)),
                            SizedBox(
                              height: leftMargin,
                            ),
                            ConstantWidget.getCustomText(
                                "Order Id  : 547963",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.5)),
                            ConstantWidget.getCustomText(
                                "Estimate Delivery Date: 24 - 27 May",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w400,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2)),

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

                            SizedBox(height: ConstantWidget.getScreenPercentSize(context, 4),),
                            timelineRow1("Call with Pharmacist",true),
                            timelineRow("Free doctor consultation", false),
                            timelineRow("Track your order", false),
                            // timelineLastRow("Track your order", ""),


                            SizedBox(height: ConstantWidget.getScreenPercentSize(context,3),),

                            ConstantWidget.getBottomText(
                                context, S.of(context).callNow, () {
                              _callNumber();
                            })
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
  void _callNumber() async {
    String s="89898989";
    // launch("tel:"+s);
    // launch("tel://"+s);
    String url = "tel:"+s;
    await launch(url);

  }

  Widget timelineLastRow(String title, String subTile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 18,
              height: 18,
              decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Text(""),
            ),
            Container(
              width: 3,
              decoration: new BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
              ),
              child: Text(""),
            ),
          ],
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$title\n $subTile',
                style: TextStyle(
                    fontFamily: "regular",
                    fontSize: 14,
                    color: Colors.black54)),
          ],
        ),
        // Expanded(
        //   flex: 1,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         width: 18,
        //         height: 18,
        //         decoration: new BoxDecoration(
        //           color: Colors.green,
        //           shape: BoxShape.circle,
        //         ),
        //         child: Text(""),
        //       ),
        //       Container(
        //         width: 3,
        //         height: 20,
        //         decoration: new BoxDecoration(
        //           color: Colors.transparent,
        //           shape: BoxShape.rectangle,
        //         ),
        //         child: Text(""),
        //       ),
        //     ],
        //   ),
        // ),
        // Expanded(
        //   flex: 9,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text('${title}\n ${subTile}',
        //           style: TextStyle(
        //               fontFamily: "regular",
        //               fontSize: 14,
        //               color: Colors.black54)),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget timelineRow(String title,bool isSelect) {
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$title',
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontSize: ConstantData.font18Px,
                      fontWeight: FontWeight.w500,
                      color: ConstantData.mainTextColor)),
              // Text('${subTile}',
              //     style: TextStyle(
              //         fontFamily: "regular",
              //         fontSize: 14,
              //         color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

  Widget timelineRow1(String title,bool isSelect) {
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
                height: 80,
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$title',
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontSize: ConstantData.font18Px,
                      fontWeight: FontWeight.w500,
                      color: ConstantData.mainTextColor)),
              SizedBox(height: (ConstantData.font15Px/2),),
              Text('Our pharmacists are required to confirm the medicines in your prescription on call.',
                  style: TextStyle(
                      fontFamily: ConstantData.fontFamily,
                      fontSize: ConstantData.font15Px,
                      fontWeight: FontWeight.w500,
                      color: ConstantData.textColor)),
            ],
          ),
        ),
      ],
    );
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





// Widget timelineRow(String title, String subTile) {
  //
  //
  //   double width= ConstantWidget.getWidthPercentSize(context, 15);
  //   return Stack(
  //     children: [
  //
  //       Positioned.fill(
  //         right:  (width),
  //           left: width,
  //           child:
  //           Container(
  //             color: Colors.red,
  //             width: width,
  //
  //               child: Stack(
  //                 children: [
  //                   Expanded(child: Align(alignment: Alignment.topCenter,
  //
  //                     child:  Container(
  //                       width: 18,
  //                       height: 18,
  //                       decoration: new BoxDecoration(
  //                         color: Colors.green,
  //                         shape: BoxShape.circle,
  //                       ),
  //                     ),
  //                   ),),
  //                   Expanded(
  //                       child: Align(alignment: Alignment.topCenter,
  //                         child: Container(
  //                           width: 3,
  //                           // height: 50,
  //                           decoration: new BoxDecoration(
  //                             color: Colors.green,
  //                             shape: BoxShape.rectangle,
  //                           ),
  //                         ),))
  //                 ],
  //               )
  //           ),
  //   )
  //   ,
  //
  //       Container(
  //
  //         margin: EdgeInsets.only(left: width),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text('${title}',
  //                 style: TextStyle(
  //                     fontFamily: "regular",
  //                     fontSize: 14,
  //                     color: Colors.black54)),
  //             Text('${title}',
  //                 style: TextStyle(
  //                     fontFamily: "regular",
  //                     fontSize: 14,
  //                     color: Colors.black54)),
  //             Text('${title}',
  //                 style: TextStyle(
  //                     fontFamily: "regular",
  //                     fontSize: 14,
  //                     color: Colors.black54)),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  //   // return Row(
  //   //   mainAxisAlignment: MainAxisAlignment.start,
  //   //   crossAxisAlignment: CrossAxisAlignment.start,
  //   //   children: <Widget>[
  //   //
  //   //   Column(
  //   //       // mainAxisAlignment: MainAxisAlignment.start,
  //   //       mainAxisSize: MainAxisSize.min,
  //   //       crossAxisAlignment: CrossAxisAlignment.center,
  //   //       children: <Widget>[
  //   //         Container(
  //   //           width: 18,
  //   //           height: 18,
  //   //           decoration: new BoxDecoration(
  //   //             color: Colors.green,
  //   //             shape: BoxShape.circle,
  //   //           ),
  //   //           child: Text(""),
  //   //         ),
  //   //         Container(
  //   //           width: 3,
  //   //           // height: 50,
  //   //           decoration: new BoxDecoration(
  //   //             color: Colors.green,
  //   //             shape: BoxShape.rectangle,
  //   //           ),
  //   //           child: Text(""),
  //   //         ),
  //   //       ],
  //   //     ),
  //   //
  //   //
  //   // Column(
  //   //     mainAxisAlignment: MainAxisAlignment.start,
  //   //     mainAxisSize: MainAxisSize.min,
  //   //     crossAxisAlignment: CrossAxisAlignment.start,
  //   //     children: <Widget>[
  //   //       Text('${title}\n ${subTile}\n$subTile',
  //   //           style: TextStyle(
  //   //               fontFamily: "regular",
  //   //               fontSize: 14,
  //   //               color: Colors.black54)),
  //   //     ],
  //   //   ),
  //   //
  //   //
  //   //     // Expanded(
  //   //     //   flex: 1,
  //   //     //   child: Column(
  //   //     //     // mainAxisAlignment: MainAxisAlignment.start,
  //   //     //     mainAxisSize: MainAxisSize.min,
  //   //     //     crossAxisAlignment: CrossAxisAlignment.center,
  //   //     //     children: <Widget>[
  //   //     //       Container(
  //   //     //         width: 18,
  //   //     //         height: 18,
  //   //     //         decoration: new BoxDecoration(
  //   //     //           color: Colors.green,
  //   //     //           shape: BoxShape.circle,
  //   //     //         ),
  //   //     //         child: Text(""),
  //   //     //       ),
  //   //     //       Container(
  //   //     //         width: 3,
  //   //     //         height: 50,
  //   //     //         decoration: new BoxDecoration(
  //   //     //           color: Colors.green,
  //   //     //           shape: BoxShape.rectangle,
  //   //     //         ),
  //   //     //         child: Text(""),
  //   //     //       ),
  //   //     //     ],
  //   //     //   ),
  //   //     // ),
  //   //     // Expanded(
  //   //     //   flex: 9,
  //   //     //   child: Column(
  //   //     //     // mainAxisAlignment: MainAxisAlignment.center,
  //   //     //     mainAxisSize: MainAxisSize.min,
  //   //     //     crossAxisAlignment: CrossAxisAlignment.start,
  //   //     //     children: <Widget>[
  //   //     //       Text('${title}\n ${subTile}',
  //   //     //           style: TextStyle(
  //   //     //               fontFamily: "regular",
  //   //     //               fontSize: 14,
  //   //     //               color: Colors.black54)),
  //   //     //     ],
  //   //     //   ),
  //   //     // ),
  //   //   ],
  //   // );
  // }
}

