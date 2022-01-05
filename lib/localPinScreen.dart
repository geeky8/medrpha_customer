import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/CustomDialogBox.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_medical_ui/util/PrefData.dart';

import 'CategoriesPage.dart';
import 'MyHome.dart';
import 'SubCategoriesPage.dart';
import 'TabWidget.dart';
import 'WidgetNotificationConfirmation.dart';
import 'generated/l10n.dart';
import 'myWidget/my_common_widget.dart';

class LocalPinScreen extends StatefulWidget {
  String mobile, session;
  bool complete_reg_status, adminstatus;
  LocalPinScreen(
      {@required this.mobile,
      @required this.session,
      @required this.complete_reg_status,
      @required this.adminstatus});
  @override
  _PhoneVerification createState() {
    return _PhoneVerification();
  }
}

class _PhoneVerification extends State<LocalPinScreen> {
  bool isRemember = false;
  int themeMode = 0;
  bool _pinBtnStatus = true;

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  final GlobalKey<FormFieldState<String>> _formKeyPin =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkeypin');
  final GlobalKey<FormFieldState<String>> _formKeyrePin =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkeyrepin');
  TextEditingController _pinEditingController = TextEditingController(text: '');
  TextEditingController _repinEditingController =
      TextEditingController(text: '');

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

  void setValue(mobile, session, adminstatus, complete_reg_status, pin) async {
    await PrefData.setMobileNo(mobile);
    await PrefData.setSessionID(session);
    await PrefData.setAdminApproved(adminstatus);
    await PrefData.setRegCompleted(complete_reg_status);
    await PrefData.setPin(pin);
    // Navigator.pushReplacement(
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHome(),
        ));
  }

  validatePin() async {
    setState(() {
      _pinBtnStatus = false;
    });
    final String pin = _pinEditingController.text;
    final String repin = _repinEditingController.text;
    if (pin == null || repin == null || pin == '') {
      mySnakBar(
        context: context,
        msg: 'Please enter PIN and retype the PIN',
      );
    } else if (pin != repin) {
      mySnakBar(
        context: context,
        msg: 'PIN and retype of PIN doesn\'t match. Please retype',
      );
      _pinEditingController.clear();
      _repinEditingController.clear();
    } else {
      //save value in mobile
      setValue(widget.mobile, widget.session, widget.adminstatus,
          widget.complete_reg_status, pin);
    }
    setState(() {
      _pinBtnStatus = true;
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
                  Center(
                    child: Text(
                      'Create PIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2),
                  ),
                  Center(
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 70,
                      child: PinInputTextFormField(
                        autoFocus: true,
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
                        controller: _repinEditingController,
                        textInputAction: TextInputAction.go,
                        enabled: _enable,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.characters,
                        onSubmit: (pin) {
                          print("gtepin===$pin");
                          if (_formKeyPin.currentState.validate()) {
                            _formKeyPin.currentState.save();
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
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      'Retype PIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Center(
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 70,
                      child: PinInputTextFormField(
                        key: _formKeyrePin,
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
                          if (_formKeyPin.currentState.validate()) {
                            _formKeyPin.currentState.save();
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
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: ElevatedButton(
                      style: ConstantData.btnStylePrimary,
                      onPressed: _pinBtnStatus ? validatePin : null,
                      child: const Text('Set PIN'),
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
