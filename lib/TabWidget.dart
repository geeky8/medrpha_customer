import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_medical_ui/UploadPrescription.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/model/CategoryModel.dart';
import 'package:flutter_medical_ui/model/SliderModel.dart';
import 'package:flutter_medical_ui/model/ChatModel.dart';
import 'package:flutter_medical_ui/model/SubCategoryModel.dart';
import 'package:flutter_medical_ui/model/ProfileModel.dart';

import 'package:flutter_medical_ui/model/Message.dart';


import 'AddToCartPage.dart';
import 'CategoriesPage.dart';
import 'ChatScreen.dart';
import 'MyOrderPage.dart';
import 'ProductDetailPage.dart';
import 'SubCategoriesPage.dart';
import 'ArticleDetailPage.dart';
import 'WriteReviewPage.dart';
import 'AboutUsPage.dart';
import 'PrescriptionSteps.dart';
import 'ShippingAddressPage.dart';
import 'MyVouchers.dart';
import 'MySavedCardsPage.dart';
import 'NotificationList.dart';
import 'EditProfilePage.dart';
import 'SearchPage.dart';
import 'MyPrescription.dart';
import 'customWidget/MotionTabBarView.dart';
import 'customWidget/MotionTabController.dart';
import 'customWidget/motiontabbar.dart';
import 'main.dart';

import 'model/ArticleModel.dart';

import 'generated/l10n.dart';

class TabWidget extends StatefulWidget {
  @override
  _TabWidget createState() {
    return _TabWidget();
  }
}

class _TabWidget extends State<TabWidget> with SingleTickerProviderStateMixin {
  // int index = 0;
  // TabController tabController;
  GlobalKey<ScaffoldState> s = new GlobalKey<ScaffoldState>();
  List<CategoryModel> categoryModelList = DataFile.getCategoryModel();
  List<ArticleModel> articleList = DataFile.getArticleModel();
  List<ArticleModel> recentPost = DataFile.getArticleModel();
  List<SubCategoryModel> subCategoryModelList = DataFile.getSubCategoryModel();
  int colorIndex = -1;
  int sliderPosition = 0;
  List<ChatModel> chatUserList = DataFile.getChatUserList();
  ProfileModel profileModel = DataFile.getProfileModel();
  List<SliderModel> sliderList = DataFile.getSliderList();

  MotionTabBar motionTabBar;
  MotionTabController _tabController;
  int _selectedIndex = 0;



  List<String> lableList = ["Home", "Article", "My Order", "Message", "Profile"];
  Future<bool> _requestPop() {
    if (_selectedIndex > 0) {
      _tabController.index = 0;
      _selectedIndex = 0;
      setState(() {});
    } else {
      Future.delayed(const Duration(milliseconds: 200), () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
    return new Future.value(false);
  }

  int themMode;

  getThemeMode() async {
    themMode = await PrefData.getThemeMode();
    print("themeMode--2-$themMode}");
    ConstantData.setThemePosition();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     // = new TabController(length: 5, vsync: this);

    _tabController = new MotionTabController(
        initialIndex: _selectedIndex, length: lableList.length, vsync: this);
    getThemeMode();
  }

  @override
  void dispose() {
    super.dispose();
    // tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConstantData.setThemePosition();
    SizeConfig().init(context);


    motionTabBar = new MotionTabBar(
      labels: ["Home", "Article", "My Order", "Message", "Profile"],
      // labels: ["Home", "Category", "Chat", "Filter", "Setting"],
      initialSelectedTab: lableList[_selectedIndex],
      tabIconColor: ConstantData.mainTextColor,
      tabSelectedColor: ConstantData.primaryColor,
      selectedIndex: _selectedIndex,
      onTabItemSelected: (int value) {
        print(value);
        setState(() {
          _tabController.index = value;
          _selectedIndex = value;
        });
      },
      icons: [
        Icons.home,
        Icons.auto_awesome_mosaic,
        Icons.calendar_today_outlined,
        Icons.message_outlined,
        Icons.account_circle_sharp,
      ],
      textStyle: TextStyle(
          color: Colors.transparent,
          fontSize: ConstantWidget.getWidthPercentSize(context, 0),
          fontFamily: ConstantData.fontFamily),
    );


    return WillPopScope(
      child: Scaffold(
        backgroundColor: ConstantData.bgColor,
        key: s,
        drawer: Drawer(
          child: Container(
              color: ConstantData.bgColor,
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: [
                  UserAccountsDrawerHeader(
                    accountName: ConstantWidget.getTextWidget(
                        profileModel.name,
                        Colors.white,
                        TextAlign.start,
                        FontWeight.w300,
                        ConstantData.font22Px),
                    accountEmail: ConstantWidget.getTextWidget(
                        profileModel.email,
                        Colors.white70,
                        TextAlign.start,
                        FontWeight.w300,
                        ConstantData.font18Px),
                    currentAccountPicture: ClipOval(
                      child: Image.asset(
                        ConstantData.assetsPath + profileModel.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ConstantWidget.getDrawerItem(context,
                      S
                          .of(context)
                          .shopByMedicine, Icons.home_outlined, () {
                        Navigator.pop(context);
                      }),
                  ConstantWidget.getDrawerItem(context,
                      S
                          .of(context)
                          .uploadPrescription, Icons.assignment, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrescriptionSteps(),
                            ));
                      }),
                  ConstantWidget.getDrawerItem(
                      context,
                      S
                          .of(context)
                          .myPrescription,
                      Icons.text_snippet_outlined, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyPrescription(),
                        ));
                  }),
                ],
              )),
        ),
        // bottomNavigationBar: new Material(
        //   color: ConstantData.cellColor,
        //   child: new TabBar(
        //     indicatorColor: ConstantData.primaryColor,
        //     labelPadding: EdgeInsets.all(5),
        //     onTap: (value) {
        //       setState(() {
        //         index = value;
        //       });
        //     },
        //     controller: tabController,
        //     unselectedLabelColor: ConstantData.textColor,
        //     tabs: <Widget>[
        //       new Tab(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             Icon(
        //               Icons.home,
        //               color: getColor(0),
        //             ),
        //             ConstantWidget.getCustomText(
        //                 "Home",
        //                 getColor(0),
        //                 1,
        //                 TextAlign.center,
        //                 FontWeight.w400,
        //                 ConstantData.font15Px)
        //           ],
        //         ),
        //       ),
        //       new Tab(
        //
        //         // child: new Icon(Icons.article_outlined)
        //
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.table_chart_outlined,
        //                 color: getColor(1),
        //               ),
        //               ConstantWidget.getCustomText(
        //                   "Article",
        //                   getColor(1),
        //                   1,
        //                   TextAlign.center,
        //                   FontWeight.w400,
        //                   ConstantData.font15Px)
        //             ],
        //           )),
        //       // child: new Icon(Icons.article_outlined), text: "Workout"),
        //       new Tab(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.calendar_today_outlined,
        //                 color: getColor(2),
        //               ),
        //               ConstantWidget.getCustomText(
        //                   "My Order",
        //                   getColor(2),
        //                   1,
        //                   TextAlign.center,
        //                   FontWeight.w400,
        //                   ConstantData.font15Px)
        //             ],
        //           )),
        //       // new Tab(child: new Icon(Icons.info_outlined)),
        //       // new Tab(child: new Icon(Icons.info_outlined), text: "Tracking"),
        //       new Tab(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.message_outlined,
        //                 color: getColor(3),
        //               ),
        //               ConstantWidget.getCustomText(
        //                   "Message",
        //                   getColor(3),
        //                   1,
        //                   TextAlign.center,
        //                   FontWeight.w400,
        //                   ConstantData.font15Px)
        //             ],
        //           )),
        //
        //       new Tab(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.account_circle_sharp,
        //                 color: getColor(4),
        //               ),
        //               ConstantWidget.getCustomText(
        //                   "Profile",
        //                   getColor(4),
        //                   1,
        //                   TextAlign.center,
        //                   FontWeight.w400,
        //                   ConstantData.font15Px)
        //             ],
        //           )),
        //       // new Tab(child: new Icon(Icons.settings)),
        //       // new Tab(child: new Icon(Icons.settings), text: "Setting"),
        //     ],
        //   ),
        // ),
        bottomNavigationBar: motionTabBar,
        body: SafeArea(
          child: MotionTabBarView(
              controller: _tabController,
              children: <Widget>[


              getHomePage(),
          getArticlePage(), MyOrderPage(true), getChatPage(), getProfilePage()

          // Container(
          //   child: getHomePage(),
          // ),
          // // Container(
          // //   child: getCartPage(),
          // // ),
          // Container(
          //   child: getChatPage(),
          // ),
          // Container(
          //   child: getSearchPage(),
          // ),
          // Container(
          //   child: getProfilePage(),
          // ),
          ],
        ),

        // child: Container(
        //   child: getWidget(index),
        // ),
      ),
    ),onWillPop
    :
    _requestPop
    );
  }

  getArticlePage() {
    return Container(
      color: ConstantData.bgColor,
      child: ListView(children: [
        getViewAllCell(S
            .of(context)
            .topArticle, false, () {}),
        topArticleList(),
        getViewAllCell(S
            .of(context)
            .recentPost, false, () {}),
        recentPostList(),
        SizedBox(
          height: ConstantWidget.getScreenPercentSize(context, 2),
        )
      ]),
    );
  }

  getProfilePage() {
    ProfileModel profileModel = DataFile.getProfileModel();

    double leftMargin = MediaQuery
        .of(context)
        .size
        .width * 0.04;
    double imageSize = SizeConfig.safeBlockVertical * 15;
    double deftMargin = ConstantWidget.getScreenPercentSize(context, 2);

    return Container(
      color: ConstantData.bgColor,
      margin: EdgeInsets.only(
          left: leftMargin,
          right: leftMargin,
          bottom: MediaQuery
              .of(context)
              .size
              .width * 0.01),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: (deftMargin * 1.5)),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: (deftMargin * 2),
                  ),
                  Row(
                    children: [
                      Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: ExactAssetImage(
                                ConstantData.assetsPath + profileModel.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: deftMargin),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstantWidget.getCustomTextWithoutAlign(
                                  profileModel.name,
                                  ConstantData.mainTextColor,
                                  FontWeight.bold,
                                  ConstantData.font22Px),
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: ConstantWidget.getCustomTextWithoutAlign(
                                    profileModel.email,
                                    ConstantData.mainTextColor,
                                    FontWeight.w500,
                                    ConstantData.font15Px),
                              )
                            ],
                          ),
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .editProfiles, Icons.edit),
            onTap: () {
              sendAction(EditProfilePage());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .myOrder, Icons.shopping_bag),
            onTap: () {
              sendAction(MyOrderPage(false));
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .cart, Icons.shopping_cart),
            onTap: () {
              sendAction(AddToCartPage());
            },
          ),
          InkWell(
            child:
            _getCell(S
                .of(context)
                .address, Icons.local_shipping_outlined),
            onTap: () {
              sendAction(ShippingAddressPage());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .mySavedCards, Icons.credit_card),
            onTap: () {
              sendAction(MySavedCardsPage());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .giftCard, Icons.card_giftcard),
            onTap: () {
              sendAction(MyVouchers(false));
            },
          ),
          InkWell(
            child: _getModeCell(
                S
                    .of(context)
                    .darkMode,
                (themMode == 0)
                    ? Icons.toggle_off_outlined
                    : Icons.toggle_on_outlined),
            onTap: () {
              print("themeMode--1-$themMode}");
              if (themMode == 1) {
                PrefData.setThemeMode(0);
              } else {
                PrefData.setThemeMode(1);
              }
              getThemeMode();
            },
          ),
          InkWell(
            child:
            _getCell(S
                .of(context)
                .notification, Icons.notifications_none),
            onTap: () {
              sendAction(NotificationList());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .review, Icons.rate_review),
            onTap: () {
              sendAction(WriteReviewPage());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .aboutUs, Icons.info),
            onTap: () {
              sendAction(AboutUsPage());
            },
          ),
          InkWell(
            child: _getCell(S
                .of(context)
                .logout, Icons.logout),
            onTap: () {
              PrefData.setIsSignIn(false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ],
      ),
    );
  }

  void sendAction(StatefulWidget className) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => className));
  }

  Widget _getModeCell(String s, var icon) {
    double deftMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double size = ConstantWidget.getScreenPercentSize(context, 6);
    double iconSize = ConstantWidget.getPercentSize(size, 50);

    return Container(
      margin: EdgeInsets.only(
          bottom: ConstantWidget.getScreenPercentSize(context, 0.2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: ConstantWidget.getScreenPercentSize(context, 1)),
                height: size,
                width: size,
                decoration: new BoxDecoration(
                    color: ConstantData.cellColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ConstantWidget.getPercentSize(size, 15)))),
                child: Icon(
                  Icons.brightness_6_outlined,
                  size: iconSize,
                  color: ConstantData.mainTextColor,
                ),
              ),
              Text(
                s,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConstantData.font18Px,
                  fontFamily: ConstantData.fontFamily,
                  color: ConstantData.textColor,
                ),
              ),
              new Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    icon,
                    color: (themMode == 1)
                        ? ConstantData.accentColor
                        : ConstantData.textColor,
                    size: ConstantWidget.getScreenPercentSize(context, 5),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: deftMargin, bottom: deftMargin),
            height: ConstantWidget.getScreenPercentSize(context, 0.02),
            color: ConstantData.mainTextColor,
          ),
        ],
      ),
    );
  }

  Widget _getCell(String s, var icon) {
    double deftMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double size = ConstantWidget.getScreenPercentSize(context, 6);
    double iconSize = ConstantWidget.getPercentSize(size, 50);

    return Container(
      margin: EdgeInsets.only(
          bottom: ConstantWidget.getScreenPercentSize(context, 0.2)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: ConstantWidget.getScreenPercentSize(context, 1)),
                height: size,
                width: size,
                decoration: new BoxDecoration(
                    color: ConstantData.cellColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        ConstantWidget.getPercentSize(size, 15)))),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: ConstantData.mainTextColor,
                ),
              ),
              Text(
                s,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConstantData.font18Px,
                  fontFamily: ConstantData.fontFamily,
                  color: ConstantData.textColor,
                ),
              ),
              new Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.navigate_next,
                    color: ConstantData.textColor,
                    size: ConstantWidget.getScreenPercentSize(context, 3),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: deftMargin, bottom: deftMargin),
            height: ConstantWidget.getScreenPercentSize(context, 0.02),
            color: ConstantData.mainTextColor,
          ),
        ],
      ),
    );
  }

  getHomePage() {
    print("homee----true");
    double height = ConstantWidget.getScreenPercentSize(context, 14);
    double searchHeight = ConstantWidget.getPercentSize(height, 40);
    double sliderHeight = ConstantWidget.getScreenPercentSize(context, 25);
    double font = ConstantWidget.getScreenPercentSize(context, 2.3);

    double radius = ConstantWidget.getPercentSize(height, 10);
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double sideMargin = margin * 1.2;

    return Container(
      color: ConstantData.bgColor,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: (margin * 1.5)),
            margin: EdgeInsets.symmetric(horizontal: sideMargin),
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.menu,
                    color: ConstantData.mainTextColor,
                  ),
                  onTap: () {
                    s.currentState.openDrawer();
                  },
                ),
                new Spacer(),
                InkWell(
                  child: Icon(
                    Icons.shopping_cart,
                    color: ConstantData.mainTextColor,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToCartPage(),
                        ));
                  },
                ),
              ],
            ),
          ),
          Container(
            // height: height,
            margin: EdgeInsets.symmetric(horizontal: margin),
            padding: EdgeInsets.all((margin * 1.2)),

            decoration: BoxDecoration(
              color: ConstantData.cellColor,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ConstantWidget.getCustomText(
                        "Hey,",
                        ConstantData.mainTextColor,
                        1,
                        TextAlign.start,
                        FontWeight.w600,
                        font),
                    SizedBox(
                      width: 0.5,
                    ),
                    ConstantWidget.getCustomText("Sophia", Colors.orange, 1,
                        TextAlign.start, FontWeight.w600, font),
                  ],
                ),
                SizedBox(
                  height: (margin / 2.5),
                ),
                ConstantWidget.getCustomText(
                    "Can I help you something?",
                    ConstantData.textColor,
                    1,
                    TextAlign.start,
                    FontWeight.w200,
                    (font / 1.5)),
                SizedBox(
                  height: ((margin/1.2)),
                ),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: searchHeight,
                    child: TextField(
                      style: TextStyle(
                        fontFamily: ConstantData.fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (string) {},
                      maxLines: 1,
                      enabled: false,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: S
                            .of(context)
                            .searchForServiceAndPackage,
                        // prefixIcon: Icon(Icons.search),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: ConstantData.fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: getOutLineBorder(radius),
                        enabledBorder: getOutLineBorder(radius),
                        focusedBorder: getOutLineBorder(radius),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ));
                  },
                )
              ],
            ),
          ),
          Center(
              child: Padding(
                padding: EdgeInsets.only(top: (margin/2)),
                child: ConstantWidget.getCustomText(
                    "Or", Colors.grey, 1, TextAlign.center, FontWeight.w600,
                    font),
              )),
          InkWell(
            child: Container(
              // height: height,
              margin:
              EdgeInsets.symmetric(horizontal: margin, vertical: (margin/2)),
              padding: EdgeInsets.all((margin / 1.2)),

              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),

              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    // child: Transform.rotate(angle:(margin),child:  Image.asset(ConstantData.assetsPath+"health-check.png",
                    //   height: ConstantWidget.getScreenPercentSize
                    //   (context, 7),),),

                    child: Image.asset(
                      ConstantData.assetsPath + "health-check.png",
                      height: ConstantWidget.getScreenPercentSize(context, 6  ),
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_sharp,
                              size: ConstantWidget.getScreenPercentSize(
                                  context, 5),
                              color: ConstantData.mainTextColor,
                            ),
                            SizedBox(
                              width: margin,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ConstantWidget.getCustomText(
                                    S
                                        .of(context)
                                        .uploadPrescription,
                                    ConstantData.mainTextColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w600,
                                    font),
                                // SizedBox(
                                //   height: (margin / 2),
                                // ),
                                ConstantWidget.getCustomText(
                                    "We'll do the rest",
                                    ConstantData.textColor,
                                    1,
                                    TextAlign.start,
                                    FontWeight.w200,
                                    (font / 1.2)),
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPrescription(),
                  ));
            },
          ),
          getViewAllCell(S
              .of(context)
              .categories, true, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesPage(),
                ));
          }),
          Container(
              height: SizeConfig.safeBlockHorizontal * 20,
              // margin: EdgeInsets.only(bottom: margin),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: categoryModelList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    double height = SizeConfig.safeBlockHorizontal * 20;
                    double imageSize =
                    ConstantWidget.getPercentSize(height, 65);
                    double remainSize = height - imageSize;
                    if (colorIndex == (ConstantData
                        .colorList()
                        .length - 1)) {
                      colorIndex = 0;
                    } else {
                      colorIndex++;
                    }
                    return InkWell(
                      child: Container(
                        width: height,
                        child: Container(
                          margin: EdgeInsets.only(left: sideMargin),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                    ConstantWidget.getPercentSize(
                                        imageSize, 25)),
                                height: imageSize,
                                width: imageSize,
                                decoration: BoxDecoration(
                                  color: ConstantData.colorList()[colorIndex],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    ConstantData.assetsPath +
                                        categoryModelList[index].icon,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: ConstantWidget.getPercentSize(
                                        remainSize, 20),
                                  ),
                                  child: ConstantWidget.getCustomText(
                                      categoryModelList[index].name,
                                      ConstantData.mainTextColor,
                                      1,
                                      TextAlign.start,
                                      FontWeight.w400,
                                      ConstantWidget.getPercentSize(
                                          remainSize, 43)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubCategoriesPage()));
                      },
                    );
                  })),
          getViewAllCell(S
              .of(context)
              .products, true, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubCategoriesPage(),
                ));
          }),
          trendingList(),
          Container(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: double.infinity,
                height: sliderHeight,
                child: CarouselSlider.builder(
                  itemCount: sliderList.length,
                  options: CarouselOptions(
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          sliderPosition = index;
                        });
                      }),
                  itemBuilder: (context, index, realIndex) {
                    if (index == 0) {
                      return getSliderCell(sliderList[index], sliderHeight);
                    } else if (index == 1) {
                      return getSlider1Cell(sliderList[index], sliderHeight);
                    } else {
                      return getSlider2Cell(sliderList[index], sliderHeight);
                    }
                  },
                ),
              ),
            ]),
          ),
          SizedBox(
            height: ConstantWidget.getScreenPercentSize(context, 2),
          )
        ],
      ),
    );
  }

  getSliderCell(SliderModel sliderModel, double height) {
    double width = ConstantWidget.getWidthPercentSize(context, 75);

    double radius = ConstantWidget.getPercentSize(height, 4);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: "#2B9DB8".toColor(),
        // color: ConstantData.cellColor,
        // image: DecorationImage(
        //     image: AssetImage(ConstantData.assetsPath + sliderModel.image),
        //     fit: BoxFit.cover)
      ),
      margin:
      EdgeInsets.only(top: ConstantWidget.getScreenPercentSize(context, 2)),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
              margin: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
              child: Image.asset(ConstantData.assetsPath + sliderModel.image),
            ),
          ),

          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     margin: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.all(Radius.circular(radius)),
          //     ),
          //     child: ConstantWidget.getCustomText(
          //         sliderList[index].offerText,
          //         Colors.white,
          //         // ConstantData.accentColor,
          //         1,
          //         TextAlign.start,
          //         FontWeight.w400,
          //         ConstantWidget.getPercentSize(height, 8)),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstantWidget.getCustomText(
                      "SAVE UP TO",
                      Colors.white,
                      1,
                      TextAlign.start,
                      FontWeight.w500,
                      ConstantWidget.getPercentSize(height, 8)),
                  ConstantWidget.getCustomText(
                      sliderModel.offerText,
                      Colors.white,
                      1,
                      TextAlign.start,
                      FontWeight.bold,
                      ConstantWidget.getPercentSize(height, 15)),
                  ConstantWidget.getCustomText(
                    "Order valid on all Medicine",
                    Colors.white,
                    1,
                    TextAlign.start,
                    FontWeight.w500,
                    ConstantWidget.getPercentSize(height, 6),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        ConstantWidget.getPercentSize(height, 5)),
                    margin: EdgeInsets.only(top:
                    ConstantWidget.getPercentSize(height, 6)),
                    decoration: BoxDecoration(
                      color: ConstantData.accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                    ),
                    child: ConstantWidget.getCustomText(
                        "Order Now",
                        Colors.white,
                        // ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.w400,
                        ConstantWidget.getPercentSize(height, 8)),
                  ),
                ],
              ),
            ),
          )
          // Container(
          //   width: double.infinity,
          //   margin: EdgeInsets.only(top: secondHeight),
          //   padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 3)),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(radius),
          //         bottomRight: Radius.circular(radius)),
          //     color: Colors.black.withOpacity(0.7),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // SizedBox(
          //       //   height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       // ),
          //       ConstantWidget.getCustomText(
          //           sliderModel.title,
          //           Colors.white,
          //           1,
          //           TextAlign.start,
          //           FontWeight.bold,
          //           ConstantWidget.getPercentSize(secondHeight, 18)),
          //       SizedBox(
          //         height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       ),
          //       ConstantWidget.textOverFlowWidget(
          //           sliderModel.desc,
          //           FontWeight.w300,
          //           2,
          //           ConstantWidget.getPercentSize(secondHeight, 12),
          //           Colors.white),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  getSlider1Cell(SliderModel sliderModel, double height) {
    double width = ConstantWidget.getWidthPercentSize(context, 75);

    double radius = ConstantWidget.getPercentSize(height, 4);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          // color: "#517FA0".toColor(),
          // color: ConstantData.cellColor,
          image: DecorationImage(
              image: AssetImage(ConstantData.assetsPath +
                  "antivirus-accessories-antiseptic-mask-gloves-tablets-blue-background-kraft-paper-package-flatly-pandemic_215990-538.jpg"),
              fit: BoxFit.cover)
      ),
      margin:
      EdgeInsets.only(top: ConstantWidget.getScreenPercentSize(context, 2)),
      child: Stack(
        children: [


          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(left:ConstantWidget.getPercentSize(height, 5)),
          //     child: Image.asset(ConstantData.assetsPath + "bg_sli_2.png",height: (height/1.3),width: (height/1.3),),
          //   ),
          // ),


          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     margin: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.all(Radius.circular(radius)),
          //     ),
          //     child: ConstantWidget.getCustomText(
          //         sliderList[index].offerText,
          //         Colors.white,
          //         // ConstantData.accentColor,
          //         1,
          //         TextAlign.start,
          //         FontWeight.w400,
          //         ConstantWidget.getPercentSize(height, 8)),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  ConstantWidget.getUnderlineText(
                      "Medicines",
                      Colors.white,
                      1,
                      TextAlign.end,
                      FontWeight.w500,
                      ConstantWidget.getPercentSize(height, 8)),

                  ConstantWidget.getCustomText(
                      "Up To " + sliderModel.offerText,
                      Colors.white,
                      1,
                      TextAlign.end,
                      FontWeight.bold,
                      ConstantWidget.getPercentSize(height, 13)),


                  ConstantWidget.getCustomText(
                    "Health & Wellness Products",
                    Colors.white,
                    1,
                    TextAlign.end,
                    FontWeight.w500,
                    ConstantWidget.getPercentSize(height, 6),
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        ConstantWidget.getPercentSize(height, 5)),
                    margin: EdgeInsets.only(top:
                    ConstantWidget.getPercentSize(height, 6)),
                    decoration: BoxDecoration(
                      color: ConstantData.accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                    ),
                    child: ConstantWidget.getCustomText(
                        "Order Now",
                        Colors.white,
                        // ConstantData.accentColor,
                        1,
                        TextAlign.start,
                        FontWeight.w400,
                        ConstantWidget.getPercentSize(height, 8)),
                  ),
                ],
              ),
            ),
          )
          // Container(
          //   width: double.infinity,
          //   margin: EdgeInsets.only(top: secondHeight),
          //   padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 3)),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(radius),
          //         bottomRight: Radius.circular(radius)),
          //     color: Colors.black.withOpacity(0.7),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // SizedBox(
          //       //   height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       // ),
          //       ConstantWidget.getCustomText(
          //           sliderModel.title,
          //           Colors.white,
          //           1,
          //           TextAlign.start,
          //           FontWeight.bold,
          //           ConstantWidget.getPercentSize(secondHeight, 18)),
          //       SizedBox(
          //         height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       ),
          //       ConstantWidget.textOverFlowWidget(
          //           sliderModel.desc,
          //           FontWeight.w300,
          //           2,
          //           ConstantWidget.getPercentSize(secondHeight, 12),
          //           Colors.white),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  getSlider2Cell(SliderModel sliderModel, double height) {
    double width = ConstantWidget.getWidthPercentSize(context, 75);

    double radius = ConstantWidget.getPercentSize(height, 4);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          // color: "#517FA0".toColor(),
          color: ConstantData.cellColor,
          image: DecorationImage(
              image: AssetImage(ConstantData.assetsPath + "bg_slider.jpg"),
              fit: BoxFit.cover)
      ),
      margin:
      EdgeInsets.only(top: ConstantWidget.getScreenPercentSize(context, 2)),
      child: Stack(
        children: [


          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: EdgeInsets.only(left:ConstantWidget.getPercentSize(height, 5)),
          //     child: Image.asset(ConstantData.assetsPath + sliderModel.image,height: (height/1.3),width: (height/1.3),),
          //   ),
          // ),


          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     margin: EdgeInsets.all(ConstantWidget.getPercentSize(height, 5)),
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.all(Radius.circular(radius)),
          //     ),
          //     child: ConstantWidget.getCustomText(
          //         sliderList[index].offerText,
          //         Colors.white,
          //         // ConstantData.accentColor,
          //         1,
          //         TextAlign.start,
          //         FontWeight.w400,
          //         ConstantWidget.getPercentSize(height, 8)),
          //   ),
          // ),

          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    ConstantWidget.getUnderlineText(
                        "Medicines",
                        Colors.black,
                        1,
                        TextAlign.end,
                        FontWeight.w500,
                        ConstantWidget.getPercentSize(height, 8)),

                    ConstantWidget.getCustomText(
                        "Up To " + sliderModel.offerText,
                        Colors.black,
                        1,
                        TextAlign.end,
                        FontWeight.bold,
                        ConstantWidget.getPercentSize(height, 13)),


                    ConstantWidget.getCustomText(
                      "Health & Wellness Products",
                      Colors.black,
                      1,
                      TextAlign.end,
                      FontWeight.w500,
                      ConstantWidget.getPercentSize(height, 6),
                    ),
                    Container(
                      padding: EdgeInsets.all(
                          ConstantWidget.getPercentSize(height, 5)),
                      margin: EdgeInsets.only(top:
                      ConstantWidget.getPercentSize(height, 6)),
                      decoration: BoxDecoration(
                        color: ConstantData.accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                      ),
                      child: ConstantWidget.getCustomText(
                          "Order Now",
                          Colors.white,
                          // ConstantData.accentColor,
                          1,
                          TextAlign.start,
                          FontWeight.w400,
                          ConstantWidget.getPercentSize(height, 8)),
                    ),
                  ],
                ),
              ),
            ),
          )
          // Container(
          //   width: double.infinity,
          //   margin: EdgeInsets.only(top: secondHeight),
          //   padding: EdgeInsets.all(ConstantWidget.getPercentSize(height, 3)),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(radius),
          //         bottomRight: Radius.circular(radius)),
          //     color: Colors.black.withOpacity(0.7),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // SizedBox(
          //       //   height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       // ),
          //       ConstantWidget.getCustomText(
          //           sliderModel.title,
          //           Colors.white,
          //           1,
          //           TextAlign.start,
          //           FontWeight.bold,
          //           ConstantWidget.getPercentSize(secondHeight, 18)),
          //       SizedBox(
          //         height: ConstantWidget.getPercentSize(secondHeight, 5),
          //       ),
          //       ConstantWidget.textOverFlowWidget(
          //           sliderModel.desc,
          //           FontWeight.w300,
          //           2,
          //           ConstantWidget.getPercentSize(secondHeight, 12),
          //           Colors.white),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  recentPostList() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double imageHeight = SizeConfig.safeBlockHorizontal * 24;
    double sideMargin = margin * 1.2;

    double radius = ConstantWidget.getPercentSize(imageHeight, 8);

    recentPost = recentPost.reversed.toList();
    double doctorHeight = ConstantWidget.getPercentSize(imageHeight, 30);

    return Container(
        margin: EdgeInsets.only(bottom: margin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentPost.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Container(
                height: (imageHeight * 1.3),
                child: InkWell(
                  child: Container(
                    height: imageHeight,
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: sideMargin, vertical: (sideMargin / 2)),
                      decoration: BoxDecoration(
                          color: ConstantData.bgColor,
                          borderRadius: BorderRadius.circular(radius),
                          border: Border.all(
                              color: ConstantData.borderColor,
                              width: ConstantWidget.getWidthPercentSize(
                                  context, 0.08)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                            )
                          ]),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: (imageHeight * 1.2),
                              width: imageHeight,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(radius),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          ConstantData.assetsPath +
                                              recentPost[index].image),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all((sideMargin / 1.8)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      ConstantWidget.getCustomText(
                                          recentPost[index].type,
                                          Colors.grey,
                                          1,
                                          TextAlign.start,
                                          FontWeight.w600,
                                          ConstantWidget.getPercentSize(
                                              imageHeight, 11)),
                                      SizedBox(
                                        height: ConstantWidget.getPercentSize(
                                            imageHeight, 3),
                                      ),
                                      Expanded(
                                        child: ConstantWidget.getCustomText(
                                            recentPost[index].question,
                                            ConstantData.mainTextColor,
                                            2,
                                            TextAlign.start,
                                            FontWeight.bold,
                                            ConstantWidget.getPercentSize(
                                                imageHeight, 15)),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: doctorHeight,
                                            width: doctorHeight,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        ConstantData
                                                            .assetsPath +
                                                            recentPost[index]
                                                                .doctorImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: ConstantWidget
                                                .getPercentSize(
                                                imageHeight, 5),
                                          ),
                                          Expanded(
                                            child: ConstantWidget.getCustomText(
                                                recentPost[index].doctorName,
                                                Colors.grey,
                                                1,
                                                TextAlign.start,
                                                FontWeight.w600,
                                                ConstantWidget.getPercentSize(
                                                    imageHeight, 13)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArticleDetailPage(recentPost[index])));
                  },
                ),
              );
            }));
  }

  topArticleList() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = SizeConfig.safeBlockHorizontal * 40;

    double width = ConstantWidget.getWidthPercentSize(context, 60);
    double sideMargin = margin * 1.2;
    double firstHeight = ConstantWidget.getPercentSize(height, 60);
    double remainHeight = height - firstHeight;

    double radius = ConstantWidget.getPercentSize(height, 5);

    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: margin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: articleList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: width,
                  child: Container(
                    margin: EdgeInsets.only(left: sideMargin),
                    decoration: BoxDecoration(
                        color: ConstantData.bgColor,
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                            color: ConstantData.borderColor,
                            width: ConstantWidget.getWidthPercentSize(
                                context, 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                          )
                        ]),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: firstHeight,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(radius),
                                  topLeft: Radius.circular(radius),
                                ),
                                image: DecorationImage(
                                    image: AssetImage(ConstantData.assetsPath +
                                        articleList[index].image),
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: (sideMargin / 2),
                                    vertical: (sideMargin / 4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantWidget.getCustomText(
                                        articleList[index].type,
                                        Colors.grey,
                                        1,
                                        TextAlign.start,
                                        FontWeight.w600,
                                        ConstantWidget.getPercentSize(
                                            remainHeight, 15)),
                                    SizedBox(
                                      height: ConstantWidget.getPercentSize(
                                          remainHeight, 2),
                                    ),
                                    Expanded(
                                      child: ConstantWidget.getCustomText(
                                          articleList[index].question,
                                          ConstantData.mainTextColor,
                                          2,
                                          TextAlign.start,
                                          FontWeight.w600,
                                          ConstantWidget.getPercentSize(
                                              remainHeight, 20)),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ArticleDetailPage(articleList[index])));
                },
              );
            }));
  }

  trendingList() {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);
    double height = SizeConfig.safeBlockHorizontal * 45;

    double width = ConstantWidget.getWidthPercentSize(context, 60);
    double sideMargin = margin * 1.2;
    double firstHeight = ConstantWidget.getPercentSize(height, 60);
    double remainHeight = height - firstHeight;

    double radius = ConstantWidget.getPercentSize(height, 5);

    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: margin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: subCategoryModelList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  width: width,
                  child: Container(
                    margin: EdgeInsets.only(left: sideMargin),
                    decoration: BoxDecoration(
                        color: ConstantData.bgColor,
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                            color: ConstantData.borderColor,
                            width: ConstantWidget.getWidthPercentSize(
                                context, 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                          )
                        ]),
                    child: Stack(
                      children: [
                        // Align(alignment: Alignment.topRight,
                        // child:
                        // Container(
                        //   padding: EdgeInsets.all(sideMargin/4),
                        //
                        //   decoration: BoxDecoration(
                        //     color: ConstantData.accentColor,
                        //     borderRadius: BorderRadius.only(topRight: Radius.circular(radius)),
                        //
                        //
                        //
                        //   ),
                        //   child: ConstantWidget.getCustomText(
                        //       (subCategoryModelList[index].offer !=
                        //           null)
                        //           ? subCategoryModelList[index].offer
                        //           : "",
                        //       Colors.white,
                        //       // ConstantData.accentColor,
                        //       1,
                        //       TextAlign.start,
                        //       FontWeight.w400,
                        //       ConstantWidget.getPercentSize(
                        //           firstHeight, 12)),
                        //
                        // ),),
                        //

                        Visibility(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.all(sideMargin / 4),
                              decoration: BoxDecoration(
                                color: ConstantData.accentColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(radius)),
                              ),
                              child: ConstantWidget.getCustomText(
                                  (subCategoryModelList[index].offer != null)
                                      ? subCategoryModelList[index].offer
                                      : "",
                                  Colors.white,
                                  // ConstantData.accentColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w400,
                                  ConstantWidget.getPercentSize(
                                      firstHeight, 12)),
                            ),
                          ),
                          visible:
                          (subCategoryModelList[index].offer.isNotEmpty),
                        ),
                        // ),),visible:   (subCategoryModelList[index].offer != null || subCategoryModelList[index].offer.isNotEmpty),),

                        Container(
                          padding: EdgeInsets.all((sideMargin / 2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: firstHeight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: firstHeight,
                                      width: firstHeight,
                                      decoration: BoxDecoration(
                                          color: ConstantData.cellColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(radius),
                                          ),
                                          // ,
                                          image: DecorationImage(
                                              image: AssetImage(ConstantData
                                                  .assetsPath +
                                                  subCategoryModelList[index]
                                                      .image),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: [
                                                    ConstantWidget
                                                        .getLineTextView(
                                                        (subCategoryModelList[index]
                                                            .offPrice !=
                                                            null)
                                                            ? subCategoryModelList[
                                                        index]
                                                            .offPrice
                                                            : "",
                                                        Colors.grey,
                                                        ConstantWidget
                                                            .getPercentSize(
                                                            firstHeight, 12)),

                                                    // ConstantWidget.getCustomText(
                                                    //     (subCategoryModelList[index]
                                                    //                 .offPrice !=
                                                    //             null)
                                                    //         ? subCategoryModelList[
                                                    //                 index]
                                                    //             .offPrice
                                                    //         : "",
                                                    //     Colors.grey,
                                                    //     1,
                                                    //     TextAlign.start,
                                                    //     FontWeight.w600,
                                                    //     ConstantWidget.getPercentSize(
                                                    //         firstHeight, 12)),
                                                    SizedBox(
                                                      height:
                                                      ConstantWidget
                                                          .getPercentSize(
                                                          firstHeight, 8),
                                                    ),
                                                    ConstantWidget
                                                        .getCustomText(
                                                        subCategoryModelList[index]
                                                            .price,
                                                        ConstantData
                                                            .mainTextColor,
                                                        1,
                                                        TextAlign.start,
                                                        FontWeight.w600,
                                                        ConstantWidget
                                                            .getPercentSize(
                                                            firstHeight, 18)),
                                                    SizedBox(
                                                      height:
                                                      ConstantWidget
                                                          .getPercentSize(
                                                          firstHeight, 8),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(
                                          height: ConstantWidget.getPercentSize(
                                              remainHeight, 8),
                                        ),
                                        ConstantWidget.getCustomText(
                                            subCategoryModelList[index].name,
                                            ConstantData.mainTextColor,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantWidget.getPercentSize(
                                                remainHeight, 22)),
                                        SizedBox(
                                          height: ConstantWidget.getPercentSize(
                                              remainHeight, 8),
                                        ),
                                        ConstantWidget.getCustomText(
                                            subCategoryModelList[index].desc,
                                            Colors.grey,
                                            1,
                                            TextAlign.start,
                                            FontWeight.w600,
                                            ConstantWidget.getPercentSize(
                                                remainHeight, 14)),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(subCategoryModelList[index])));
                },
              );
            }));
  }

  getViewAllCell(String s, bool isViewAll, Function function) {
    double margin = ConstantWidget.getScreenPercentSize(context, 2);

    double sideMargin = margin * 1.2;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: sideMargin,vertical: sideMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstantWidget.getCustomTextWithoutAlign(
              s,
              ConstantData.mainTextColor,
              FontWeight.w700,
              ConstantWidget.getScreenPercentSize(context, 2.5)),
          new Spacer(),
          Visibility(
            child: InkWell(
              child: ConstantWidget.getCustomTextWithoutAlign(
                  S
                      .of(context)
                      .viewAll,
                  ConstantData.accentColor,
                  FontWeight.bold,
                  ConstantWidget.getScreenPercentSize(context, 2)),
              onTap: function,
            ),
            visible: isViewAll,
          )
        ],
      ),
    );
  }

  getWidget(int position) {
    print("posiyion---true");
    if (position == 0) {
      return getHomePage();
    } else if (position == 1) {
      return getArticlePage();
    } else if (position == 2) {
      return MyOrderPage(true);
    } else if (position == 3) {
      return getChatPage();
    } else {
      return getProfilePage();
    }
  }

  getChatPage() {
    double leftMargin = MediaQuery
        .of(context)
        .size
        .width * 0.04;
    double height = ConstantWidget.getScreenPercentSize(context, 15);
    double imageSize = ConstantWidget.getPercentSize(height, 60);

    return Container(
      color: ConstantData.bgColor,
      padding: EdgeInsets.only(
        top: (leftMargin),
        bottom: MediaQuery
            .of(context)
            .size
            .width * 0.01,
      ),
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: leftMargin, bottom: leftMargin),
            child: ConstantWidget.getTextWidget(
                S
                    .of(context)
                    .onlineSpecialist,
                ConstantData.mainTextColor,
                TextAlign.start,
                FontWeight.w800,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
          ),
          Container(
              height: height,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: chatUserList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(left: leftMargin),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: imageSize,
                                    width: imageSize,
                                    padding: EdgeInsets.all(
                                        ConstantWidget.getPercentSize(
                                            imageSize, 3)),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: ConstantData.accentColor,
                                            width:
                                            ConstantWidget.getPercentSize(
                                                imageSize, 3))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          image: ExactAssetImage(
                                              ConstantData.assetsPath +
                                                  chatUserList[index].image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    child: Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              // bottom: (0), right: (0)),
                                                bottom: (leftMargin / 6),
                                                right: (leftMargin / 5)),
                                            child: Container(
                                              height: ConstantWidget
                                                  .getPercentSize(
                                                  imageSize, 22),
                                              width: ConstantWidget
                                                  .getPercentSize(
                                                  imageSize, 22),
                                              padding: EdgeInsets.all(
                                                  ConstantWidget.getPercentSize(
                                                      imageSize, 4)),
                                              decoration: BoxDecoration(
                                                  color: ConstantData.bgColor,
                                                  shape: BoxShape.circle),
                                              child: Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: (chatUserList[index]
                                                        .active ==
                                                        1)
                                                        ? Colors.green
                                                        : Colors.red,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ),
                                        )),
                                    visible: (chatUserList[index].active == 1),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height:
                                  ConstantWidget.getPercentSize(height, 3)),
                              ConstantWidget.getCustomText(
                                  chatUserList[index].name,
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w300,
                                  ConstantWidget.getPercentSize(height, 12)),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailPage(
                                        subCategoryModelList[index])));
                      },
                    );
                  })),
          Padding(
            padding: EdgeInsets.only(left: leftMargin, bottom: leftMargin),
            child: ConstantWidget.getTextWidget(
                S
                    .of(context)
                    .chat,
                ConstantData.mainTextColor,
                TextAlign.start,
                FontWeight.w800,
                ConstantWidget.getScreenPercentSize(context, 2.5)),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: chatUserList.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return chatCell(chatUserList[index], index);
                },
              ))
        ],
      ),
    );
  }

  Widget chatCell(ChatModel chatModel, int index) {
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double height = ConstantWidget.getScreenPercentSize(context, 13);

    double imageSize = ConstantWidget.getPercentSize(height, 60);

    return InkWell(
      child: Container(
        height: height,
        color: ConstantData.cellColor,
        margin: EdgeInsets.symmetric(
            horizontal: (allMargin / 1.6), vertical: (allMargin / 3.5)),
        padding: EdgeInsets.symmetric(
            horizontal: allMargin, vertical: ((allMargin))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: (allMargin * 3)),
                  height: imageSize,
                  width: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: ExactAssetImage(
                          ConstantData.assetsPath + chatModel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Visibility(
                  child: Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: (allMargin * 2), right: (allMargin / 3)),
                          child: Container(
                            height: ConstantWidget.getPercentSize(height, 18),
                            width: ConstantWidget.getPercentSize(height, 18),
                            padding: EdgeInsets.all((allMargin / 2)),
                            decoration: BoxDecoration(
                                color: ConstantData.cellColor,
                                shape: BoxShape.circle),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: (chatModel.active == 1)
                                      ? Colors.green
                                      : Colors.red,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      )),
                  visible: (chatModel.active == 1),
                )
              ],
            ),
            SizedBox(
              width: (allMargin * 3),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ConstantWidget.getCustomText(
                                  chatModel.name,
                                  ConstantData.mainTextColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.bold,
                                  ConstantWidget.getPercentSize(height, 16)),
                              new Spacer(),
                              ConstantWidget.getCustomText(
                                  chatModel.time,
                                  ConstantData.textColor,
                                  1,
                                  TextAlign.start,
                                  FontWeight.w700,
                                  ConstantWidget.getPercentSize(height, 14)),
                            ],
                          ),
                          SizedBox(
                            height: ConstantWidget.getPercentSize(height, 6),
                          ),
                          ConstantWidget.getCustomText(
                              chatModel.desc,
                              ConstantData.textColor,
                              2,
                              TextAlign.start,
                              FontWeight.w400,
                              ConstantWidget.getPercentSize(height, 14)),
                        ],
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(
                    user: chats[0].sender,
                    chatModel: chatModel,
                  ),
            ));
      },
    );
  }

  getOutLineBorder(double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(color: Colors.white, width: 2),
    );
  }


}
