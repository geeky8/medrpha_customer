import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_medical_ui/controller/cart_controller.dart';
import 'package:flutter_medical_ui/controller/category_controller.dart';
import 'package:flutter_medical_ui/controller/country_controller.dart';
import 'package:flutter_medical_ui/controller/customer_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/category.dart';
import 'package:flutter_medical_ui/model/navigation_service.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/myWidget/loading.dart';
import 'package:flutter_medical_ui/myWidget/no_item_found.dart';
import 'package:flutter_medical_ui/myWidget/product_widget.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/view/my_profile_page.dart';
import 'package:flutter_medical_ui/view/my_search_page.dart';
import 'package:get/get.dart';

import '../MyPinVerification.dart';
import '../my_checkout_page.dart';
import '../my_order_history.dart';

class MyNewHomePage extends StatelessWidget {
  // const MyNewHomePage({Key key}) : super(key: key);

  static ProductController productController = Get.put(ProductController());
  static CategoryController categoryController = Get.put(CategoryController());
  static CustomerController custController = Get.put(CustomerController());

  var _selectedPage = 0.obs;
  var adminAprovedForCart;
  var filtered;
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
    String searchVal = '';

    LocalSessionController ls = Get.find<LocalSessionController>();
    print("Admin appreved stat: " + ls.getAdminAprovalStatus().toString());
    adminAprovedForCart = ls.getAdminAprovalStatus().obs;
    CustomerController cs = Get.find<CustomerController>();
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
                  color: Colors.white70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        ConstantData.assetsPath + "logo_transparent2.png",
                        height: 90,
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Text(
                        cs == null ? 'New User' : cs.customer.value.firmName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
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
              ListTile(
                leading:
                    Icon(CupertinoIcons.shopping_cart, size: drawerIconSize),
                title: Text('Order History'),
                onTap: () {
                  print('Order History clicked');
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => OrderDetailPage(),
                      builder: (context) => MyOrderHistory(),
                    ),
                  );
                },
                // onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.logout, size: drawerIconSize),
                title: Text('Logout'),
                onTap: () {
                  PrefData.setIsSignIn(false);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyPinVerification()));
                },
                // onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blueGrey),
          backgroundColor: Colors.white70,
          // leading: Padding(
          //   padding: const EdgeInsets.fromLTRB(4, 3, 0, 3),
          //   child: Image.asset(
          //     ConstantData.assetsPath + "logo_bar.png",
          //   ),
          // ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 0, 1),
                        child: Image.asset(
                          ConstantData.assetsPath + "logo_bar.png",
                          height: 45,
                        ),
                      )
                      // Text('Medrpha'),
                      // SizedBox(
                      //   height: 3,
                      // ),
                      // Text(
                      //   'HEALTHCARE PRODUCTS',
                      //   style: TextStyle(
                      //     fontSize: 7,
                      //   ),
                      // )
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: GestureDetector(
                      child: Icon(Icons.search),
                      onTap: () {
                        Navigator.push(
                          NavigationService.navigatorKey.currentContext,
                          MaterialPageRoute(
                            builder: (context) => MySearchPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Obx(() => pages[_selectedPage.value]),
        bottomNavigationBar: Obx(
          () => SizedBox(
            height: 53,
            child: BottomNavigationBar(
              iconSize: 16,
              showSelectedLabels: true,
              onTap: _onItemTap,
              currentIndex: _selectedPage.value,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  tooltip: 'Back to Home',
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label:
                        'Items in cart(${Get.find<CartController>().cartCount.value.toString()})'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static buildViewCart() {
    //return AddToCartPage();
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _session = ls.getSessionValue();
    CartController cc = Get.find<CartController>();
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Obx(
            () => cc.myCart.length > 0
                ? Expanded(
                    child: Obx(() => ListView.builder(
                        itemCount: cc.myCart.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product = cc.myCart[index];
                          return ProductWidget(
                            // width: width,
                            product: product,
                            session: _session,
                            productPage: false,
                          );
                        })),
                  )
                : Expanded(
                    child: Center(
                        child: NoItemFound(
                    msg: 'No Product in Cart',
                  ))),
          ),
          Obx(() => Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Total Payable',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          ' \u{20B9}${cc.finalPrice.value.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ConstantData.btnStylePrimary,
                        onPressed: cc.myCart.length > 0 &&
                                ls.getAdminAprovalStatus()
                            ? () {
                                Navigator.push(
                                  NavigationService.navigatorKey.currentContext,
                                  MaterialPageRoute(
                                    builder: (context) => MyCheckoutPage(),
                                  ),
                                );
                              }
                            : () {},
                        child:
                            Obx(() => Text('Checkout ${cc.cartCount} Item(s)')),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  static userProfile(context, {newUser = false}) {
    print('User profile clicked');
    if (!newUser) {
      Navigator.pop(context);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyProfilePage(),
      ),
    );
  }

  static Column buildProductPage() {
    GlobalKey<FormState> _formKeySearch = GlobalKey<FormState>();
    var filtered = true.obs;
    LocalSessionController ls = Get.find<LocalSessionController>();
    String _session = ls.getSessionValue();
    print('Session val from prod Build ${_session}');
    print(ls.mySession.adminApproved);
    print(
        'The total number of items in the cart is : ${Get.find<CartController>().cartCount.value.toString()}');
    print(
        'Total count of product in cart array is : ${Get.find<CartController>().myCart.value.length} ');
    // var _adminApprove = ls.mySession.adminApproved.obs;
    // var _regCompleted = ls.mySession.regCompleted.obs;
    print(
        'The value to regcomplte from buildProductPage is ${productController.regCompleted.value}');

    return Column(
      children: [
        //Container to display the category list
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Form(
                  key: _formKeySearch,
                  child: Obx(
                    () => TextFormField(
                        initialValue: productController.searchString.value,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                          isDense: true,
                          hintText: 'Search name/brand etc',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 5, bottom: 11, top: 15, right: 5),
                        ),
                        onEditingComplete: () {
                          print('search file');
                        },
                        onSaved: (e) {
                          print('saved');
                        },
                        onChanged: (e) {
                          //Setting the productController searchString
                          // searchVal = e;
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
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  filtered.value = true;
                  Get.find<CategoryController>().clearHighlight();
                  getUpdatedProductList(0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          backgroundColor:
                              filtered.value ? Colors.red : Colors.teal,
                          radius: 22,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.medical_services,
                              color: Colors.red,
                            ),
                          ),
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
                        onTap: () {
                          filtered.value = false;
                          getUpdatedProductList(category.catid);
                          controller.highlightCategory(category.catid);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Obx(
                                () => CircleAvatar(
                                  backgroundColor:
                                      category.highlighted.value == true
                                          ? Colors.red
                                          : Colors.cyan,
                                  radius: 22,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        category.base_url + category.imagedata),
                                  ),
                                ),
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
                    return NoItemFound();
                  }
                },
              ),
            );
          else
            return loading();
        }),
        Obx(() {
          return Visibility(
            visible: !Get.find<ProductController>().regCompleted.value,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Get.find<ProductController>().getApprovedStatus();
                      print('fn completed');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Complete Your Profile!!',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'You need to complete you profile to see product details',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      userProfile(NavigationService.navigatorKey.currentContext,
                          newUser: true);
                    },
                    child: Icon(
                      Icons.label_important,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        Obx(() {
          return Visibility(
            visible: !Get.find<ProductController>().adminApproved.value &&
                Get.find<ProductController>().regCompleted.value,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Your Profile is awaiting Admin Approval!! ',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Once your profile is approved you will able to see the price and shop',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () async {
                        await Get.find<ProductController>().getApprovedStatus();
                        print('fn completed');
                      },
                      child: Icon(Icons.autorenew_rounded)),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  static Widget getProfileComplete() {
    Obx(() {
      if (Get.find<ProductController>().regCompleted.value == true) {
        return SizedBox(
          height: 1,
        );
      } else {
        return Obx(() =>
            Text('hi ${!Get.find<ProductController>().regCompleted.value}'));
      }
    });
  }

  static getUpdatedProductList(int catid) {
    print('In updated product liet ${catid}');

    Get.find<ProductController>().getProductByCat(catid);
  }
}
