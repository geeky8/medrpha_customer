import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/model/product.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key key, @required this.width, @required this.product})
      : super(key: key);

  final double width;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // height: 200,
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Container(
        // margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: ConstantData.bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ConstantData.borderColor,
            // width: ,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              child: Image.network(Product.base_url + product.productImg),
            ),
            Expanded(
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
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    product.saleqtytypestr +
                        ' of ' +
                        product.prodsaletypedetails,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Avalable Qty:',
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
                          children: [
                            Text(
                              product.newmrp,
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}
