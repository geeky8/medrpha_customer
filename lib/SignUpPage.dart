import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/PhoneVerification.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';

import 'SignInPage.dart';
import 'generated/l10n.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPage createState() {
    return _SignUpPage();
  }
}

class _SignUpPage extends State<SignUpPage> {
  bool isRemember = false;
  int themeMode = 0;
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textNameController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Future.delayed(const Duration(milliseconds: 200), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
    return new Future.value(false);
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

    double subHeight = ConstantWidget.getScreenPercentSize(context, 8.5);


    double radius = ConstantWidget.getPercentSize(subHeight, 20);
    double fontSize = ConstantWidget.getPercentSize(subHeight, 25);


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
                      ConstantData.assetsPath + "molecular-medicine.png",
                      height: height,
                    ),
                  ),

                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 1.5),
                  ),

                  ConstantWidget.getTextWidget(
                      S.of(context).signUp,
                      ConstantData.mainTextColor,
                      TextAlign.center,
                      FontWeight.bold,
                      ConstantWidget.getScreenPercentSize(context, 4.2)),


                  SizedBox(
                    height: ConstantWidget.getScreenPercentSize(context, 2.5),
                  ),

                  ConstantWidget.getDefaultTextFiledWidget(
                      context, S.of(context).yourName, textNameController),
                  ConstantWidget.getDefaultTextFiledWidget(
                      context, S.of(context).yourEmail, textEmailController),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          height :subHeight,
                          margin: EdgeInsets.only(right: 7),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: ConstantData.cellColor,


                            borderRadius: BorderRadius.all(
                              Radius.circular(radius),
                            ),
                          ),
                          child: CountryCodePicker(
                            boxDecoration: BoxDecoration(
                              color: ConstantData.cellColor,

                            ),
                            closeIcon: Icon(Icons.close,
                                size: ConstantWidget.getScreenPercentSize(context, 3),
                                color: ConstantData.mainTextColor),

                            onChanged: (value) {
                              // countryCode = value.dialCode;
                              // print("changeval===$countryCode");
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IN',
                            searchStyle: TextStyle(
                                color: ConstantData.mainTextColor,
                                fontFamily: ConstantData.fontFamily),
                            searchDecoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: ConstantData.textColor),

                                ),
                                hintStyle: TextStyle(
                                    color: ConstantData.mainTextColor,
                                    fontFamily: ConstantData.fontFamily)),
                            textStyle: TextStyle(
                                color: ConstantData.mainTextColor,
                                fontFamily: ConstantData.fontFamily),
                            dialogTextStyle: TextStyle(
                                color: ConstantData.mainTextColor,
                                fontFamily: ConstantData.fontFamily),

                            showFlagDialog: true,
                            hideSearch: true,
                            comparator: (a, b) => b.name.compareTo(a.name),

                            onInit: (code) {
                              // countryCode = code.dialCode;
                              print(
                                  "on init ${code.name} ${code.dialCode} ${code.name}");
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: subHeight,
                            padding: EdgeInsets.only(left: 7),
                            margin: EdgeInsets.only(left: 7),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: ConstantData.cellColor,


                              borderRadius: BorderRadius.all(
                                Radius.circular(radius),
                              ),
                            ),
                            child: TextField(
                              // controller: myController,
                              onChanged: (value) async {
                                try {} catch (e) {
                                  print("resge$e");
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.only(left: ConstantWidget.getWidthPercentSize(context, 2)),

                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: S.of(context).phoneNumber,
                                  hintStyle: TextStyle(
                                      fontFamily: ConstantData.fontFamily,
                                      color: ConstantData.textColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: fontSize)),
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ], // Only numbers can be entered
                            ),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ),


                  ConstantWidget.getPasswordTextFiled(
                      context, S.of(context).password, textPasswordController),




                    ConstantWidget.getButtonWidget(context, S.of(context).signUp,
                        ConstantData.primaryColor, () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneVerification(),));
                        }),




                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ConstantWidget.getTextWidget(
                          S.of(context).youHaveAnAlreadyAccount,
                          ConstantData.mainTextColor,
                          TextAlign.left,
                          FontWeight.w500,
                          ConstantWidget.getScreenPercentSize(context, 1.8)),

                      SizedBox(
                        width: ConstantWidget.getScreenPercentSize(context, 0.5),
                      ),
                      InkWell(
                        child: ConstantWidget.getTextWidget(
                            S.of(context).signIn,
                            ConstantData.primaryColor,
                            TextAlign.start,
                            FontWeight.bold,
                            ConstantWidget.getScreenPercentSize(context, 2)),onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                      },
                      )

                    ],
                  )



                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }
}
