import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myWidget/product_widget.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';

class MyNewHomePage extends StatelessWidget {
  // const MyNewHomePage({Key key}) : super(key: key);
  final ProductController productconroller = Get.put(ProductController());
  @override
  onInit() {
    print('In init');
  }

  @override
  Widget build(BuildContext context) {
    CommonFunctions cf = CommonFunctions();
    // int userType =  cf.showPrice();
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
          ),
          body: Column(
            children: [
              Expanded(
                child: GetX<ProductController>(builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (BuildContext context, index) {
                      Product product = controller.products[index];
                      print(product.productName);
                      return ProductWidget(width: width, product: product);
                      // return Text(product.productName);
                    },
                  );
                }),
              ),
              Text('Total Count'),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }
}
