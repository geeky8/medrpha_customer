import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';


class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() {
    return _AboutUsPage();
  }
}

class _AboutUsPage extends State<AboutUsPage> {
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
    ConstantData.setThemePosition();

    double margin = ConstantWidget.getScreenPercentSize(context,1.5);


    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ConstantData.bgColor,

            title: ConstantWidget.getAppBarText(S.of(context).aboutUs),

            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(margin),



                  child: ConstantWidget.getCustomTextWithoutAlign(S.of(context).loremText,
                      ConstantData.textColor, FontWeight.w500, ConstantData.font15Px),


              )),
        ),
        onWillPop: _requestPop);
  }
}
