import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({Key key, this.msg}) : super(key: key);

  final String msg;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ConstantData.assetsPath + "not_found.png",
          height: 130,
        ),
        SizedBox(height: 30),
        Text(
          msg == null ? 'Nothing to display' : msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }
}
