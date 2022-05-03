import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/navigation_service.dart';
import 'package:flutter_medical_ui/my_checkout_result.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';

class ConfirmDialogBox extends StatelessWidget {
  const ConfirmDialogBox({Key key, this.payLater}) : super(key: key);

  final int payLater;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      // backgroundColor: Colors.whi,
      child: ConfirmDIalogContent(payLater: payLater),
    );
  }
}

class ConfirmDIalogContent extends StatelessWidget {
  const ConfirmDIalogContent({
    Key key,
    @required this.payLater,
  }) : super(key: key);

  final int payLater;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConstantWidget.getScreenPercentSize(context, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Confirm Order',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                NavigationService.navigatorKey.currentContext,
                MaterialPageRoute(
                  builder: (context) => MyCheckoutResult(
                    paymentType: 1,
                    payLater: payLater,
                  ),
                ),
              );
            },
            child: Text('Confirm'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              primary: Colors.white,
              padding: EdgeInsets.only(left: 20, right: 20),
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
