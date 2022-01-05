import 'package:flutter/material.dart';

void mySnakBar({BuildContext context, String msg, bool errMsg = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: errMsg ? Colors.red : Colors.teal,
        ),
      ),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    ),
  );
}
