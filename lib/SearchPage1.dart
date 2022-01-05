// import 'package:flutter/material.dart';
// import 'package:flutter_medical_ui/AddToCartPage.dart';
// import 'package:flutter_medical_ui/ProductDetailPage.dart';
// import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
// import 'package:flutter_medical_ui/util/ConstantData.dart';
// import 'package:flutter_medical_ui/util/ConstantWidget.dart';
// import 'package:flutter_medical_ui/util/DataFile.dart';
// import 'package:flutter_medical_ui/util/SizeConfig.dart';
//
// import 'generated/l10n.dart';
// import 'FilterPage.dart';
//
// class SearchPage extends StatefulWidget{
//
//
//   @override
//   _SearchPage createState() {
//     return _SearchPage();
//   }
//
// }
//
// class _SearchPage extends State<SearchPage>{
//
//   List<SubCategoryModel> productList = DataFile.getSubCategoryModel();
//
//
//   Future<bool> _requestPop() {
//     Navigator.of(context).pop();
//     return new Future.value(true);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     double height = SizeConfig.safeBlockVertical * 8;
//     double imageSize = SizeConfig.safeBlockVertical * 8;
//
//     double imageSize1 = ConstantWidget.getPercentSize(imageSize, 50);
//     double margin = ConstantWidget.getScreenPercentSize(context, 1.5);
//
//    return WillPopScope(child: Scaffold(
//      backgroundColor: ConstantData.bgColor,
//      appBar: AppBar(
//        elevation: 0,
//        centerTitle: true,
//        backgroundColor: ConstantData.bgColor,
//
//        title: ConstantWidget.getAppBarText(S.of(context).search),
//
//        leading: Builder(
//          builder: (BuildContext context) {
//            return IconButton(
//              icon: ConstantWidget.getAppBarIcon(),
//              onPressed: _requestPop,
//            );
//          },
//        ),
//      ),
//      body: Container(
//        padding: EdgeInsets.symmetric(vertical: margin),
//
//        child: Column(
//          children: [
//
//            Container(
//              padding: EdgeInsets.symmetric(horizontal: margin),
//
//              child: Row(
//                children: [
//                  Expanded(
//                    child: Container(
//                      margin: EdgeInsets.only(bottom: (margin * 1.5)),
//                      height: height,
//                      padding: EdgeInsets.only(left: (margin / 2)),
//                      decoration: BoxDecoration(
//                          color: ConstantData.cellColor,
//                          borderRadius: BorderRadius.circular(
//                              ConstantWidget.getPercentSize(imageSize, 10)),
//                          boxShadow: [
//                            BoxShadow(
//                                color: ConstantData.shadowColor,)
//                          ]),
//                      child: Row(
//                        children: [
//                          Icon(
//                            Icons.search,
//                            color: ConstantData.textColor,
//                            size: ConstantWidget.getPercentSize(height, 40),
//                          ),
//                          SizedBox(
//                            width:
//                            ConstantWidget.getScreenPercentSize(context, 1),
//                          ),
//                          Expanded(
//                              child: TextField(
//                                maxLines: 1,
//                                style: TextStyle(
//                                    fontFamily: ConstantData.fontFamily,
//                                    color: ConstantData.mainTextColor,
//                                    fontWeight: FontWeight.w400,
//                                    fontSize: ConstantData.font18Px),
//                                decoration: InputDecoration(
//                                  hintText: S.of(context).typeHere,
//                                  hintStyle: TextStyle(
//                                      fontFamily: ConstantData.fontFamily,
//                                      color: ConstantData.mainTextColor,
//                                      fontWeight: FontWeight.w400,
//                                      fontSize: ConstantData.font18Px),
//                                  border: InputBorder.none,
//                                  contentPadding: EdgeInsets.zero,
//                                ),
//                              )),
//                          SizedBox(
//                            width:
//                            ConstantWidget.getScreenPercentSize(context, 1),
//                          ),
//                          InkWell(
//                            child: Container(
//                                height: imageSize,
//                                margin: EdgeInsets.symmetric(
//                                    vertical: ConstantWidget.getPercentSize(
//                                        imageSize, 12)),
//                                padding: EdgeInsets.all(
//                                    ConstantWidget.getPercentSize(imageSize, 10)),
//                                decoration: BoxDecoration(
//                                    color: ConstantData.bgColor,
//                                    borderRadius: BorderRadius.all(
//                                        Radius.circular(
//                                            ConstantWidget.getPercentSize(
//                                                imageSize, 10)))),
//                                child: Row(
//                                  children: [
//                                    ConstantWidget.getCustomText(
//                                        S.of(context).filter,
//                                        ConstantData.mainTextColor,
//                                        1,
//                                        TextAlign.start,
//                                        FontWeight.w800,
//                                        ConstantWidget.getScreenPercentSize(
//                                            context, 1.9)),
//                                    SizedBox(
//                                      width: ConstantWidget.getScreenPercentSize(
//                                          context, 1),
//                                    ),
//                                    Center(
//                                        child: Icon(
//                                          Icons.filter_list,
//                                          color: ConstantData.mainTextColor,
//                                          size: imageSize1,
//                                        )),
//                                  ],
//                                )),
//                            onTap: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => FilterPage(),
//                                  ));
//                            },
//                          ),
//                          SizedBox(
//                            width:
//                            ConstantWidget.getScreenPercentSize(context, 1),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),
//            ),
//            Expanded(
//              child: ListView.builder(
//                  shrinkWrap: true,
//                  itemCount: productList.length,
//                  itemBuilder: (context, index) {
//                    return getSearchCell(productList[index], index);
//                  }),
//              flex: 1,
//            )
//          ],
//        ),
//      ),
//    ), onWillPop: _requestPop);
//   }
//
//
//   Widget getSearchCell(SubCategoryModel model, int index) {
//     double imageSize = SizeConfig.safeBlockVertical * 12;
//     double radius = ConstantWidget.getPercentSize(imageSize, 15);
//     double margin = ConstantWidget.getScreenPercentSize(context, 2);
//     double arrowSize = ConstantWidget.getScreenPercentSize(context, 5);
//     double height = ConstantWidget.getScreenPercentSize(context, 6);
//
//     return InkWell(
//       child: Container(
//         // height: ConstantWidget.getScreenPercentSize(context, 20),
//
//
//         color: ConstantData.viewColor,
//         margin: EdgeInsets.symmetric(
//             horizontal: (margin / 1.6), vertical: (margin / 3.5)),
//         padding: EdgeInsets.symmetric(
//             horizontal: (margin/2), vertical: ((margin))),
//
//         // decoration: BoxDecoration(
//         //   color: Colors.transparent,
//         //   borderRadius: BorderRadius.circular(radius),
//         //   border: Border.all(
//         //       color: ConstantData.borderColor,
//         //       width: ConstantWidget.getWidthPercentSize(context, 0.08)),
//         // ),
//         // margin: EdgeInsets.only(
//         //   top: (index == 0) ? 0 : (radius),
//         // ),
//         child: Stack(
//           children: [
//             Stack(
//               children: [
//                 // Container(
//                 //   height: imageSize,
//                 //   width: imageSize,
//                 //   margin: EdgeInsets.all(margin),
//                 //   padding: EdgeInsets.all(margin),
//                 //   decoration: BoxDecoration(
//                 //     shape: BoxShape.rectangle,
//                 //     color: ConstantData.cellColor,
//                 //     borderRadius: BorderRadius.all(
//                 //       Radius.circular(radius),
//                 //     ),
//                 //     image: DecorationImage(
//                 //       image: ExactAssetImage(
//                 //           ConstantData.assetsPath + model.image),
//                 //       fit: BoxFit.cover,
//                 //     ),
//                 //   ),
//                 // ),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                   Expanded(child:   Column(
//
//
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                     ConstantWidget.getCustomText(
//                     model.name,
//                     ConstantData.mainTextColor,
//                     2,
//                     TextAlign.start,
//                     FontWeight.w800,
//                     ConstantWidget.getScreenPercentSize(context, 2.8)),
//
//                       Container(
//                         height: imageSize,
//                         width: imageSize,
//                         margin: EdgeInsets.symmetric(vertical: (margin/2)),
//
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: ConstantData.cellColor,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular((radius/2)),
//                           ),
//                           image: DecorationImage(
//                             image: ExactAssetImage(
//                                 ConstantData.assetsPath + model.image),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//
//                       ConstantWidget.getCustomText(
//                           productList[index].companyName,
//                           Colors.grey,
//                           1,
//                           TextAlign.start,
//                           FontWeight.w500,
//                           ConstantWidget.getScreenPercentSize(context, 2)),
//
//                     ],
//                   ),flex: 1,),
//
//                     Expanded(child:   Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             ConstantWidget.getLineTextView(
//                                 model.offPrice,
//                                 Colors.grey,
//                                 ConstantWidget.getScreenPercentSize(context, 2)),
//                             SizedBox(
//                               width:
//                               ConstantWidget.getWidthPercentSize(context, 1.2),
//                             ),
//
//                             ConstantWidget.getCustomText(
//                                 model.price,
//                                 ConstantData.mainTextColor,
//                                 1,
//                                 TextAlign.start,
//                                 FontWeight.w500,
//                                 ConstantWidget.getScreenPercentSize(context, 2.5)),
//                           ],
//                         ),
//                         SizedBox(height: ConstantWidget.getScreenPercentSize(context, 1.2),),
//                         ConstantWidget.getCustomText(
//                             model.offer,
//                             ConstantData.accentColor,
//                             1,
//                             TextAlign.start,
//                             FontWeight.w700,
//                             ConstantWidget.getScreenPercentSize(context,  2)),
//
//
//                       ],
//                     ),flex: 1,),
//
//                   ],
//                 ),
//
//
//                Positioned.fill(child: Align(alignment: Alignment.bottomRight,
//                child:  Row(
//                  children: [
//                    new Spacer(),
//
//                    InkWell(
//                      child:Container(
//                          height: height,
//                          margin: EdgeInsets.only(top: margin),
//
//                          decoration: BoxDecoration(
//
//                            color: ConstantData.accentColor,
//                            borderRadius: BorderRadius.circular(ConstantWidget.getPercentSize(height, 45)),
//                          ),
//
//                          padding: EdgeInsets.symmetric(horizontal: ConstantWidget.getPercentSize(height, 40)),
//
//                          child: Center(
//                            child: ConstantWidget.getTextWidget(S.of(context).addToCart, Colors.white,
//                                TextAlign.center, FontWeight.w500, ConstantWidget.getPercentSize(height, 30)),
//                          )
//
//                      ),
//                      onTap: (){
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddToCartPage(),));
//                      },
//                    )
//                  ],
//                ),))
//
//
//                 // Expanded(
//                 //   child: Column(
//                 //     mainAxisAlignment: MainAxisAlignment.start,
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       ConstantWidget.getCustomText(
//                 //           model.name,
//                 //           ConstantData.textColor,
//                 //           1,
//                 //           TextAlign.start,
//                 //           FontWeight.w800,
//                 //           ConstantData.font18Px),
//                 //       Padding(
//                 //         padding:
//                 //         EdgeInsets.only(top: (radius / 4), bottom: radius),
//                 //         child: ConstantWidget.getCustomText(
//                 //             model.desc,
//                 //             ConstantData.textColor,
//                 //             1,
//                 //             TextAlign.start,
//                 //             FontWeight.w500,
//                 //             ConstantWidget.getScreenPercentSize(context, 1.9)),
//                 //       ),
//                 //       Align(
//                 //         alignment: Alignment.bottomLeft,
//                 //         child: Row(
//                 //           children: [
//                 //             ConstantWidget.getCustomText(
//                 //                 model.price,
//                 //                 ConstantData.accentColor,
//                 //                 1,
//                 //                 TextAlign.start,
//                 //                 FontWeight.w700,
//                 //                 ConstantWidget.getScreenPercentSize(context, 2.3)),
//                 //
//                 //             SizedBox(
//                 //               width:
//                 //               ConstantWidget.getWidthPercentSize(context, 1.2),
//                 //             ),
//                 //             ConstantWidget.getLineTextView(
//                 //                 model.offPrice,
//                 //                 Colors.grey,
//                 //                 ConstantWidget.getScreenPercentSize(context, 1.5)),
//                 //
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 //   flex: 1,
//                 // )
//               ],
//             ),
//             // Positioned.fill(
//             //   child: Align(
//             //     alignment: Alignment.bottomRight,
//             //     child: Container(
//             //       height: arrowSize,
//             //       width: arrowSize,
//             //       decoration: BoxDecoration(
//             //         color: ConstantData.primaryColor,
//             //         borderRadius: BorderRadius.only(
//             //             topLeft: Radius.circular(radius),
//             //             bottomRight: Radius.circular(radius)),
//             //       ),
//             //       child: Transform.scale(
//             //         scale: -1,
//             //         child: Center(
//             //           child: Icon(Icons.arrow_back_sharp,
//             //               color: Colors.white,
//             //               size: ConstantWidget.getPercentSize(arrowSize, 50)),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ProductDetailPage(model)));
//       },
//     );
//   }
//
//
//
// }