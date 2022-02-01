import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/cart_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget {
  TextEditingController qtyController = TextEditingController();

  ProductWidget({
    Key key,
    this.width,
    @required this.product,
    @required this.session,
    this.productPage = true,
  }) : super(key: key);

  final double width;
  final Product product;
  final String session;
  final productPage;
  static const bool showInputBox = false;
  var qtyTxt = "0".obs;
  String _beforeChange;

  getCartButton(
      {@required var icon,
      @required Function function,
      double height = 21,
      Color color = Colors.grey,
      bool delBtn = false}) {
    // double height = ConstantWidget.getScreenPercentSize(context, 4);
    return InkWell(
      child: Container(
        height: height,
        // margin: EdgeInsets.symmetric(horizontal: ConstantWidget.getPercentSize(height, 30)),
        width: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: delBtn ? Colors.red : Colors.transparent,
            border: Border.all(
                color: color, width: ConstantWidget.getPercentSize(height, 1))),
        child: Icon(
          icon,
          size: ConstantWidget.getPercentSize(height, 60),
          color: color,
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
    ProductController pc = Get.find<ProductController>();
    CartController cc = Get.find<CartController>();
    qtyController.text = cc.getItemCount(product);
    qtyTxt.value = cc.getItemCount(product);
    //qtyController.text = product.cartquantity.value;
    // print('The calculated sub total is : ${product.subtotal}');
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
                                      product.quantity.toString(),
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
                                buildPriceRow(),
                                buildSavingsRow(),
                                SizedBox(
                                  height: 5,
                                ),
                                // Add button
                                Row(
                                  children: [
                                    Visibility(
                                      visible: !product.inCart.value,
                                      child: SizedBox(
                                        height: 22,
                                        width: 70,
                                        child: ElevatedButton(
                                          onPressed: addToCart,
                                          child: const Text(
                                            'Add',
                                            style: TextStyle(
                                              fontSize: 11,
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
                                              function: minusItem),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          //Show quantity in inputbox , editable
                                          Visibility(
                                            visible: showInputBox,
                                            child: SizedBox(
                                              width: 60,
                                              height: 20,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                onTap: () {
                                                  beforeChange();
                                                },
                                                onChanged: (v) {
                                                  updateCartQty(v);
                                                },
                                                onEditingComplete:
                                                    editingComplete,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                cursorColor: Colors.grey,

                                                controller: qtyController,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    height: 2,
                                                    fontFamily:
                                                        ConstantData.fontFamily,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    // width: 0.0 produces a thin "hairline" border
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.0),
                                                  ),
                                                  // hintText: 'Full Name',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            //Show quantity in text , non editable
                                            visible: !showInputBox,
                                            child: GestureDetector(
                                              onTap: () {
                                                showTextBox(context);
                                              },
                                              child: Container(
                                                color: Colors.grey.shade50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    getCustomText(
                                                      qtyTxt.value,
                                                      ConstantData
                                                          .mainTextColor,
                                                      2,
                                                      TextAlign.center,
                                                      FontWeight.w500,
                                                      ConstantWidget
                                                          .getScreenPercentSize(
                                                              context, 2.2),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          getCartButton(
                                            icon: CupertinoIcons.plus,
                                            function: plusItem,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          getCartButton(
                                            icon: CupertinoIcons.delete_solid,
                                            color: Colors.white,
                                            function: clearItem,
                                            delBtn: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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

  Row buildSavingsRow() {
    if (productPage) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'MRP : ',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            '\u{20B9} ' + product.oldmrp.toString(),
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            product.percent ?? '',
            style: TextStyle(
              color: Colors.greenAccent.shade700,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Saving : ',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 13,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            '\u{20B9} ' +
                ((product.oldmrp - product.newmrp) * product.cartquantity.value)
                    .toStringAsFixed(2),
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
            ),
          ),
        ],
      );
    }
  }

  Row buildPriceRow() {
    if (productPage) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\u{20B9} ' + product.newmrp.toString(),
            style: TextStyle(
              color: Colors.pinkAccent.shade400,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            width: 15,
            height: 25,
          ),
          // Add button clicked
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => Text(
                '\u{20B9} ' +
                    (product.oldmrp * product.cartquantity.value).toString(),
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              )),

          SizedBox(
            width: 8,
          ),
          Obx(
            () => Text(
              '\u{20B9} ' +
                  (product.newmrp * product.cartquantity.value).toString(),
              style: TextStyle(
                color: Colors.pinkAccent.shade400,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),

          // Add button clicked
        ],
      );
    }
  }

  addToCart() async {
    try {
      Get.find<CartController>();
    } catch (e) {
      Get.put<CartController>(CartController());
    } finally {
      CartController cc = Get.find<CartController>();
      String x = qtyController.text;
      int maxQty = product.quantity;
      int qty = int.tryParse(x) == null ? 0 : int.parse(x);
      if (maxQty > 0) {
        int responseStatus =
            await ApiService.addNewItem(product: product, session: session);
        print('Response ststus :${responseStatus}');
        //product.cartquantity.value = responseStatus.toString();
        qty++;
        qtyController.text = qty.toString();
        qtyTxt.value = qty.toString();
        product.inCart(true);
        cc.incrementCount(product);
      } else {
        print('Item out of stocl');
      }
    }
  }

  plusItem() async {
    try {
      Get.find<CartController>();
    } catch (e) {
      Get.put<CartController>(CartController());
    } finally {
      CartController cc = Get.find<CartController>();
      print('One product added/incremented');
      String x = qtyController.text; //product.cartquantity.value;
      int maxQty = product.quantity;
      int qty = int.tryParse(x) == null ? 0 : int.parse(x);
      // print('Max qty : ${maxQty}, Qty: ${qty}');
      if (qty < maxQty) {
        var newProducts =
            await ApiService.plusItem(product: product, session: session);
        if (newProducts == 1) {
          // print('New product added successful');
          qty++;
          qtyController.text = qty.toString();
          qtyTxt.value = qty.toString();
          product.inCart(true);
          cc.incrementCount(product);
        } else {
          print('Product status not 1');
        }
      } else {
        print('Product max qty issue');
        //do nothing
      }
    }
  }

  clearItem() async {
    try {
      Get.find<CartController>();
    } catch (e) {
      Get.put<CartController>(CartController());
    } finally {
      CartController cc = Get.find<CartController>();
      String x = qtyController.text; //product.cartquantity.value;
      int qty = int.tryParse(x) == null ? 0 : int.parse(x);
      print('Clear Item');
      bool updateQty = false;
      //call deteleCart
      var delStatus =
          await ApiService.deleteItem(product: product, session: session);
      if (delStatus == 1) {
        updateQty = true;
      }

      if (updateQty) {
        qty = 0;
        if (qty == 0) {
          product.inCart(false);
        }
        cc.removeFromCart(product, allQty: true);
      }
    }
  }

  minusItem() async {
    try {
      Get.find<CartController>();
    } catch (e) {
      Get.put<CartController>(CartController());
    } finally {
      CartController cc = Get.find<CartController>();
      String x = qtyController.text; //product.cartquantity.value;
      int qty = int.tryParse(x) == null ? 0 : int.parse(x);
      print('One product deleted');
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
        qtyController.text = qty.toString();
        qtyTxt.value = qty.toString();
        cc.decrementCount(product);
      }
    }
  }

  updateCartQty(v) {
    print('In Onchanged event');

    // print('Text Controller value ${qtyController.text}');
    // print('Updatimng cart qty ${v}');
    if (v == null) {
      print('Null not allowed');
    }
    if (int.tryParse(v) == null) {
      print('Invalid value of number');
      // qtyController.text = _beforeChange;
    }
  }

  beforeChange() {
    print('In onTap');
    //print('Before change ${qtyController.text}');
    // _beforeChange = qtyController.text;
  }

  editingComplete() {
    print('Editing complted');
  }

  checkAndUpdateCartQty(context) async {
    try {
      Get.find<CartController>();
    } catch (e) {
      Get.put<CartController>(CartController());
    } finally {
      CartController cc = Get.find<CartController>();
      String x = qtyController.text; //product.cartquantity.value;
      int qty = int.tryParse(x) == null ? 0 : int.parse(x);

      print('Calling update qty after check');
      String newQty = qtyController.text;
      String oldQty = qtyTxt.value;
      int maxQtyVal = product.quantity;

      if (int.tryParse(newQty) == null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        const errorSnackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Incorrect Quantity. Can\'t  update!!',
              style: TextStyle(
                color: Colors.white,
              )),
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      } else {
        int oldQtyVal = int.parse(oldQty);
        int newQtyVal = int.parse(newQty);
        if (newQtyVal > maxQtyVal) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          const errorSnackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
                'Your order quantity more than available quantity. Can\'t  update!!',
                style: TextStyle(
                  color: Colors.white,
                )),
          );
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        } else if (newQtyVal <= 0) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          const errorSnackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Your order quantity can\'t be less than one!!',
                style: TextStyle(
                  color: Colors.white,
                )),
          );
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          var newProducts = await ApiService.updateQuantityforItem(
              product: product, session: session, newQuantity: newQty);
          if (newProducts == 1) {
            print('New product added successful');
            qtyController.text = qty.toString();
            qtyTxt.value = qty.toString();
            cc.updateCount(product, oldQtyVal, newQtyVal);

            product.inCart(true);
            const successSnackBar = SnackBar(
              backgroundColor: Colors.green,
              content: Text('Quantity Successfully Updated!!',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            );
            ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            const errorSnackBar = SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                  'Your order quantity can\'t was not updated. Try later!!',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            );
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
            print('Product status not 1');
          }
        }
      }
    }
  }

  showTextBox(context) {
    print('This is to show text box');
    qtyController.text = qtyTxt.value;
    final snackBar = SnackBar(
      duration: Duration(seconds: 30),
      content: Row(
        children: [
          Text('New Quantity : '),
          SizedBox(
            width: 60,
            height: 20,
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onTap: () {
                beforeChange();
              },
              onChanged: (v) {
                updateCartQty(v);
              },
              onEditingComplete: editingComplete,
              // keyboardType:
              //     TextInputType.number,
              cursorColor: Colors.white,

              controller: qtyController,
              maxLines: 1,
              style: TextStyle(
                  height: 1.5,
                  fontFamily: ConstantData.fontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                // hintText: 'Full Name',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              checkAndUpdateCartQty(context);
            },
            child: SizedBox(
              height: 25,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Cancel',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
