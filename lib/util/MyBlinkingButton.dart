

import 'package:flutter/material.dart';

import 'ConstantData.dart';


class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return FadeTransition(
      opacity: _animationController,


      child:

        Container(
            // height: ConstantWidget.getPercentSize(height, 35),
            // width: ConstantWidget.getPercentSize(height, 35),
            decoration: BoxDecoration(
                color: ConstantData.cellColor, shape: BoxShape.circle),
            child:
               Center(
                  child: Icon(
                Icons.play_arrow,
                color: ConstantData.accentColor,
              )),

          )

      // child: MaterialButton(
      //   minWidth: ConstantWidget.getPercentSize(height, 35),
      //   height: ConstantWidget.getPercentSize(height, 35),
      //   onPressed: () => null,
      //   child: Container(
      //     // height: ConstantWidget.getPercentSize(height, 35),
      //     // width: ConstantWidget.getPercentSize(height, 35),
      //     decoration: BoxDecoration(
      //         color: ConstantData.cellColor, shape: BoxShape.circle),
      //     child:
      //        Center(
      //           child: Icon(
      //         Icons.play_arrow,
      //         color: ConstantData.accentColor,
      //       )),
      //
      //   ),
      //   color: Colors.transparent,
      //   splashColor: Colors.transparent,
      // ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
