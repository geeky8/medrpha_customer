import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key key,
    @required this.width,
    @required this.product,
  }) : super(key: key);
  final _displayAddBtnOnSide = false;
  final double width;
  final Product product;
  getCartButton(
      {@required var icon, @required Function function, double height = 20}) {
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
    bool _productPresent =
        int.tryParse(product.cartquantity) == null ? false : true;
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
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Visibility(
                                  visible: _displayAddBtnOnSide,
                                  child: Row(
                                    children: [
                                      //Add to cart btn
                                      Visibility(
                                        visible: !_productPresent,
                                        child: SizedBox(
                                          height: 20,
                                          width: 70,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              print(
                                                  'Add to cahrt btn ${product.cartquantity}');
                                              product.cartquantity = '1';
                                            },
                                            child: const Text(
                                              'Add',
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: _productPresent,
                                        child: Row(
                                          children: [
                                            getCartButton(
                                                icon: CupertinoIcons.minus,
                                                function: () {
                                                  print('minus clicked');
                                                }),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            getCustomText(
                                              product.cartquantity,
                                              ConstantData.mainTextColor,
                                              2,
                                              TextAlign.start,
                                              FontWeight.w500,
                                              ConstantWidget
                                                  .getScreenPercentSize(
                                                      context, 1.8),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            getCartButton(
                                                icon: CupertinoIcons.plus,
                                                function: () {
                                                  print('plus clicked');
                                                }),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                                    visible: !_productPresent,
                                    child: SizedBox(
                                      height: 20,
                                      width: 70,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print(product.cartquantity);
                                          print(
                                              'Add to cahrt btn ${product.pid} clicked');
                                          product.cartquantity = '1';
                                        },
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
                                    visible: _productPresent,
                                    child: Row(
                                      children: [
                                        getCartButton(
                                            icon: CupertinoIcons.minus,
                                            function: () {
                                              print('minus clicked');
                                            }),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        getCustomText(
                                          product.cartquantity,
                                          ConstantData.mainTextColor,
                                          2,
                                          TextAlign.start,
                                          FontWeight.w500,
                                          ConstantWidget.getScreenPercentSize(
                                              context, 1.8),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        getCartButton(
                                            icon: CupertinoIcons.plus,
                                            function: () {
                                              print('plus clicked');
                                            }),
                                      ],
                                    ),
                                  )
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
            ],
          ),
        ),
      ),
    );
  }
}
