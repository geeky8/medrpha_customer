import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/myWidget/product_view_not_in_use.dart';

class TestProduct extends StatefulWidget {
  @override
  _TestProductState createState() => _TestProductState();
}

class _TestProductState extends State<TestProduct> {
  @override
  Widget build(BuildContext context) {
    // double margin = ConstantWidget.getScreenPercentSize(context, 2);
    // double height = SizeConfig.safeBlockHorizontal * 45;
    // double width = SizeConfig.safeBlockHorizontal;
    // double width2 = ConstantWidget.getWidthPercentSize(context, 60);
    // double sideMargin = margin * 1.2;
    // double firstHeight = ConstantWidget.getPercentSize(height, 60);
    // double remainHeight = height - firstHeight;
    //
    // double radius = ConstantWidget.getPercentSize(height, 5);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Prduct'),
      ),
      body: ProductView(width: width),
    );
  }
}
