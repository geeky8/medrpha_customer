import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';
import 'model/ModelNotification.dart';

class NotificationList extends StatefulWidget {
  @override
  _RateProduct createState() => _RateProduct();
}

class _RateProduct extends State<NotificationList> {
  List<ModelNotification> _notificationList = DataFile.getNotificationList();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double totalHeight = SizeConfig.safeBlockHorizontal * 100;
    double itemHeight = ConstantWidget.getPercentSize(totalHeight, 18);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                finish();
              },
              icon: Icon(Icons.keyboard_backspace),
              color: ConstantData.mainTextColor,
            ),
            elevation: 0,
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).notification),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: ListView.builder(
              primary: true,
              shrinkWrap: true,
              padding: EdgeInsets.all(ConstantWidget.getPercentSize(itemHeight, 7)),
              itemCount: _notificationList.length,
              itemBuilder: (context, index) {
                ModelNotification _notification = _notificationList[index];
                return Container(
                  decoration: BoxDecoration(
                      color: ConstantData.cellColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin:
                      EdgeInsets.all(ConstantWidget.getPercentSize(itemHeight, 7)),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      vertical: ConstantWidget.getPercentSize(itemHeight, 2),
                      horizontal: ConstantWidget.getPercentSize(itemHeight, 7)),
                  height: itemHeight,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal * 2.5),
                        height: ConstantWidget.getPercentSize(itemHeight, 45),
                        width: ConstantWidget.getPercentSize(itemHeight, 45),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: ConstantData.mainTextColor),
                        child: Icon(
                          Icons.notifications_outlined,
                          size: ConstantWidget.getPercentSize(itemHeight, 30),
                          color: ConstantData.cellColor,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidget.getCustomText(
                                _notification.title,
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantWidget.getPercentSize(itemHeight, 18)),
                            ConstantWidget.getSpace(ConstantWidget.getPercentSize(itemHeight, 3)),
                            ConstantWidget.getCustomText(
                                _notification.desc,
                                Colors.grey,
                                2,
                                TextAlign.start,
                                FontWeight.w400,
                                ConstantWidget.getPercentSize(itemHeight, 15))
                          ],
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  void finish() {
    Navigator.of(context).pop();
  }
}
