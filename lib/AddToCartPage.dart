import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'CheckOutPage.dart';
import 'generated/l10n.dart';
import 'model/SubCategoryModel.dart';
import 'util/ConstantWidget.dart';
import 'util/ConstantData.dart';

class AddToCartPage extends StatefulWidget {
  // final bool isCheckout;

  AddToCartPage();

  @override
  _AddToCartPage createState() {
    return _AddToCartPage();
  }
}

class _AddToCartPage extends State<AddToCartPage> {
  List<SubCategoryModel> cartModelList = [];

  _AddToCartPage();

  @override
  void initState() {
    super.initState();

    cartModelList = DataFile.getCartModel();

    setState(() {});
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.04;
    double radius = ConstantWidget.getScreenPercentSize(context, 4);
    double defMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double padding = ConstantWidget.getScreenPercentSize(context, 1.5);
    double bottomHeight = ConstantWidget.getScreenPercentSize(context, 6);

    double subRadius = ConstantWidget.getPercentSize(bottomHeight, 10);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.bgColor,
          appBar: AppBar(
            backgroundColor: ConstantData.bgColor,
            elevation: 0,
            centerTitle: true,
            title: ConstantWidget.getAppBarText(S.of(context).cart),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: ConstantWidget.getAppBarIcon(),
                  onPressed: _requestPop,
                );
              },
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: leftMargin,
                        right: leftMargin,
                        bottom: MediaQuery.of(context).size.width * 0.01),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartModelList.length,
                        itemBuilder: (context, index) {
                          return ListItem(
                              index, cartModelList[index], removeItem);
                        }),
                  ),
                  flex: 1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: leftMargin),
                  decoration: BoxDecoration(
                    color: ConstantData.viewColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: leftMargin,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: defMargin),
                          height:
                              ConstantWidget.getScreenPercentSize(context, 0.5),
                          width:
                              ConstantWidget.getWidthPercentSize(context, 30),
                          color: Colors.grey,
                        ),
                      ),
                      getRoWCell(S.of(context).subTotal, "\$88.10"),
                      Padding(
                        padding: EdgeInsets.only(top: padding, bottom: padding),
                        child: getRoWCell(S.of(context).shippingFee, "\$9.90"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: padding),
                        child:
                            getRoWCell(S.of(context).estimatingTax, "\$6.50"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ConstantWidget.getCustomText(
                                S.of(context).total,
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.3)),
                            flex: 1,
                          ),
                          Expanded(
                            child: ConstantWidget.getCustomText(
                                "\$104.50",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.end,
                                FontWeight.w800,
                                ConstantWidget.getScreenPercentSize(
                                    context, 2.3)),
                            flex: 1,
                          )
                        ],
                      ),
                      InkWell(
                        child: Container(
                          height: bottomHeight,
                          margin: EdgeInsets.symmetric(
                              vertical: ConstantWidget.getPercentSize(
                                  bottomHeight, 25)),
                          decoration: BoxDecoration(
                            color: ConstantData.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(subRadius)),
                          ),
                          child: Center(
                            child: ConstantWidget.getTextWidget(
                                S.of(context).continueText,
                                Colors.white,
                                TextAlign.start,
                                FontWeight.bold,
                                ConstantWidget.getPercentSize(
                                    bottomHeight, 25)),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage(),
                              ));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getRoWCell(String s, String s1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ConstantWidget.getCustomText(s, ConstantData.textColor, 1,
              TextAlign.start, FontWeight.w800, ConstantData.font18Px),
          flex: 1,
        ),
        Expanded(
          child: ConstantWidget.getCustomText(s1, ConstantData.textColor, 1,
              TextAlign.end, FontWeight.w800, ConstantData.font18Px),
          flex: 1,
        )
      ],
    );
  }

  void removeItem(int index) {
    setState(() {
      cartModelList.removeAt(index);
    });
  }
}

class ListItem extends StatefulWidget {
  final SubCategoryModel subCategoryModel;

  final int index;
  final ValueChanged<int> onChanged;

  // ListItem(this.imageSize, this.subCategoryModel);
  ListItem(this.index, this.subCategoryModel, this.onChanged);

  @override
  RoomEditDeleteItemState createState() => RoomEditDeleteItemState(
      // this.imageSize, this.subCategoryModel);
      this.subCategoryModel,
      this.onChanged);
}

class RoomEditDeleteItemState extends State<ListItem> {
  double imageSize;
  final ValueChanged<int> onChanged;
  SubCategoryModel subCategoryModel;

  int themMode;

  setThemePosition() async {
    themMode = await PrefData.getThemeMode();
    setState(() {});
  }

  RoomEditDeleteItemState(
      // this.imageSize, this.subCategoryModel);
      this.subCategoryModel,
      this.onChanged);

  @override
  Widget build(BuildContext context) {
    double height = ConstantWidget.getScreenPercentSize(context, 15);
    double imageSize = ConstantWidget.getPercentSize(height, 80);
    double margin = ConstantWidget.getScreenPercentSize(context, 1.5);
    double radius = ConstantWidget.getScreenPercentSize(context, 1.5);

    setThemePosition();
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
              color: ConstantData.borderColor,
              width: ConstantWidget.getWidthPercentSize(context, 0.08)),
        ),
        margin: EdgeInsets.only(top: margin, bottom: margin),
        height: height,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: imageSize,
                width: imageSize,
                margin: EdgeInsets.all(margin),
                padding: EdgeInsets.all((margin / 5)),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: ConstantData.bgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  image: DecorationImage(
                    image: ExactAssetImage(
                        ConstantData.assetsPath + subCategoryModel.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: (margin * 1.2)),
                // child: Row(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ConstantWidget.getCustomText(
                              subCategoryModel.name,
                              ConstantData.mainTextColor,
                              1,
                              TextAlign.start,
                              FontWeight.w800,
                              ConstantWidget.getPercentSize(height, 15)),
                        ),
                        SizedBox(
                          width: ConstantWidget.getPercentSize(height, 5),
                        ),
                        ConstantWidget.getCustomText(
                            subCategoryModel.desc,
                            Colors.grey,
                            1,
                            TextAlign.start,
                            FontWeight.w500,
                            ConstantWidget.getPercentSize(height, 12)),
                        SizedBox(
                          height:
                              ConstantWidget.getWidthPercentSize(context, 1.2),
                        ),

                        ConstantWidget.getCustomText(
                            subCategoryModel.price,
                            ConstantData.accentColor,
                            1,
                            TextAlign.start,
                            FontWeight.w800,
                            ConstantWidget.getPercentSize(height, 15)),
                        SizedBox(
                          height:
                              ConstantWidget.getWidthPercentSize(context, 1.2),
                        ),

                        ConstantWidget.getLineTextView(
                            subCategoryModel.offPrice,
                            Colors.grey,
                            ConstantWidget.getPercentSize(
                                height, 10)),

                        //
                        // ConstantWidget.getCustomText(
                        //     subCategoryModel.offPrice,
                        //     Colors.grey,
                        //     1,
                        //     TextAlign.start,
                        //     FontWeight.w500,
                        //     ConstantWidget.getPercentSize(height, 10)),

                        // new Spacer(),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     ConstantWidget.getCustomText(
                        //         subCategoryModel.price,
                        //         ConstantData.accentColor,
                        //         1,
                        //         TextAlign.start,
                        //         FontWeight.w800,
                        //         ConstantWidget.getPercentSize(height, 15)),
                        //     SizedBox(
                        //       width: ConstantWidget.getWidthPercentSize(
                        //           context, 1.2),
                        //     ),
                        //     ConstantWidget.getCustomText(
                        //         subCategoryModel.offPrice,
                        //         Colors.grey,
                        //         1,
                        //         TextAlign.start,
                        //         FontWeight.w500,
                        //         ConstantWidget.getPercentSize(height, 10)),
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: ConstantWidget.getWidthPercentSize(context, 2),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getCartButton(CupertinoIcons.minus, () {
                            setState(() {
                              if (subCategoryModel.quantity > 1) {
                                subCategoryModel.quantity--;
                              }
                            });
                          }),
                          SizedBox(
                            width:
                                ConstantWidget.getWidthPercentSize(context, 3),
                          ),
                          ConstantWidget.getCustomText(
                              subCategoryModel.quantity.toString(),
                              ConstantData.mainTextColor,
                              2,
                              TextAlign.start,
                              FontWeight.w500,
                              ConstantWidget.getPercentSize(height, 14)),
                          SizedBox(
                            width:
                                ConstantWidget.getWidthPercentSize(context, 3),
                          ),
                          getCartButton(Icons.add, () {
                            setState(() {
                              subCategoryModel.quantity++;
                            });
                          }),
                          SizedBox(
                            width:
                                ConstantWidget.getWidthPercentSize(context, 3),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      secondaryActions: <Widget>[
        InkWell(
          child: Container(
            height: ConstantWidget.getScreenPercentSize(context, 6.5),
            width: ConstantWidget.getScreenPercentSize(context, 6.5),
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
              color: (themMode == 1)
                  ? ConstantData.cellColor
                  : ConstantData.cellColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          onTap: () {
            widget.onChanged(widget.index);
          },
        )
      ],
    );
  }

  getCartButton(var icon, Function function) {
    double mainHeight = ConstantWidget.getScreenPercentSize(context, 15);

    double height = ConstantWidget.getPercentSize(mainHeight, 23);

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
}
