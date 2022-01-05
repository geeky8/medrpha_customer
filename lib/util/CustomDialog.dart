import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';
import 'package:numberpicker/numberpicker.dart';

import 'ConstantData.dart';
import 'ConstantWidget.dart';

class CustomDialog extends StatefulWidget {

final BuildContext context;
 final int index;
 final ValueChanged<int> onChanged;




  @override
  _CustomDialog createState() {
  return _CustomDialog();
  }
  CustomDialog(this.context,this.index,this.onChanged);





}


class _CustomDialog extends State<CustomDialog>{



  @override
  Widget build(BuildContext context) {


    double height= ConstantWidget.getScreenPercentSize(context,70);
    double radius= ConstantWidget.getPercentSize(height,2);
    return StatefulBuilder(builder: (context, setState) {

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 0.0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: dialogContent(context,setState),
      );
    },);
  }





  int position;


  @override
  void initState() {
    super.initState();
    position=widget.index;
    setState(() {});
  }






  dialogContent(BuildContext context,var setState) {

    // int position =await PrefData.getPosition() ;



    // setThemePosition( setState);





    double height= ConstantWidget.getScreenPercentSize(context,40);
    double width= ConstantWidget.getWidthPercentSize(context,90);
    double radius= ConstantWidget.getPercentSize(height,2);
    return Container(

      height: height,
      width: width,
      padding: EdgeInsets.all((radius*2)),
      decoration: new BoxDecoration(
        color: ConstantData.cellColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: ConstantData.shadowColor,

          ),
        ],
      ),
      child: Stack(
        children: <Widget>[





          Align(
            alignment: Alignment.center,
            child: NumberPicker(
              value: position,
              minValue: 1,
              maxValue: 50,
              textStyle: TextStyle(
                  fontSize: ConstantWidget.getScreenPercentSize(context, 2),
                  color: ConstantData.mainTextColor,
                  fontFamily: ConstantData.fontFamily),
              selectedTextStyle: TextStyle(
                  fontSize: ConstantWidget.getScreenPercentSize(context, 5),
                  color: ConstantData.accentColor,
                  fontFamily: ConstantData.fontFamily),
              step: 1,
              haptics: true,
              onChanged: (value) => setState(() {

                position= value;

              }),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              child: ConstantWidget.getTextWidget(S.of(widget.context).ok, ConstantData.accentColor, TextAlign.start, FontWeight.bold, ConstantData.font22Px),
              onTap: (){
                widget.onChanged(position);
                Navigator.pop(widget.context);
              },
            ),

          )






        ],
      ),
    );
  }


}
