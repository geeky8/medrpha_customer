import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';

class CustomDropDown extends StatelessWidget {
  final int value;
  final String hint;
  final String errorText;
  final List<DropdownMenuItem> items;
  final Function onChanged;

  const CustomDropDown(
      {Key key,
      this.value,
      this.hint,
      this.items,
      this.onChanged,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: ConstantData.bgColor,
              ),
              child: DropdownButton<int>(
                value: value,
                hint: Text(
                  hint,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                style: TextStyle(
                    fontFamily: ConstantData.fontFamily,
                    fontSize: ConstantData.font18Px,
                    color: ConstantData.mainTextColor),
                items: items,
                onChanged: (item) {
                  onChanged(item);
                },
                isExpanded: true,
                underline: Container(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ConstantData.mainTextColor,
                ),
              )),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 30, top: 10),
            child: Text(
              errorText,
              style: TextStyle(
                  fontSize: ConstantData.font15Px,
                  color: ConstantData.mainTextColor),
            ),
          )
      ],
    );
  }
}
