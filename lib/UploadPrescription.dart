import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/SelectPrescriptionAddress.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/CustomDialog.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/StepModel.dart';

import 'generated/l10n.dart';

class UploadPrescription extends StatefulWidget {
  @override
  _UploadPrescription createState() {
    return _UploadPrescription();
  }
}

class _UploadPrescription extends State<UploadPrescription> {
  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  TextEditingController phController = new TextEditingController();
  TextEditingController textTitleController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController personController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  List<StepModel> stepModelList = DataFile.getStepsModel();
  int value = 1;
  PickedFile _image;
  final picker = ImagePicker();

  _imgFromGallery() async {
    PickedFile image =
    await ImagePicker().getImage(source: ImageSource.gallery);
    print(image.path);
    setState(() {
      _image = image;
    });



  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ConstantData.setThemePosition();

    double subHeight = ConstantWidget.getScreenPercentSize(context, 8.5);

    double radius = ConstantWidget.getPercentSize(subHeight, 20);
    double fontSize = ConstantWidget.getPercentSize(subHeight, 25);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            centerTitle: true,
            title:
                ConstantWidget.getAppBarText(S.of(context).uploadPrescription),
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
                margin: EdgeInsets.symmetric(horizontal:
                    ConstantWidget.getScreenPercentSize(context, 2)),
                child: ListView(
                  children: [
                    ConstantWidget.getPrescriptionTextFiled(
                        context,
                        Icons.account_circle_sharp,
                        S.of(context).selectPerson,
                        personController, () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(context, value, (v) {
                              setState(() {
                                value = v;
                                personController.text = value.toString();
                              });
                            });
                          });
                    }),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ConstantWidget.getScreenPercentSize(
                              context, 1.2)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: subHeight,
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
                                  size: ConstantWidget.getScreenPercentSize(
                                      context, 3),
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
                                    borderSide: BorderSide(
                                        color: ConstantData.textColor),
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
                                controller: phController,
                                onChanged: (value) async {
                                  try {} catch (e) {
                                    print("resge$e");
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left:
                                            ConstantWidget.getWidthPercentSize(
                                                context, 2)),
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
                    ConstantWidget.getDefaultTextFiledWidget(
                        context, S.of(context).title, textTitleController),
                    ConstantWidget.getPrescriptionTextFiled(
                        context,
                        Icons.calendar_today,
                        S.of(context).mmddyyyy,
                        dateController, () {
                      _selectDate();
                    }),
                    ConstantWidget.getPrescriptionDesc(
                        context,
                        S.of(context).enterPrescriptionDescription,
                        descController),

                    getImage(),
                    ConstantWidget.getBottomText(
                        context, S.of(context).uploadPrescription, () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SelectPrescriptionAddress(),));
                    }),
                  ],
                )),
          ),
        ),
        onWillPop: _requestPop);
  }

   Widget getImage() {
    double height = ConstantWidget.getScreenPercentSize(context,10);


    double radius = ConstantWidget.getPercentSize(ConstantWidget.getScreenPercentSize(context, 8.5), 20);

    
    return Wrap(
      children: [
       InkWell(child:  Container(
         height: height,
         width:  (_image != null && _image.path.isNotEmpty)?height:double.infinity,
         margin: EdgeInsets.symmetric(
             vertical: ConstantWidget.getScreenPercentSize(context, 1.2)),
         padding: EdgeInsets.symmetric(
             horizontal: ConstantWidget.getWidthPercentSize(context, 2)),
         alignment: Alignment.topRight,
         decoration: BoxDecoration(
           color: ConstantData.cellColor,

           borderRadius: BorderRadius.all(
             Radius.circular((_image != null && _image.path.isNotEmpty)?0:radius),
           ),
         ),
         child: getProfileImage(),
       ),
           onTap: (){_imgFromGallery();})
      ],);
  }

  getProfileImage() {

    if (_image != null && _image.path.isNotEmpty) {
      return Center(
        child: Image.file(
          File(_image.path),
          fit: BoxFit.cover,
        ),
      );
    }else {
      //
      return Center(child: ConstantWidget.getTextWidget(S.of(context).addImage, ConstantData.mainTextColor, TextAlign.center, FontWeight.w500, ConstantData.font22Px),);
    }

  }

  _selectDate() async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: ConstantData.mainTextColor,
              onPrimary: ConstantData.cellColor,
              surface: ConstantData.cellColor,
              onSurface: ConstantData.mainTextColor,
            ),
            dialogBackgroundColor: ConstantData.cellColor,
          ),
          child: child,
        );
      },
    );

    if (pickedDate != null)
      setState(() {
        dateController.text =
            DateFormat(ConstantData.dateFormat).format(pickedDate);
      });
  }

  getRow(String s) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ConstantWidget.getScreenPercentSize(context, 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.brightness_1,
            color: ConstantData.textColor,
            size: ConstantWidget.getScreenPercentSize(context, 1.5),
          ),
          SizedBox(
            width: ConstantWidget.getScreenPercentSize(context, 1.5),
          ),
          ConstantWidget.getCustomTextWithoutAlign(
              s,
              ConstantData.textColor,
              FontWeight.w300,
              ConstantWidget.getScreenPercentSize(context, 1.7)),
        ],
      ),
    );
  }



}
