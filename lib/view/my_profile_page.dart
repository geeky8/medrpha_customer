import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/city_controller.dart';
import 'package:flutter_medical_ui/controller/country_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/pin_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/controller/state_controller.dart';
import 'package:flutter_medical_ui/model/country.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  FocusNode _focus = FocusNode();

  List<DropdownMenuItem<Country>> _countryItems;

  Country _selectedCountry = Country(countryid: 0, countryName: 'Select One');

  List<Country> countries;

  String _sessionID;

  Future<List<Country>> fillCountries(_sessionID) async {
    List<Country> temp_countries =
        await ApiService.getAllCountry(sessionID: _sessionID);
    _countryItems = temp_countries.map<DropdownMenuItem<Country>>(
      (Country country) {
        return DropdownMenuItem<Country>(
          value: country,
          child: Text(country.countryName),
        );
      },
    ).toList();
    _countryItems.insert(
        0,
        DropdownMenuItem<Country>(
          value: Country(countryid: 0, countryName: 'Select One'),
          child: Text('Select One'),
        ));
    return temp_countries;
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    LocalSessionController ls = Get.find<LocalSessionController>();
    CountryController cn = Get.find<CountryController>();
    CityController ct = Get.find<CityController>();
    StateController st = Get.find<StateController>();
    PinController pn = Get.find<PinController>();
    _sessionID = ls.getSessionValue();
    ProductController pc = Get.find<ProductController>();
    SizeConfig().init(context);
    double leftMargin = MediaQuery.of(context).size.width * 0.05;
    double editTextHeight = MediaQuery.of(context).size.height * 0.06;
    double cellHeight = MediaQuery.of(context).size.width * 0.2;
    double topMargin = ConstantWidget.getScreenPercentSize(context, 1);

    double profileHeight = ConstantWidget.getScreenPercentSize(context, 15);
    double defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);
    double editSize = ConstantWidget.getPercentSize(profileHeight, 24);
    TextEditingController firstNameController = new TextEditingController();
    TextEditingController mailController = new TextEditingController();
    TextEditingController genderController = new TextEditingController();
    TextEditingController phoneController = new TextEditingController();
    print('The count of counytries : ${cn.countryOptions.length}');
    print('The count of state : ${st.stateOptions.length}');
    print('The count of City : ${ct.cityOptions.length}');
    print('The count of pin : ${pn.pinOptions.length}');
    // Initialise your items only once

    // _selectedCountry = countries[0];

    String selectedCountry = 'Select One';

    _focus.addListener(_onFocusChange);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Back'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        height: profileHeight + (profileHeight / 5),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: profileHeight,
                                  width: profileHeight,
                                  decoration: BoxDecoration(
                                      color: ConstantData.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: ConstantData.primaryColor,
                                          width: ConstantWidget
                                              .getScreenPercentSize(
                                                  context, 0.2))),
                                  child: ClipOval(
                                    child: Material(
                                      color: ConstantData.primaryColor,
                                      child: getProfileImage(),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            ConstantWidget.getScreenPercentSize(
                                                context, 10),
                                        bottom:
                                            ConstantWidget.getScreenPercentSize(
                                                context, 2.7)),
                                    height: editSize,
                                    width: editSize,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ConstantData.primaryColor,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.photo_camera_back,
                                          color: Colors.white,
                                          size: ConstantWidget.getPercentSize(
                                              editSize, 48),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // onTap: _imgFromGallery,
                                ),
                              )
                            ],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: defaultMargin),
                      color: ConstantData.cellColor,
                      padding: EdgeInsets.all(defaultMargin),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: ConstantWidget.getCustomTextWithoutAlign(
                                'User Information',
                                ConstantData.mainTextColor,
                                FontWeight.bold,
                                ConstantData.font22Px),
                          ),
                          SizedBox(
                            height: (defaultMargin / 2),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: (defaultMargin / 2)),
                                      padding: EdgeInsets.only(
                                          right: (defaultMargin / 1.5)),
                                      height: editTextHeight,
                                      child: TextField(
                                        focusNode: _focus,
                                        maxLines: 1,
                                        controller: firstNameController,
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.mainTextColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: ConstantData.font18Px),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          labelStyle: TextStyle(
                                              fontFamily:
                                                  ConstantData.fontFamily,
                                              color: ConstantData.textColor),
                                          labelText: 'Name (Firm/Customer)',
                                          // hintText: 'Full Name',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: (defaultMargin / 2)),
                            height: editTextHeight,
                            child: TextField(
                              maxLines: 1,
                              controller: mailController,
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.mainTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: ConstantData.font18Px),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: BorderSide(
                                      color: ConstantData.textColor,
                                      width: 0.0),
                                ),

                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ConstantData.textColor,
                                      width: 0.0),
                                ),

                                labelStyle: TextStyle(
                                    fontFamily: ConstantData.fontFamily,
                                    color: ConstantData.textColor),
                                labelText: 'Email ID',
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Country '),
                                Expanded(
                                  child: FutureBuilder(
                                      future: fillCountries(_sessionID),
                                      builder: (context, snapshot) {
                                        return DropdownButton<Country>(
                                          onChanged: (v) {
                                            print(
                                                'v selected : ${v.countryName}');
                                            // _selectedCountry = v;
                                          },
                                          items: _countryItems,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: (defaultMargin / 2)),
                                      padding: EdgeInsets.only(
                                          right: (defaultMargin / 1.5)),
                                      height: editTextHeight,
                                      child: TextField(
                                        maxLines: 1,
                                        controller: genderController,
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.mainTextColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: ConstantData.font18Px),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          labelStyle: TextStyle(
                                              fontFamily:
                                                  ConstantData.fontFamily,
                                              color: ConstantData.textColor),
                                          labelText: 'Gender',
                                          // hintText: 'Full Name',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: (defaultMargin / 2)),
                                      padding: EdgeInsets.only(
                                          left: (defaultMargin / 1.5)),
                                      height: editTextHeight,
                                      child: TextField(
                                        enabled: false,
                                        keyboardType: TextInputType.number,
                                        maxLines: 1,
                                        controller: phoneController,
                                        style: TextStyle(
                                            fontFamily: ConstantData.fontFamily,
                                            color: ConstantData.mainTextColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: ConstantData.font18Px),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ConstantData.textColor,
                                                width: 0.0),
                                          ),

                                          labelStyle: TextStyle(
                                              fontFamily:
                                                  ConstantData.fontFamily,
                                              color: ConstantData.textColor),
                                          labelText: 'Phone',
                                          // hintText: 'Full Name',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text('Country'),
                                SizedBox(
                                  width: 10,
                                ),
                                FutureBuilder(
                                    future: fillCountries(_sessionID),
                                    builder: (context,
                                        AsyncSnapshot<List<Country>> snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.length == 0) {
                                          return CircularProgressIndicator();
                                        } else {
                                          return Expanded(
                                            child: DropdownButtonFormField<
                                                Country>(
                                              icon: const Icon(
                                                  Icons.arrow_downward),
                                              isExpanded: true,
                                              onChanged: (v) {
                                                print(
                                                    'v selected : ${v.countryName}');
                                                // _selectedCountry = v;
                                              },
                                              items: _countryItems,
                                            ),
                                          );
                                        }
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: (defaultMargin)),
                      padding: EdgeInsets.only(
                          left: leftMargin, right: leftMargin, top: leftMargin),
                      color: ConstantData.cellColor,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                ConstantWidget.getTextWidget(
                                    'Address',
                                    ConstantData.mainTextColor,
                                    TextAlign.start,
                                    FontWeight.w800,
                                    ConstantWidget.getScreenPercentSize(
                                        context, 2.5)),
                                new Spacer(),
                                InkWell(
                                  child: ConstantWidget.getUnderlineText(
                                      'New Address',
                                      Colors.orange,
                                      1,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      ConstantWidget.getScreenPercentSize(
                                          context, 2)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                                ConstantWidget.getScreenPercentSize(context, 3),
                          ),
                          Container(
                            color: ConstantData.mainTextColor,
                            height: ConstantWidget.getScreenPercentSize(
                                context, 0.02),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: defaultMargin,
                    )
                  ],
                ),
                flex: 1,
              ),
              // InkWell(
              //   child: Container(
              //       margin: EdgeInsets.only(top: 10, bottom: leftMargin),
              //       height: 50,
              //       decoration: BoxDecoration(
              //           color: ConstantData.primaryColor,
              //           borderRadius: BorderRadius.all(Radius.circular(8))),
              //       child: InkWell(
              //         child: Center(
              //           child: ConstantWidget.getCustomTextWithoutAlign(
              //               S.of(context).save,
              //               Colors.white,
              //               FontWeight.w900,
              //               ConstantData.font15Px),
              //
              //           // child: Text(
              //           //   S.of(context).save,
              //           //   style: TextStyle(
              //           //       fontFamily: ConstantData.fontFamily,
              //           //       fontWeight: FontWeight.w900,
              //           //       fontSize: ConstantData.font15Px,
              //           //       color: Colors.white,
              //           //       decoration: TextDecoration.none),
              //           // ),
              //         ),
              //       )),
              //   onTap: () {
              //     Navigator.of(context).pop(true);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  getProfileImage() {
    //
    return Image.asset(
      ConstantData.assetsPath + "logo_transparent.png",
      fit: BoxFit.cover,
    );
  }
}
