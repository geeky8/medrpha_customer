import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_button/timer_button.dart';

import 'controller/cart_controller.dart';
import 'controller/customer_controller.dart';
import 'controller/local_session_controller.dart';
import 'controller/product_controller.dart';
import 'generated/l10n.dart';
import 'localPinScreen.dart';
import 'myWidget/my_common_widget.dart';

class MyPhoneVerification extends StatefulWidget {
  String _mobile;

  MyPhoneVerification(this._mobile);
  @override
  _PhoneVerification createState() {
    return _PhoneVerification();
  }
}

class _PhoneVerification extends State<MyPhoneVerification> {
  bool isRemember = false;
  int themeMode = 0;
  String _session_id;
  bool _complete_reg_status;
  bool _adminstatus;
  bool _nextBtnStatus = true;
  bool _resendBtnStatus = true;
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
    Get.delete<ProductController>();
    Get.delete<CustomerController>();
    Get.delete<CartController>();
    Get.delete<LocalSessionController>();
  }

  setTheme() async {
    themeMode = await PrefData.getThemeMode();
    setState(() {});
  }

  resendOpt() async {
    setState(() {
      _resendBtnStatus = false;
    });
    var url = Uri.parse('https://api.medrpha.com/api/Default/resendotp');
    var response = await http.post(url, body: {'contact': widget._mobile});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode.toString() == "200" || response.statusCode == 200) {
      print('resending otp');
      mySnakBar(
          context: context, msg: 'OTP successfully resent', errMsg: false);
    } else {
      //print(response.statusCode);
      mySnakBar(context: context, msg: 'There was an issue sending OTP');
    }
    setState(() {
      _resendBtnStatus = true;
    });
  }

  Future<String> checkOtp(String mobile, String otp) async {
    setState(() {
      _nextBtnStatus = false;
    });
    var url = Uri.parse('https://api.medrpha.com/api/Default/otpverify');
    var response = await http.post(
      url,
      body: {
        'contact': mobile,
        'otp': otp,
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode.toString() == "200" || response.statusCode == 200) {
      var jsonData = json.decode(response.body.toString());
      final String status = jsonData['status'];
      var data = jsonData['data'];
      if (status == "1") {
        print('Status 1');
        if (data != null) {
          print("data not null");
          _session_id = data['sessID'];
          _complete_reg_status =
              data['complete_reg_status'] == "True" ? true : false;
          _adminstatus = data['adminstatus'] == "True" ? true : false;
          print('$_session_id $_complete_reg_status $_adminstatus');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LocalPinScreen(
                    mobile: widget._mobile,
                    session: _session_id,
                    complete_reg_status: _complete_reg_status,
                    adminstatus: _adminstatus),
              ));
        } else {
          print('Status not 1');
          mySnakBar(context: context, msg: 'Invalid OTP!! Try again');
        }
      } else {
        mySnakBar(context: context, msg: 'Invalid OTP!! Try again');
      }
      // if (jsonData['status'] == "1") {
      //
      // }
    } else {
      final String msg = 'Oops!! Issue with server';
      mySnakBar(context: context, msg: msg);
    }
    setState(() {
      _nextBtnStatus = true;
    });
  }

  validateOtp() {
    setState(() {
      _nextBtnStatus = false;
    });
    // print('Btn clicked');
    print('The value of otp is :' + _pinEditingController.text);
    final String otp = _pinEditingController.text;
    if (otp == null || otp.length != 4 || int.tryParse(otp) == null) {
      mySnakBar(
        context: context,
        msg: 'Please enter a valid OTP',
      );
    } else {
      checkOtp(widget._mobile, otp);
    }
    setState(() {
      _nextBtnStatus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();
    double height = ConstantWidget.getScreenPercentSize(context, 18);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
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
                      ConstantData.assetsPath + "logo_transparent.png",
                      height: height,
                    ),
                  ),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),
                  ConstantWidget.getTextWidget(
                      S.of(context).verification,
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
                        autoFocus: true,
                        key: _formKey,
                        pinLength: 4,
                        decoration: new BoxLooseDecoration(
                          textStyle: TextStyle(
                              color: ConstantData.mainTextColor,
                              fontFamily: ConstantData.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),

                          strokeColorBuilder: PinListenColorBuilder(
                              ConstantData.textColor,
                              ConstantData.primaryColor),

                          obscureStyle: ObscureStyle(
                            isTextObscure: false,
                            obscureText: '🤪',
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
                            print('The length of pin 2 ${pin.length}');
                            if (pin.length == 4) {
                              validateOtp();
                            }
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
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ElevatedButton(
                      style: ConstantData.btnStyleSecondary,
                      onPressed: _nextBtnStatus ? validateOtp : null,
                      child: const Text('Verify OTP'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 3,
                  ),
                  // FractionallySizedBox(
                  //   widthFactor: 0.6,
                  //   child: ElevatedButton(
                  //     style: ConstantData.btnStylePrimary,
                  //     onPressed: _resendBtnStatus ? resendOpt : null,
                  //     child: const Text('Resend OTP'),
                  //   ),
                  // ),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: TimerButton(
                      label: "Resend OTP",
                      timeOutInSeconds: 30,
                      onPressed: _resendBtnStatus ? resendOpt : null,
                      disabledColor: Colors.grey.shade600,
                      color: Colors.blue.shade400,
                      buttonType: ButtonType.OutlinedButton,
                      disabledTextStyle: new TextStyle(fontSize: 16.0),
                      activeTextStyle: const TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
