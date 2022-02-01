import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/CustomDialogBox.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/view/my_getx_home_page.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MySignUpPage.dart';
import 'controller/product_controller.dart';
import 'myWidget/my_common_widget.dart';

class MyPinVerification extends StatefulWidget {
  @override
  _PhoneVerification createState() {
    return _PhoneVerification();
  }
}

class _PhoneVerification extends State<MyPinVerification> {
  bool isRemember = false;
  int themeMode = 0;
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');
  TextEditingController _pinEditingController = TextEditingController(text: '');

  bool _enable = true;

  @override
  void initState() {
    super.initState();

    setTheme();
  }

  setTheme() async {
    themeMode = await PrefData.getThemeMode();
    setState(() {});
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MySignUpPage(),
        ));
  }

  Future<CustomDialogBox> login() async {
    String newpin = _pinEditingController.text;
    if (newpin == null || newpin == '') {
      mySnakBar(
        context: context,
        msg: 'Please enter PIN',
      );
    } else {
      LocalSessionController ls = Get.find<LocalSessionController>();

      String _session_id = ls.mySession.session;
      String _mobileNo = ls.mySession.mobileNo;
      bool _regCompleted = ls.mySession.regCompleted;
      bool _adminApproved = ls.mySession.adminApproved;
      String _pin = await PrefData.getPin();
      if (_session_id == '' ||
          _session_id == null ||
          _pin == '' ||
          _pin == null) {
        return CustomDialogBox(
          title: "Alas!! Something Broke",
          descriptions:
              "Your session is no longer active. \nPlease login using OTP to continue",
          text: "Continue",
          func: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MySignUpPage(),
                ));
          },
        );
      } else {
        //when session and pin is present then check if pin matches
        if (newpin != _pin) {
          mySnakBar(
            context: context,
            msg: 'PIN does not match. Try Again',
          );
          _pinEditingController.clear();
        } else {
          print('The local controller session value ${_session_id}');
          var response = await ApiService.getUserStatus(sessionID: _session_id);
          if (response["status"] == "1") {
            ls.mySession.adminApproved = response["admin"];
            ls.mySession.regCompleted = response["completed"];
            try {
              print(
                  'The value for admin approval from response : ${response["admin"]}');
              Get.find<ProductController>()
                  .hideProductPrice(!response["admin"]);
              Get.find<ProductController>().regCompleted.value =
                  response["completed"];
              Get.find<ProductController>().adminApproved.value =
                  response["admin"];
              print(
                  'The value of show product is : ${Get.find<ProductController>().showProduct}');
            } finally {
              await PrefData.setAdminApproved(response["admin"]);
              await PrefData.setRegCompleted(response["completed"]);
              Timer(Duration(microseconds: 300), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      //old template page
                      //builder: (context) => MyHome(),
                      builder: (context) => MyNewHomePage(),
                    ));
              });
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 18);

    return Scaffold(
      backgroundColor: ConstantData.bgColor,
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.all(ConstantWidget.getScreenPercentSize(context, 2.5)),
          child: ListView(
            children: [
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 2),
              ),
              Center(
                child: Image.asset(
                  ConstantData.assetsPath + "logo_transparent.png",
                  height: height,
                ),
              ),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 2),
              ),
              ConstantWidget.getTextWidget(
                  'Enter PIN',
                  ConstantData.mainTextColor,
                  TextAlign.center,
                  FontWeight.bold,
                  ConstantWidget.getScreenPercentSize(context, 4.2)),
              SizedBox(
                height: ConstantWidget.getScreenPercentSize(context, 5),
              ),
              Center(
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 70,
                  child: PinInputTextFormField(
                    key: _formKey,
                    pinLength: 4,
                    decoration: new BoxLooseDecoration(
                      textStyle: TextStyle(
                          color: ConstantData.mainTextColor,
                          fontFamily: ConstantData.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),

                      strokeColorBuilder: PinListenColorBuilder(
                          ConstantData.textColor, ConstantData.primaryColor),

                      obscureStyle: ObscureStyle(
                        isTextObscure: true,
                        obscureText: '*',
                      ),
                      // hintText: _kDefaultHint,
                    ),
                    controller: _pinEditingController,
                    textInputAction: TextInputAction.go,
                    enabled: _enable,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.characters,
                    onSubmit: (pin) {
                      print("gtepin===$pin");
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                    },
                    onChanged: (pin) {
                      setState(() {
                        debugPrint('onChanged execute. pin:$pin');
                      });
                    },
                    onSaved: (pin) {
                      debugPrint('onSaved pin:$pin');
                    },
                    validator: (pin) {
                      if (pin.isEmpty) {
                        setState(() {
                          // _hasError = true;
                        });
                        return 'Pin cannot empty.';
                      }
                      setState(() {
                        // _hasError = false;
                      });
                      return null;
                    },
                    cursor: Cursor(
                      width: 2,
                      color: Colors.white,
                      radius: Radius.circular(1),
                      enabled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 5,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockVertical * 9),
                child: Column(
                  children: [
                    ConstantWidget.getButtonWidget(
                        context, 'Login', ConstantData.primaryColor, login),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 1,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        logout();
                      },
                      child: const Text('Login using OTP'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
