import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({
    Key key,
  }) : super(key: key);

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
          'Nothing to display',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      ],
    ));
  }
}
