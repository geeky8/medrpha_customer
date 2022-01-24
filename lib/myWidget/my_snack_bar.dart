import 'package:flutter/material.dart';

void showSnackbarDialog(BuildContext bc, String message,
    {Color bgColor = Colors.red}) {
  ScaffoldMessenger.of(bc).hideCurrentSnackBar();
  var errorSnackBar = SnackBar(
    backgroundColor: bgColor,
    content: Text(message.toString(),
        style: TextStyle(
          color: Colors.white,
        )),
  );
  ScaffoldMessenger.of(bc).showSnackBar(errorSnackBar);
}
