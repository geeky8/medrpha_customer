import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/navigation_service.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myWidget/loading.dart';
import 'package:flutter_medical_ui/myWidget/no_item_found.dart';
import 'package:flutter_medical_ui/myWidget/product_widget.dart';
import 'package:get/get.dart';

import 'my_getx_home_page.dart';

class MySearchPage extends StatelessWidget {
  final GlobalKey<FormState> _formKeySearch = GlobalKey<FormState>();
  static ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _session = ls.getSessionValue();
    return WillPopScope(
      onWillPop: () {
        Get.find<ProductController>().getProductList();
        return Navigator.pushReplacement(
          NavigationService.navigatorKey.currentContext,
          MaterialPageRoute(
            builder: (context) => MyNewHomePage(),
          ),
        );
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Search Product'),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Form(
                    key: _formKeySearch,
                    child: TextFormField(
                        // initialValue: cs.customer.value.gstno,
                        decoration: const InputDecoration(
                          hintText: 'Enter Product name/manufacturer',
                        ),
                        onEditingComplete: () {
                          print('search file');
                        },
                        onSaved: (e) {
                          print('saved');
                        },
                        onChanged: (e) {
                          //Setting the productController searchString
                          print('The changed value : ${e}');
                          productController.searchString.value = e;
                        },
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Search text';
                          }
                          return null;
                        }),
                  ),
                  Obx(() {
                    if (productController.loaded.value)
                      return Expanded(
                        child: GetX<ProductController>(
                          builder: (controller) {
                            if (controller.products.length > 0) {
                              return ListView.builder(
                                itemCount: controller.products.length,
                                itemBuilder: (BuildContext context, index) {
                                  Product product = controller.products[index];
                                  return ProductWidget(
                                    // width: width,
                                    product: product,
                                    session: _session,
                                  );
                                },
                              );
                            } else {
                              return NoItemFound();
                            }
                          },
                        ),
                      );
                    else
                      return loading();
                  }),
                ],
              ),
            )),
      ),
    );
  }
}
