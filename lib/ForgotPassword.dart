
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'generated/l10n.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPassword createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  bool isRemember = false;
  int themeMode = 0;
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  void initState() {
    super.initState();

    setTheme();
  }

  setTheme() async {
    themeMode = await PrefData.getThemeMode();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 18);





    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(backgroundColor: ConstantData.bgColor,
            elevation: 0,
            title: Text(""),
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
              padding: EdgeInsets.all(
                  ConstantWidget.getScreenPercentSize(context, 2.5)),
              child: ListView(
                children: [
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),
                  Center(
                    child: Image.asset(
                      ConstantData.assetsPath + "molecular-medicine.png",
                      height: height,
                    ),
                  ),

                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),

                  ConstantWidget.getTextWidget(
                      S.of(context).forgotPassword,
                      ConstantData.mainTextColor,
                      TextAlign.center,
                      FontWeight.bold,
                      ConstantWidget.getScreenPercentSize(context, 4.2)),


                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 3),
                  ),


                  ConstantWidget.getDefaultTextFiledWidget(
                      context, S.of(context).yourEmail, textEmailController),




                  ConstantWidget.getButtonWidget(context, S.of(context).send,
                      ConstantData.primaryColor, () {
                        Navigator.of(context).pop(true);
                      }),











                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
