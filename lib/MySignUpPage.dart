import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/MyPhoneVerification.dart';
import 'package:flutter_medical_ui/controller/userstatus_controller.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'controller/local_session_controller.dart';
import 'generated/l10n.dart';
import 'myWidget/my_common_widget.dart';

class MySignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<MySignUpPage> {
  bool isRemember = false;
  int themeMode = 0;
  bool _buttonState = true;
  TextEditingController textMobileController = new TextEditingController();
  TextEditingController textNameController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();
  FocusNode myFocusNode;

  Future<bool> _requestPop() {
    Future.delayed(const Duration(milliseconds: 200), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    setTheme();
    invalidateLocalValue();
    // getOtp('9312000496');
  }

  void invalidateLocalValue() async {
    var session_id = await PrefData.getSessionID();
    try {
      LocalSessionController ls = Get.find<LocalSessionController>();
      if (ls != null) {
        if (ls.mySession != null) {
          print(
              'In SignUp: ls.mysession is not null with value ${ls.mySession}');
          ls.mySession.clearData();
        }
        print('Local Session is already created');
      }
    } finally {
      print('Session value before clear up : ${session_id}');
      if (session_id != null) {
        PrefData.clearLocalData();
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textMobileController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  Future<String> getOtp(String mobile) async {
    var url = Uri.parse('https://apitest.medrpha.com/api/Default/sendotp');
    var response = await http.post(url, body: {'contact': mobile});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode.toString() == "200" || response.statusCode == 200) {
      var jsonData = json.decode(response.body.toString());
      // for (var tempData in jsonData) {
      //   tempData['status'].toString(),
      // }
      print(jsonData['status']);
      print(jsonData['message']);
      //If the user registration exists then create Local Session Controller
      String regStatus = jsonData['status'];
      if (jsonData['status'] == "1" || jsonData['status'] == "2") {
        bool userType = jsonData['status'] == "1" ? true : false;
        print("The user bool value ${userType}");
        Get.put<UserStatusController>(UserStatusController(userType));
        //status 1 is existing user status 2 is new user
        setState(() {
          _buttonState = true;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyPhoneVerification(mobile, regStatus),
            ));
      }
    } else {
      final String msg = 'Oops!! Issue with server';
      mySnakBar(context: context, msg: msg);

      setState(() {
        _buttonState = true;
      });
    }
    _buttonState = true;
  }

  setTheme() async {
    themeMode = await PrefData.getThemeMode();
    setState(() {});
  }

  validateMobile() {
    // print('Btn clicked');
    setState(() {
      _buttonState = false;
    });
    print('The value of mobile is :' + textMobileController.text);
    final String mob = textMobileController.text;
    if (mob == null || mob.length != 10 || int.tryParse(mob) == null) {
      mySnakBar(context: context, msg: 'Please enter 10 digit mobile number');
      setState(() {
        _buttonState = true;
      });
    } else {
      getOtp(mob);
    }
    _buttonState = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 18);
    double subHeight = ConstantWidget.getScreenPercentSize(context, 8.5);
    double radius = ConstantWidget.getPercentSize(subHeight, 20);
    double fontSize = ConstantWidget.getPercentSize(subHeight, 25);

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2.5)),
          child: ListView(
            children: [
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 10),
              ),
              Center(
                child: Image.asset(
                  ConstantData.assetsPath + "logo_transparent2.png",
                  height: height + 90,
                ),
              ),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 4.5),
              ),
              // Center(
              //   child: Text(
              //     'Medrpha',
              //     style: TextStyle(
              //       color: Colors.lightBlue,
              //       fontSize: 40,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 2.5),
              ),
              ConstantWidget.getDefaultNumberFiledWidget(
                  context, S.of(context).phone, textMobileController),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: ElevatedButton(
                  style: ConstantData.btnStyleSecondary,
                  onPressed: _buttonState ? validateMobile : null,
                  child: const Text('Get OTP'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
