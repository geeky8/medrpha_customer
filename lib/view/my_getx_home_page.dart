import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/AddToCartPage.dart';
import 'package:flutter_medical_ui/controller/category_controller.dart';
import 'package:flutter_medical_ui/controller/country_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myWidget/product_widget.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/view/my_profile_page.dart';
import 'package:get/get.dart';

class MyNewHomePage extends StatelessWidget {
  // const MyNewHomePage({Key key}) : super(key: key);

  static ProductController productController = Get.put(ProductController());
  static CategoryController categoryController = Get.put(CategoryController());
  var _selectedPage = 0.obs;
  double width = 0;
  static List<Widget> pages = [
    // const buildProductPage(),
    Container(child: buildProductPage()),
    Container(child: buildViewCart())
  ];

  void _onItemTap(int index) {
    print('Index tapped ${index}');
    _selectedPage.value = index;
  }

  @override
  Widget build(BuildContext context) {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _session = ls.getSessionValue();
    print('Session Value from localsession ${_session}');
    CountryController cc = Get.find<CountryController>();
    print('The country options length is : ${cc.countryOptions.length}');
    width = MediaQuery.of(context).size.width;
    const double drawerIconSize = 30;
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ConstantData.assetsPath + "logo_transparent.png",
                      height: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'New User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading:
                    Icon(CupertinoIcons.profile_circled, size: drawerIconSize),
                title: Text('Profile'),
                onTap: () {
                  userProfile(context);
                },
                // onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(4, 3, 0, 3),
            child: Image.asset(
              ConstantData.assetsPath + "logo_transparent.png",
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Medrpha'),
              SizedBox(
                height: 3,
              ),
              Text(
                'HEALTHCARE PRODUCTS',
                style: TextStyle(
                  fontSize: 7,
                ),
              )
            ],
          ),
        ),
        body: Obx(() => pages[_selectedPage.value]),
        bottomNavigationBar: Obx(
          () => SizedBox(
            height: 53,
            child: BottomNavigationBar(
              iconSize: 18,
              showSelectedLabels: true,
              onTap: _onItemTap,
              currentIndex: _selectedPage.value,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  tooltip: 'Back to Home',
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Items in cart(0)'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static buildViewCart() {
    return AddToCartPage();
  }

  static userProfile(context) {
    print('User profile clicked');
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyProfilePage(),
      ),
    );
  }

  static Column buildProductPage() {
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _session = ls.getSessionValue();
    return Column(
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
                        onTap: () => getUpdatedProductList(category.catid),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    category.base_url + category.imagedata),
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
                          // width: width,
                          product: product,
                          session: _session,
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

        Visibility(
          visible: false,
          child: Column(
            children: [
              Obx(() =>
                  Text('Total Count ${categoryController.categoryCount}')),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: categoryController.getCatCount,
                    child: const Text('Cat Cnt'),
                  ),
                  OutlinedButton(
                    onPressed: productController.testToggleVisibility,
                    child: const Text('Toggle visibility'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }

  static getUpdatedProductList(int catid) {
    print('In updated product liet ${catid}');

    Get.find<ProductController>().getProductByCat(catid);
  }
}
