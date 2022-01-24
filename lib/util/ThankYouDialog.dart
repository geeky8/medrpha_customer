import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/generated/l10n.dart';

import '../MyOrderPage.dart';
import 'ConstantData.dart';
import 'ConstantWidget.dart';

class ThankYouDialog extends StatefulWidget {
  final BuildContext context;
  final ValueChanged<int> onChanged;

  @override
  _ThankYouDialog createState() {
    return _ThankYouDialog();
  }

  ThankYouDialog(this.context, this.onChanged);
}

class _ThankYouDialog extends State<ThankYouDialog> {
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
    setState(() {});
  }

  dialogContent(BuildContext context, var setState) {
    double height = ConstantWidget.getScreenPercentSize(context, 60);
    double width = ConstantWidget.getWidthPercentSize(context, 90);
    double radius = ConstantWidget.getPercentSize(height, 2);
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all((radius)),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ConstantData.assetsPath +
                      "accept-circular-button-outline.png",
                  color: ConstantData.primaryColor,
                  height: ConstantWidget.getPercentSize(height, 18),
                  width: ConstantWidget.getPercentSize(height, 18),
                ),
                SizedBox(
                  height: ConstantWidget.getPercentSize(
                    height,
                    5,
                  ),
                ),
                ConstantWidget.getTextWidget(
                    S.of(context).thankYou,
                    ConstantData.mainTextColor,
                    TextAlign.center,
                    FontWeight.bold,
                    ConstantWidget.getPercentSize(height, 7)),
                SizedBox(
                  height: ConstantWidget.getPercentSize(
                    height,
                    6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      style: new TextStyle(
                        // fontWeight: FontWeight.w600,
                        fontSize: ConstantData.font18Px,
                        fontFamily: ConstantData.fontFamily,
                        color: ConstantData.mainTextColor,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: 'Your order'),
                        new TextSpan(
                            text: ' #345678 ',
                            style: new TextStyle(
                                fontSize: ConstantData.font18Px,
                                fontWeight: FontWeight.bold,
                                color: ConstantData.textColor)),
                        new TextSpan(text: 'is Completed.'),
                      ],
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    style: new TextStyle(
                      fontSize: ConstantData.font12Px,
                      fontFamily: ConstantData.fontFamily,
                      color: ConstantData.mainTextColor,
                    ),
                    children: <TextSpan>[
                      new TextSpan(
                          text: 'Please check the Delivery status at',
                          style: new TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              fontSize: ConstantData.font18Px,
                              color: ConstantData.textColor)),
                      new TextSpan(
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => OrderTrackMap(),
                              //     ));
                            },
                          text: '\nOrder Tracking ',
                          style: new TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: ConstantData.font22Px,
                              color: ConstantData.accentColor)),
                      new TextSpan(
                          text: ' pages.',
                          style: new TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              fontSize: ConstantData.font18Px,
                              color: ConstantData.textColor)),
                    ],
                  ),
                ),
                SizedBox(
                  height: ConstantWidget.getScreenPercentSize(context, 3),
                ),
              ],
            ),
          )),
          // Expanded(child: Align(alignment: Alignment.bottomCenter,child: ConstantWidget.getBottomText(context, S.of(context).goToOrder, (){
          //   Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MyOrderPage(false),
          //       ));
          // }),))

          ConstantWidget.getBottomText(context, S.of(context).goToOrder, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyOrderPage(false),
                ));
          })
        ],
      ),
    );
  }
}
