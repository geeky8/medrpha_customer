import 'package:flutter/material.dart';

class uploadBtn extends StatelessWidget {
  uploadBtn(
      {Key key,
      @required this.iconName,
      @required this.iconColor,
      @required this.fn,
      @required this.btnText,
      this.height = 40,
      this.bgColor})
      : super(key: key);
  IconData iconName;
  Color iconColor, bgColor;
  Function fn;
  String btnText;
  double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.grey.shade50,
            border: Border.all(
              color: Colors.blueGrey.shade400,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Icon(
              iconName,
              color: iconColor,
              size: height,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              btnText,
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
