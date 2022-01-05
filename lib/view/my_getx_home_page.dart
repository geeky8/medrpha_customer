import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/controller/category_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myWidget/product_widget.dart';
import 'package:flutter_medical_ui/myutil/common_function.dart';
import 'package:get/get.dart';

class MyNewHomePage extends StatelessWidget {
  // const MyNewHomePage({Key key}) : super(key: key);
  ProductController productController = Get.put(ProductController());
  CategoryController categoryController = Get.put(CategoryController());

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
              //Container to display the category list
              Container(
                height: 80,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => getUpdatedProductList(0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.red,
                              ),
                            ),
                            Text('All'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GetX<CategoryController>(builder: (controller) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categoryList.length,
                          itemBuilder: (BuildContext context, index) {
                            Category category = controller.categoryList[index];
                            // print(category.categoryName);
                            //return Text(category.categoryName ?? 'Not available');
                            return GestureDetector(
                              onTap: () =>
                                  getUpdatedProductList(category.catid),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          category.base_url +
                                              category.imagedata),
                                    ),
                                    Text(category.categoryName),
                                  ],
                                ),
                              ),
                            );

                            // return Text(product.productName);
                          },
                        );
                      }),
                    ),
                  ],
                ),
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
                                width: width,
                                product: product,
                                controller: controller,
                              );
                            },
                          );
                        } else {
                          return Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Nothing to display',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ));
                        }
                      },
                    ),
                  );
                else
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
              }),

              Obx(() =>
                  Text('Total Count ${categoryController.categoryCount}')),
              OutlinedButton(
                onPressed: categoryController.getCatCount,
                child: const Text('Increment'),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )),
    );
  }

  getUpdatedProductList(int catid) {
    print('In updated product liet ${catid}');

    Get.find<ProductController>().getProductByCat(catid);
  }
}
