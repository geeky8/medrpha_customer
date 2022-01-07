import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key key,
    @required this.width,
    @required this.product,
    @required this.session,
  }) : super(key: key);

  final _displayAddBtnOnSide = false;
  final double width;
  final Product product;
  final String session;
  getCartButton(
      {@required var icon, @required Function function, double height = 19}) {
    // double height = ConstantWidget.getScreenPercentSize(context, 4);
    return InkWell(
      child: Container(
        height: height,
        // margin: EdgeInsets.symmetric(horizontal: ConstantWidget.getPercentSize(height, 30)),
        width: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
                color: Colors.grey,
                width: ConstantWidget.getPercentSize(height, 2))),
        child: Icon(
          icon,
          size: ConstantWidget.getPercentSize(height, 50),
          color: Colors.grey,
        ),
      ),
      onTap: function,
    );
  }

  static Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontFamily: ConstantData.fontFamily,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    String qty = '0';
    // final LocalSessionController ls = Get.find<LocalSessionController>();
    ProductController pc = Get.find<ProductController>();

    // final String _session = ls.getSessionValue();
    // final bool regComplete = ls.getProfileCompletionStatus();
    // final bool adminApproval = ls.getAdminAprovalStatus();
    // print('Product ${product.productName} in cart : ${product.inCart.value}');
    return Card(
      margin: EdgeInsets.all(3),
      child: Container(
        width: width,
        // height: 200,
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: Container(
          // margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          // decoration: BoxDecoration(
          //   color: ConstantData.bgColor,
          //   borderRadius: BorderRadius.circular(15),
          //   border: Border.all(
          //     color: ConstantData.borderColor,
          //     // width: ,
          //   ),
          // ),
          child: Row(
            children: [
              Container(
                width: 70,
                child: Image.network(Product.base_url + product.productImg),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.categorystr + '/' + product.compnaystr,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        product.saleqtytypestr +
                            ' of ' +
                            product.prodsaletypedetails,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Visibility(
                          visible: pc.showProduct.value,
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Available Qty:',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      product.quantity,
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.newmrp,
                                      style: TextStyle(
                                        color: Colors.pinkAccent.shade400,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //Add to cart plus minus button
                                    SizedBox(
                                      width: 15,
                                      height: 25,
                                    ),
                                    // Add button clicked
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MRP : ',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    Text(
                                      product.oldmrp,
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      product.percent,
                                      style: TextStyle(
                                        color: Colors.greenAccent.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Add button
                                Visibility(
                                  visible: !_displayAddBtnOnSide,
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: !product.inCart.value,
                                        child: SizedBox(
                                          height: 20,
                                          width: 70,
                                          child: ElevatedButton(
                                            onPressed: addToCart,
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // plus minus btn
                                      Visibility(
                                        visible: product.inCart.value,
                                        child: Row(
                                          children: [
                                            getCartButton(
                                                icon: CupertinoIcons.minus,
                                                function: deleteItem),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print("Open as text box");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Row(
                                                      children: [
                                                        const Text(
                                                            'Enter Quanlity'),
                                                      ],
                                                    ),
                                                    action: SnackBarAction(
                                                      label: 'Action',
                                                      onPressed: () {
                                                        // Code to execute.
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: getCustomText(
                                                product.cartquantity.value,
                                                ConstantData.mainTextColor,
                                                2,
                                                TextAlign.start,
                                                FontWeight.w500,
                                                ConstantWidget
                                                    .getScreenPercentSize(
                                                        context, 1.8),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            getCartButton(
                                              icon: CupertinoIcons.plus,
                                              function: plusItem,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addToCart() async {
    // print(product.cartquantity.value);
    // print('Add to cahrt btn ${product.pid} clicked for add btn');
    // product.inCart(true);
    product.cartquantity.value = '1';
    String max = product.quantity;
    int maxQty = int.tryParse(max) == null ? 0 : int.parse(max);
    if (maxQty > 0) {
      int responseStatus =
          await ApiService.addNewItem(product: product, session: session);
      print('Response ststus :${responseStatus}');
      product.cartquantity.value = responseStatus.toString();
      product.inCart(true);
    } else {
      print('Item out of stocl');
    }
  }

  plusItem() async {
    print('One product added');
    String x = product.cartquantity.value;
    String max = product.quantity;
    int qty = int.tryParse(x) == null ? 0 : int.parse(x);
    int maxQty = int.tryParse(max) == null ? 10000 : int.parse(max);
    // print('Max qty : ${maxQty}, Qty: ${qty}');
    if (qty < maxQty) {
      var newProducts =
          await ApiService.plusItem(product: product, session: session);
      if (newProducts == 1) {
        print('New product added successful');
        qty++;
        product.cartquantity.value = qty.toString();
        product.inCart(true);
      } else {
        print('Product status not 1');
      }
    } else {
      print('Product max qty issue');
      //do nothing
    }
  }

  deleteItem() async {
    print('One product deleted');
    String x = product.cartquantity.value;
    int qty = int.tryParse(x) == null ? 0 : int.parse(x);
    bool updateQty = false;
    if (qty > 1) {
      //call cartMinus
      var newProducts =
          await ApiService.minusItem(product: product, session: session);
      if (newProducts == 1) {
        updateQty = true;
      }
    } else {
      //call deteleCart
      var delStatus =
          await ApiService.deleteItem(product: product, session: session);
      if (delStatus == 1) {
        updateQty = true;
      }
    }
    if (updateQty) {
      qty > 0 ? qty-- : qty;
      if (qty == 0) {
        product.inCart(false);
      }
      product.cartquantity.value = qty.toString();
    }
  }
}
