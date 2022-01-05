import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';
import 'ConstantData.dart';
import 'package:flutter_medical_ui/model/AddressModel.dart';
import 'ConstantWidget.dart';
import 'CustomDropDown.dart';

class EditAddressDialog extends StatefulWidget {
  final BuildContext context;
  final ValueChanged<int> onChanged;
  
  final bool isBool;
  final AddressModel model;

  @override
  _EditAddressDialog createState() {
    return _EditAddressDialog();
  }

  EditAddressDialog(this.context, this.isBool,this.model,this.onChanged);
}

class _EditAddressDialog extends State<EditAddressDialog> {
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 70);
    double radius = ConstantWidget.getPercentSize(height, 2);
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0.0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: dialogContent(context, setState),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if(widget.isBool){
      textEditingController.text = widget.model.location;
      dropdownValue = widget.model.type;
    }
    setState(() {});
  }

  String dropdownValue = 'Home';

  List<String> spinnerItems = ['Home', 'Company', 'Office'];

  dialogContent(BuildContext context, var setState) {
    double height = ConstantWidget.getScreenPercentSize(context, 40);
    double width = ConstantWidget.getWidthPercentSize(context, 90);
    double radius = ConstantWidget.getPercentSize(height, 2);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: (radius*3),vertical: (radius*2)),
      decoration: new BoxDecoration(
        color: ConstantData.bgColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: ConstantData.shadowColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [



              Align(alignment: Alignment.centerLeft,
              child:   ConstantWidget.getTextWidget(widget.isBool?S.of(context).edit:S.of(context).address, ConstantData.mainTextColor, TextAlign.start, FontWeight.bold, ConstantData.font22Px),),

                SizedBox(
                  height: ConstantWidget.getPercentSize(
                    height,
                    4,
                  ),
                ),
                new Theme(
                  data: new ThemeData(
                      primaryColor: ConstantData.mainTextColor,
                      accentColor: ConstantData.accentColor,
                      hintColor: Colors.grey
                  ),
                  child: new TextField(
                    controller: textEditingController,
                    decoration: new InputDecoration(
                        hintText: "Enter your Name",
                        labelText: "Name",

                        labelStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: ConstantData.font18Px),
                        border: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantData.mainTextColor
                            )
                        )
                    ),
                  ),
                ),



                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 3),
                ),

                CustomDropDown(
                    errorText: "",
                    hint: "Type..",
                    items: spinnerItems
                        .asMap()
                        .map((int i, str) => MapEntry(
                        i,
                        DropdownMenuItem(

                          value: i,
                          child: Container(color: ConstantData.bgColor,
                          child: Text(str,style: TextStyle(color: ConstantData.mainTextColor),),),
                        )))
                        .values
                        .toList()
                        .cast<DropdownMenuItem<int>>(),
                    value: spinnerItems.indexOf(dropdownValue),
                    onChanged: (position) {



                      print("posuition====$position");

                      setState(() {
                        dropdownValue = spinnerItems[position];
                      });

                    }

                ),
                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 3),
                ),


                Align(alignment: Alignment.centerRight,
                  child:   InkWell(
                    child:
                    ConstantWidget.getTextWidget(S.of(context).ok,
                        ConstantData.accentColor, TextAlign.start, FontWeight.w500, ConstantData.font22Px),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),),


              ],
            ),
          )),


        ],
      ),
    );
  }
}
