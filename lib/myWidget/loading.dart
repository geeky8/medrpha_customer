import 'package:flutter/material.dart';

class loading extends StatelessWidget {
  loading({Key key, this.context}) : super(key: key);
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
