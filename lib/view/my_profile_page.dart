import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medical_ui/apicalls/api_service.dart';
import 'package:flutter_medical_ui/controller/city_controller.dart';
import 'package:flutter_medical_ui/controller/country_controller.dart';
import 'package:flutter_medical_ui/controller/customer_controller.dart';
import 'package:flutter_medical_ui/controller/image_controller.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/controller/pin_controller.dart';
import 'package:flutter_medical_ui/controller/product_controller.dart';
import 'package:flutter_medical_ui/controller/state_controller.dart';
import 'package:flutter_medical_ui/model/city.dart';
import 'package:flutter_medical_ui/model/country.dart';
import 'package:flutter_medical_ui/model/customer.dart';
import 'package:flutter_medical_ui/model/pin.dart';
import 'package:flutter_medical_ui/model/state.dart';
import 'package:flutter_medical_ui/myWidget/file_selection_btn.dart';
import 'package:flutter_medical_ui/myWidget/my_snack_bar.dart';
import 'package:flutter_medical_ui/my_uplod_page.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/ConstantWidget.dart';
import 'package:flutter_medical_ui/util/SizeConfig.dart';
import 'package:flutter_medical_ui/view/open_pdf.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  static const blankStringUri = "https://medrpha.com/user_reg/no_image.png";
  static const pictureStringUri = "https://medrpha.com/user_reg/";

  var _countryItemsList = [].obs;
  var _stateItemsList = [].obs;
  var _cityItemList = [].obs;
  var _pinItemList = [].obs;
  var _selectedCountry = 'India'.obs;

  var _selectedCountryId,
      _selectedState,
      _selectedStateId,
      _selectedCity,
      _selectedCityId,
      _selectedPin,
      _selectedPinId;

  var _selectedPage = 0.obs;

  final GlobalKey<FormState> _formKeyGST = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyFSSAI = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDL = GlobalKey<FormState>();
  final double deleteHeight = 35;

  double leftMargin,
      editTextHeight,
      cellHeight,
      topMargin,
      profileHeight,
      defaultMargin;

  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController dlNameController = TextEditingController();
  final TextEditingController dlNoController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController phone1Controller = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phone2Controller = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();

  var _showGST = false.obs;
  var _showFSSAI = false.obs;
  var _showDL = false.obs;
  var _fssaiUploading = false.obs;
  var _fssaiPicName = ''.obs;

  FocusNode firmNameFocus,
      mail,
      phone,
      address,
      name,
      phone1,
      phone2,
      country,
      state_nm,
      city,
      pin,
      dlNameFocus,
      dlNoFocus;

  BuildContext bc;
  ImageController fssaiImage;

  String _sessionID;

  void onCountryChange(e, {firstTime = false}) {
    CountryController cn = Get.find<CountryController>();
    String _countryId = getCountryID(cn.countryOptions, e);
    CustomerController cs = Get.find<CustomerController>();
    _selectedCountryId = _countryId.obs;

    StateController st = Get.find<StateController>();
    var newst = selectedStateNameforCountry(st.stateOptions, _countryId);
    if (newst.length > 0) {
      _stateItemsList.value = newst.obs;
    } else {
      _stateItemsList = ['select State'].obs;
    }
    _selectedState = 'Select State'.obs;
    _selectedStateId = '0'.obs;
    if (cs.customer.value.countryid != _countryId) {
      cs.dataSaved(false);
    }
    if (!firstTime) {
      cs.customer.update((cust) => cust.countryid = _countryId);
    }
  }

  void onStateChange(e, {firstTime = false}) {
    StateController st = Get.find<StateController>();
    CityController ct = Get.find<CityController>();
    CustomerController cs = Get.find<CustomerController>();
    String _stateID = getStateID(st.stateOptions, e);
    _selectedStateId = _stateID.obs;
    var newCityList = selectedCityNameforState(ct.cityOptions, _stateID);
    if (newCityList.length > 0) {
      _cityItemList.value = newCityList.obs;
    } else {
      _cityItemList = ['Select City'].obs;
    }
    _selectedCity = 'Select City'.obs;
    _selectedCityId = '0'.obs;
    if (cs.customer.value.stateid != _stateID) {
      cs.dataSaved(false);
    }
    if (!firstTime) {
      cs.customer.update((cust) => cust.stateid = _stateID);
    }
  }

  void onCityChanged(e, {firstTime = false}) {
    print('Selectimg pin for ${e}');
    CityController ct = Get.find<CityController>();
    PinController pn = Get.find<PinController>();
    CustomerController cs = Get.find<CustomerController>();
    print(
        'The returred city id is : ${getCityID(ct.cityOptions, e).toString()}');
    String _cityID = getCityID(ct.cityOptions, e);
    _selectedCityId = _cityID.obs;
    print('City id for ${e} is ${_cityID}');
    var newPinList = selectedPinNameforCity(pn.pinOptions, _cityID);
    print(
        " The current list of pin ${newPinList.toString()} with length ${newPinList.length}");
    if (newPinList.length > 0) {
      print('Assigning new list to pin');
      _pinItemList.value = newPinList.obs;
    } else {
      _pinItemList.value = ['Select Pin'].obs;
    }
    _selectedPin = 'Select Pin'.obs;
    _selectedPinId = '0'.obs;
    if (cs.customer.value.cityid != _cityID) {
      cs.dataSaved(false);
    }
    if (!firstTime) {
      cs.customer.update((cust) => cust.cityid = _cityID);
    }
  }

  void onPinChanged(e, {firstTime = false}) {
    PinController pn = Get.find<PinController>();
    // print(pn.pinOptions.toString());
    String _pinID = getPinId(pn.pinOptions, e);
    // print('New pin id is : ${_pinID}');
    CustomerController cs = Get.find<CustomerController>();
    _selectedPinId = _pinID.obs;
    if (cs.customer.value.areaid != _pinID) {
      cs.dataSaved(false);
    }
    if (!firstTime) {
      cs.customer.update((cust) => cust.areaid = _pinID);
    }
  }

  updateProfile() async {
    print('Btn clieked');
    if (firmNameController.text.isEmpty) {
      showSnackbarDialog(bc, 'Firm/Company Name can\'t be blank');
      firmNameFocus.requestFocus();
    } else if (_selectedCountryId == '0' || _selectedCountryId == null) {
      showSnackbarDialog(bc, 'Please select Country before proceeding');
    } else if (_selectedStateId == '0' || _selectedStateId == null) {
      showSnackbarDialog(bc, 'Please select State before proceeding');
    } else if (_selectedCityId == '0' || _selectedCityId == null) {
      showSnackbarDialog(bc, 'Please select City before proceeding');
    } else if (_selectedPinId == '0' || _selectedPinId == null) {
      showSnackbarDialog(bc, 'Please select Pin before proceeding');
    } else if (addressController.text.isEmpty) {
      showSnackbarDialog(bc, 'Address can\'t be blank');
      address.requestFocus();
    } else if (nameController.text.isEmpty) {
      showSnackbarDialog(bc, 'Contact Name can\'t be blank');
      name.requestFocus();
    } else if (phone1Controller.text.isEmpty) {
      showSnackbarDialog(bc, 'Phone Number can\'t be blank');
      name.requestFocus();
    } else {
      print('All data correct, sendding server request');
      Customer newCustomer = Customer(
          firmName: firmNameController.text,
          txtemail: mailController.text,
          countryid: _selectedCountryId.value,
          stateid: _selectedStateId.value,
          cityid: _selectedCityId.value,
          phoneno: phoneController.text,
          areaid: _selectedPinId.value,
          address: addressController.text,
          personName: nameController.text,
          personNumber: phone1Controller.text,
          alternateNumber: phone2Controller.text);
      FocusManager.instance.primaryFocus?.unfocus();
      String customerRes = await ApiService.updateCustomer(
          sessionID: _sessionID, customer: newCustomer);
      if (customerRes != null) {
        if (customerRes == "1") {
          showSnackbarDialog(bc, 'Data successfully updated',
              bgColor: Colors.green.shade600);
          CustomerController cs = Get.find<CustomerController>();
          cs.dataSaved(true);
          Get.find<ProductController>().getApprovedStatus();
          Get.find<ProductController>().getProductByCat(0);
        } else {
          showSnackbarDialog(
              bc, 'Issue saving data!! Please close the app and try again');
          name.requestFocus();
        }
      }
    }
  }

  void _onItemTap(int index) {
    print('Index tapped ${index}');
    _selectedPage.value = index;
  }

  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    print('Calling Init state');
    leftMargin = 3;
    editTextHeight = 35;
    cellHeight = 10;
    topMargin = 3;
    profileHeight = 100;
    defaultMargin = 15;
    try {
      CustomerController cs = Get.find<CustomerController>();
    } catch (exception) {
      Get.put<CustomerController>(CustomerController(), permanent: true);
    } finally {
      loadPages();
    }

    print('init done');
  }

  loadPages() {
    pages = [
      // const buildProductPage(),
      Container(child: buildProfilePage()),
      Container(child: gstPage()),
      Container(child: dlPage()),
      Container(child: fssaiPage())
    ];
  }

  ScrollController _controller;
  @override
  Widget build(BuildContext context) {
    print('In build');
    bc = context;
    fssaiImage = ImageController();
    // leftMargin = MediaQuery.of(context).size.width * 0.05;
    // editTextHeight = MediaQuery.of(context).size.height * 0.06;
    // cellHeight = MediaQuery.of(context).size.width * 0.2;
    // topMargin = ConstantWidget.getScreenPercentSize(context, 1);
    // profileHeight = ConstantWidget.getScreenPercentSize(context, 15);
    // defaultMargin = ConstantWidget.getScreenPercentSize(context, 2);

    LocalSessionController ls = Get.find<LocalSessionController>();
    CountryController cn = Get.find<CountryController>();
    StateController st = Get.find<StateController>();
    CityController ct = Get.find<CityController>();
    CustomerController cs = Get.find<CustomerController>();
    print(cs.customer.value.firmName);
    _sessionID = ls.getSessionValue();
    //_showGST(cs.gstUpdated);
    SizeConfig().init(context);

    // Initialise your items only once

    _countryItemsList = countryNameFromCountry(cn.countryOptions).obs;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Back'),
          backgroundColor: Colors.cyan,
        ),
        body: Obx(() => pages[_selectedPage.value]),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: Obx(
            () => BottomNavigationBar(
              backgroundColor: Colors.cyan.shade50,
              type: BottomNavigationBarType.fixed,
              iconSize: 16,
              showSelectedLabels: true,
              onTap: _onItemTap,
              currentIndex: _selectedPage.value,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.manage_accounts),
                  tooltip: 'Profile',
                  label: 'Profile',
                ),
                const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/myimages/gst.png'),
                    size: 16,
                    // color: Colors.blueGrey,
                  ),
                  tooltip: 'GST',
                  label: 'GST',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services), label: 'DL'),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: 'FSSAI',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getProfileImage({int i}) {
    String imgName = "logo_transparent.png";
    print('The image sel ${i}');
    if (i == 2) {
      imgName = "gst.png";
    } else if (i == 4) {
      imgName = "fssai.png";
    } else if (i == 3) {
      imgName = "dl.jpg";
    }
    return Image.asset(
      ConstantData.assetsPath + imgName,
      fit: BoxFit.cover,
    );
  }

  showGSTBtn() {
    CustomerController cs = Get.find<CustomerController>();
    _showGST(true);
    cs.gstSaved(false);
  }

  showFSSAIBtn() {
    CustomerController cs = Get.find<CustomerController>();
    _showFSSAI(true);
    cs.fssaiSaved(false);
  }

  Container gstPage() {
    CustomerController cs = Get.find<CustomerController>();

    _showGST(cs.gstUpdated);
    return Container(
      child: Column(
        children: [
          Obx(
            () => Container(
                color: cs.gstSaved.value
                    ? ConstantData.cellColor
                    : Colors.pink.shade50,
                height: profileHeight + (profileHeight / 5),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: profileHeight,
                          width: profileHeight,
                          decoration: BoxDecoration(
                              color: ConstantData.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ConstantData.primaryColor,
                              )),
                          child: ClipOval(
                            child: Material(
                              color: Colors.cyan.shade50,
                              child: getProfileImage(i: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: defaultMargin),
              color: ConstantData.cellColor,
              // color: ConstantData.cellColor,
              padding: EdgeInsets.all(defaultMargin),
              child: Form(
                key: _formKeyGST,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          ConstantWidget.getCustomTextWithoutAlign(
                              'Your GST Details',
                              ConstantData.mainTextColor,
                              FontWeight.bold,
                              16),
                          SizedBox(width: 10),
                          Obx(
                            () => Visibility(
                              visible: !cs.gstSaved.value,
                              child: Text('Data Not Saved!!',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (defaultMargin / 2),
                    ),
                    Obx(
                      () => Visibility(
                        visible: _showGST.value,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: cs.customer.value.gstno,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your GST Number',
                                    ),
                                    onEditingComplete: () {
                                      CustomerController cs =
                                          Get.find<CustomerController>();
                                      cs.gstSaved(false);
                                      print('gst updated');
                                    },
                                    onSaved: (e) {
                                      print('saved');
                                    },
                                    onChanged: (e) {
                                      CustomerController cs =
                                          Get.find<CustomerController>();
                                      cs.gstSaved(false);
                                      // print('gst changed');
                                    },
                                    validator: (String value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter GST number';
                                      } else {
                                        print('Valid data');
                                        if (cs.customer.value.gstno != value) {
                                          cs.customer.value.gstno = value;
                                          cs.gstSaved.value = false;
                                          // print('gst not saved');

                                        } else {
                                          cs.gstSaved.value = true;
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: deleteHeight + 5,
                                  child: GestureDetector(
                                    onTap: deleteGST,
                                    child: Icon(
                                      Icons.delete_rounded,
                                      size: deleteHeight,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKeyGST.currentState.validate()) {
                                    print('data saved');

                                    String status = await ApiService.updateGST(
                                        sessionID: _sessionID,
                                        gstno: cs.customer.value.gstno);
                                    _showGST(true);
                                    if (status == "1") {
                                      cs.gstSaved.value = true;

                                      showSnackbarDialog(
                                          bc, 'GST successfully updated',
                                          bgColor: Colors.green.shade600);
                                      cs.gstUpdated = true;
                                    } else {
                                      cs.gstSaved.value = true;
                                      showSnackbarDialog(bc,
                                          'Error saving GST!! GST number already present for another customer');
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    const Text('Save GST No.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: !_showGST.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                              style: ConstantData.btnStylePrimary,
                              onPressed: showGSTBtn,
                              child: const Text('Update GST Details'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  deleteGST() async {
    CustomerController cs = Get.find<CustomerController>();
    print('test $_sessionID');
    String status = await ApiService.deleteGST(sessionID: _sessionID);
    if (status == "1") {
      cs.gstUpdated = false;
      cs.gstSaved.value = true;
      // cs.customer.value.gstnoyesno = '1';
      _showGST(false);
    }
  }

  deleteFSSAI() async {
    CustomerController cs = Get.find<CustomerController>();
    String status = await ApiService.deleteFSSAI(sessionID: _sessionID);
    if (status == "1") {
      cs.fssaiUpdated = false;
      cs.fssaiSaved.value = true;
      _showFSSAI(false);
      Get.find<ProductController>().hideProductPrice(true);
    }
  }

  Container dlPage() {
    CustomerController cs = Get.find<CustomerController>();
    dateinput.text = cs.customer.value.valid;
    dlNameController.text = cs.customer.value.txtdlname;
    dlNoController.text = cs.customer.value.txtdlno;
    bool error = false;
    return Container(
      child: Column(
        children: [
          Obx(
            () => Container(
                color: cs.dlSaved.value
                    ? ConstantData.cellColor
                    : Colors.pink.shade50,
                height: profileHeight + (profileHeight / 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: profileHeight,
                          width: profileHeight,
                          decoration: BoxDecoration(
                              color: ConstantData.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ConstantData.primaryColor,
                              )),
                          child: ClipOval(
                            child: Material(
                              color: Colors.cyan.shade50,
                              child: getProfileImage(i: 3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: defaultMargin),
              color: ConstantData.cellColor,
              // color: ConstantData.cellColor,
              padding: EdgeInsets.all(defaultMargin),
              child: Form(
                key: _formKeyDL,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          ConstantWidget.getCustomTextWithoutAlign(
                              'Drug Licence Details',
                              ConstantData.mainTextColor,
                              FontWeight.bold,
                              16),
                          SizedBox(width: 10),
                          Obx(
                            () => Visibility(
                              visible: !cs.dlSaved.value,
                              child: Text('Data Not Saved!!',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (defaultMargin / 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: dlNoController,
                      // initialValue: cs.customer.value.txtdlno,
                      focusNode: dlNoFocus,
                      onEditingComplete: () {
                        Get.find<CustomerController>().dlSaved(false);
                        _formKeyDL.currentState.validate();
                        dlNameFocus.requestFocus();
                      },
                      onSaved: (val) {
                        Get.find<CustomerController>().dlSaved(false);
                        _formKeyDL.currentState.validate();
                      },
                      onChanged: (val) {
                        if (cs.customer.value.txtdlno != val) {
                          cs.dlSaved.value = false;
                        }
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          showSnackbarDialog(
                              bc, 'Drug Licence Number can\'t be blank');
                          return 'Please enter DL Number';
                        } else {
                          dlNoController.text = value;
                          cs.customer.value.txtdlno = value;
                          return null;
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontFamily: ConstantData.fontFamily,
                          color: ConstantData.mainTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                      decoration: InputDecoration(
                        isDense: true,
                        errorMaxLines: 1,

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ConstantData.textColor, width: 0.0),
                        ),
                        labelStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.textColor),
                        labelText: 'Drug Licence Number*',
                        // hintText: 'Full Name',
                      ),
                    ),
                    SizedBox(
                      height: (defaultMargin / 2),
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: dlNameController,
                      //initialValue: cs.customer.value.txtdlname,
                      focusNode: dlNameFocus,
                      onSaved: (e) {
                        Get.find<CustomerController>().dlSaved(false);
                        _formKeyDL.currentState.validate();
                      },
                      onChanged: (val) {
                        if (cs.customer.value.txtdlname != val) {
                          cs.dlSaved.value = false;
                        }
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          showSnackbarDialog(
                              bc, 'Drug Licence Name can\'t be blank');
                          return 'Please enter DL Name';
                        } else {
                          if (cs.customer.value.txtdlname != value) {
                            dlNameController.text = value;
                            cs.customer.value.txtdlname = value;
                          }
                          return null;
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontFamily: ConstantData.fontFamily,
                          color: ConstantData.mainTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: BorderSide(
                              color: ConstantData.textColor, width: 0.0),
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ConstantData.textColor, width: 0.0),
                        ),

                        labelStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.textColor),
                        labelText: 'Drug Licence Name*',
                        // hintText: 'Full Name',
                      ),
                    ),
                    SizedBox(
                      height: (defaultMargin / 2),
                    ),
                    TextFormField(
                      // maxLines: 1,
                      controller: dateinput,
                      //initialValue: cs.customer.value.valid,
                      readOnly: true,
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime
                                .now(), // - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        print('Packed date is : ${pickedDate}');
                        if (pickedDate != null) {
                          // print(
                          //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          setState(() {
                            dateinput.text = formattedDate;
                            cs.customer
                                .update((cust) => cust.valid = formattedDate);
                            cs.dlSaved(false);
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                      onEditingComplete: () {
                        if (dateinput.text.isEmpty) {
                          showSnackbarDialog(
                              bc, 'Drug Licence Validity date can\'t be blank');
                        } else {
                          cs.customer
                              .update((cust) => cust.valid = dateinput.text);
                          cs.dlSaved(false);
                        }
                      },
                      validator: (String value) {
                        if (value == null || value.isEmpty) {
                          showSnackbarDialog(
                              bc, 'Drug Licence Date can\'t be blank');
                          return 'Please enter Licence Expiry Date';
                        } else {
                          if (cs.customer.value.valid != value) {
                            cs.customer.value.valid = value;
                            cs.dlSaved.value = false;
                          }
                          return null;
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontFamily: ConstantData.fontFamily,
                          color: ConstantData.mainTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: BorderSide(
                              color: ConstantData.textColor, width: 0.0),
                        ),

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ConstantData.textColor, width: 0.0),
                        ),

                        labelStyle: TextStyle(
                            fontFamily: ConstantData.fontFamily,
                            color: ConstantData.textColor),
                        labelText: 'Drug Licence Valid Till Date*',
                        // hintText: 'Full Name',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKeyDL.currentState.validate()) {
                            print('data saved');

                            String status = await ApiService.updateDL(
                              sessionID: _sessionID,
                              dlno: cs.customer.value.txtdlno,
                              dlname: cs.customer.value.txtdlname,
                              validTill: cs.customer.value.valid,
                            );
                            _showDL(true);
                            if (status == "1") {
                              cs.dlSaved.value = true;
                              cs.dlUpdated = true;
                              Get.find<ProductController>()
                                  .hideProductPrice(true);
                              showSnackbarDialog(
                                  bc, 'DL details successfully updated',
                                  bgColor: Colors.green.shade600);
                            } else {
                              cs.dlSaved.value = true;
                              showSnackbarDialog(bc,
                                  'Error saving DL details!! DL number already present for another customer');
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            const Text('Save Drug Licence Details'),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 20,
                              color: Colors.blue.shade600,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Update Your DL document',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Text('(Only Picture Allowed)'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            uploadBtn(
                                iconName: Icons.note_add_outlined,
                                iconColor: Colors.orange,
                                fn: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyUploadPage(
                                                upload: 'DL 1',
                                                picType: 'dl',
                                                picNo: 1,
                                              )));
                                },
                                btnText: 'Uoload DL 1'),
                            SizedBox(
                              width: 20,
                            ),
                            uploadBtn(
                                iconName: Icons.note_add_outlined,
                                iconColor: Colors.blue,
                                fn: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyUploadPage(
                                                upload: 'DL 2',
                                                picType: 'dl',
                                                picNo: 2,
                                              )));
                                },
                                btnText: 'Upload DL 2'),
                          ],
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
    );
  }

  Container fssaiPage() {
    _controller = new ScrollController();
    CustomerController cs = Get.find<CustomerController>();
    _showFSSAI(cs.fssaiUpdated);
    _fssaiPicName.value = cs.customer.value.pic3;
    return Container(
      child: Column(
        children: [
          Obx(
            () => Container(
                color: cs.fssaiSaved.value
                    ? ConstantData.cellColor
                    : Colors.pink.shade50,
                height: profileHeight + (profileHeight / 5),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: profileHeight,
                          width: profileHeight,
                          decoration: BoxDecoration(
                              color: ConstantData.primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ConstantData.primaryColor,
                              )),
                          child: ClipOval(
                            child: Material(
                              color: Colors.cyan.shade50,
                              child: getProfileImage(i: 4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: defaultMargin),
              color: ConstantData.cellColor,
              // color: ConstantData.cellColor,
              padding: EdgeInsets.all(defaultMargin),
              child: Form(
                key: _formKeyFSSAI,
                child: ListView(
                  controller: _controller,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          ConstantWidget.getCustomTextWithoutAlign(
                              'Your FSSAI Details',
                              ConstantData.mainTextColor,
                              FontWeight.bold,
                              16),
                          SizedBox(width: 10),
                          Obx(
                            () => Visibility(
                              visible: !cs.fssaiSaved.value,
                              child: Text('Data Not Saved!!',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (defaultMargin / 2),
                    ),
                    Obx(
                      () => Visibility(
                        visible: _showFSSAI.value,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: cs.customer.value.fssaiNo,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your FSSAI Number',
                                    ),
                                    onEditingComplete: () {
                                      CustomerController cs =
                                          Get.find<CustomerController>();
                                      cs.fssaiSaved(false);
                                      print('gst updated');
                                    },
                                    onSaved: (e) {
                                      print('saved');
                                    },
                                    onChanged: (e) {
                                      CustomerController cs =
                                          Get.find<CustomerController>();
                                      cs.fssaiSaved(false);
                                      // print('gst changed');
                                    },
                                    validator: (String value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please fill FSSAI number';
                                      } else {
                                        print('Valid data');
                                        if (cs.customer.value.fssaiNo !=
                                            value) {
                                          cs.customer.value.fssaiNo = value;
                                          cs.fssaiSaved.value = false;
                                          // print('gst not saved');

                                        } else {
                                          cs.fssaiSaved.value = true;
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: deleteHeight + 5,
                                  child: GestureDetector(
                                    onTap: deleteFSSAI,
                                    child: Icon(
                                      Icons.delete_rounded,
                                      size: deleteHeight,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKeyFSSAI.currentState.validate()) {
                                    print('data saved');

                                    String status =
                                        await ApiService.updateFSSAI(
                                            sessionID: _sessionID,
                                            fssaino: cs.customer.value.fssaiNo);
                                    _showFSSAI(true);
                                    if (status == "1") {
                                      cs.fssaiSaved.value = true;
                                      cs.fssaiUpdated = true;
                                      Get.find<ProductController>()
                                          .hideProductPrice(true);
                                      showSnackbarDialog(
                                          bc, 'FSSAI No. successfully updated',
                                          bgColor: Colors.green.shade600);
                                    } else {
                                      cs.gstSaved.value = true;
                                      showSnackbarDialog(bc,
                                          'Error saving FSSAI!! FSAAI number already present for another customer');
                                    }
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.save,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    const Text('Save FSSAI No.'),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //Show uploaded Image

                            Obx(
                              () => _fssaiPicName.value.length > 0
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text('Your uploaded FSSAI document'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          _fssaiPicName.value == 'no_image.png'
                                              ? Image.network(blankStringUri)
                                              : Image.network(pictureStringUri +
                                                  cs.customer.value.phoneno +
                                                  '/' +
                                                  _fssaiPicName.value)
                                        ],
                                      ),
                                    )
                                  : Text('Please Upload your FSSAI document'),
                            ),

                            Obx(
                              () => Visibility(
                                visible:
                                    fssaiImage.selectedImagePath.value != ''
                                        ? true
                                        : false,
                                child: Column(
                                  children: [
                                    SizedBox(height: 25),
                                    Divider(),
                                    SizedBox(height: 10),
                                    Text('Upload this document to server?',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        uploadBtn(
                                            bgColor: Colors.green.shade50,
                                            iconName: Icons.check,
                                            iconColor: Colors.green,
                                            fn: () async {
                                              print('yes');
                                              _fssaiUploading.value = true;
                                              String res =
                                                  await ApiService.uploadImage(
                                                      fssaiImage
                                                          .selectedImagePath
                                                          .value,
                                                      _sessionID);
                                              print(res);
                                              if (res == "OK") {
                                                //image successfully uploaded
                                                showSnackbarDialog(bc,
                                                    'FSSAI document successfully uploaded',
                                                    bgColor:
                                                        Colors.green.shade400);
                                                fssaiImage.selectedImagePath
                                                    .value = '';
                                                await cs.loadCustomerData();
                                                _fssaiPicName.value =
                                                    cs.customer.value.pic3;
                                                Get.find<ProductController>()
                                                    .hideProductPrice(true);
                                              } else {
                                                showSnackbarDialog(bc,
                                                    'Error uploading Image. Try again later');
                                                //image not uploaded
                                              }
                                              _fssaiUploading.value = false;
                                            },
                                            height: 20,
                                            btnText: '  Upload  '),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        uploadBtn(
                                            bgColor: Colors.red.shade50,
                                            iconName: Icons.clear,
                                            iconColor: Colors.red,
                                            fn: () {
                                              print('no');
                                              fssaiImage
                                                  .selectedImagePath.value = '';
                                            },
                                            height: 20,
                                            btnText: '  Discard  '),
                                      ],
                                    ),
                                    Obx(
                                      () => Visibility(
                                        visible: _fssaiUploading.value,
                                        child: Container(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(),
                                                Text('Uploading document.... '),
                                                Text(
                                                    'Please don\'t press the Upload or the Discard button till the picture is being uploaded',
                                                    style: TextStyle(
                                                        fontSize: 10)),
                                              ],
                                            )),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    fssaiImage.selectedImagePath.value != ''
                                        ? Image.file(File(
                                            fssaiImage.selectedImagePath.value))
                                        : Text(' '),
                                  ],
                                ),
                              ),
                            ),

                            Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 20,
                                      color: Colors.blue.shade600,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Update Your FSSAI document',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Text('(Only Picture Allowed)'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    uploadBtn(
                                        iconName: Icons.camera,
                                        iconColor: Colors.orange,
                                        fn: () async {
                                          await showImagePicker(
                                              ImageSource.camera);
                                        },
                                        btnText: 'From Camera'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    uploadBtn(
                                        iconName: Icons.insert_photo,
                                        iconColor: Colors.blue,
                                        fn: () async {
                                          await showImagePicker(
                                              ImageSource.gallery);
                                          print('returned from function ');
                                        },
                                        btnText: 'From Gallery'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: !_showFSSAI.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            ElevatedButton(
                              style: ConstantData.btnStylePrimary,
                              onPressed: showFSSAIBtn,
                              child: const Text('Update FSSAI Details'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showImagePicker(ImageSource imageSource) async {
    print('This is from Image picker');

    await fssaiImage.getImage(imageSource);
    double height = MediaQuery.of(context).size.height;
    _controller.animateTo(
        height +
            48, // 100 is the height of container and index of 6th element is 5
        duration: const Duration(seconds: 3),
        curve: Curves.easeOut);
  }

  Container buildProfilePage() {
    firmNameFocus = FocusNode();
    mail = FocusNode();
    phone = FocusNode();
    address = FocusNode();
    name = FocusNode();
    phone1 = FocusNode();
    phone2 = FocusNode();
    country = FocusNode();
    state_nm = FocusNode();
    city = FocusNode();
    pin = FocusNode();
    dlNameFocus = FocusNode();
    dlNoFocus = FocusNode();
    double editSize = ConstantWidget.getPercentSize(profileHeight, 24);
    LocalSessionController ls = Get.find<LocalSessionController>();
    phoneController.text = ls.getPhoneNumber();
    String _session = ls.getSessionValue();

    CustomerController cs = Get.find<CustomerController>();

    String firmName = cs.customer.value.firmName;
    String email = cs.customer.value.txtemail;
    String _country_id = cs.customer.value.countryid;
    String _state_id = cs.customer.value.stateid;
    String _city_id = cs.customer.value.cityid;
    String _pin_id = cs.customer.value.areaid;
    String _address = cs.customer.value.address;
    String _contact_name = cs.customer.value.personName;
    String _contact_no = cs.customer.value.personNumber;
    String _contact_no2 = cs.customer.value.alternateNumber;
    CountryController cn = Get.find<CountryController>();
    StateController st = Get.find<StateController>();
    CityController ct = Get.find<CityController>();
    PinController pn = Get.find<PinController>();
    // if (_country_id == null || _country_id == '') {
    if (_country_id.length == 0) {
      _selectedCountry.value = 'Select Country';
      _selectedCountryId = '0';
      _selectedStateId = '0';
      _selectedState = 'Select State';
      _selectedCityId = '0';
      _selectedCity = 'Select City';
      _selectedPinId = '0';
      _selectedPin = 'Select Pin';
    } else {
      _selectedCountry.value =
          getCountryName(cn.countryOptions, _country_id.toString());
    }
    print('The value of countryid is ${_country_id.toString()}');
    print('The lencgh of country Id is : ${_country_id.length}');
    if (_country_id != null && _country_id.length > 0) {
      print('_country _id is not null');
      _selectedCountryId = _country_id.obs;
      onCountryChange(_selectedCountry.value, firstTime: true);
      _selectedState = getStateName(st.stateOptions, _state_id.toString()).obs;
      _selectedStateId = _state_id.obs;
      if (_state_id != null) {
        // print(
        //     'now populate city list for selected state ${_selectedState.value}');
        onStateChange(_selectedState.value, firstTime: true);
        // print(" The current list of city ${_cityItemList.value.toString()}");
        _selectedCityId = _city_id.obs;
        _selectedCity = getCityName(ct.cityOptions, _city_id).obs;
        if (_city_id != null) {
          _selectedPin = getPin(pn.pinOptions, _pin_id).obs;
          onCityChanged(_selectedCity.value, firstTime: true);
          _selectedPinId = _pin_id.obs;
          _selectedPin = getPin(pn.pinOptions, _pin_id).obs;
          onPinChanged(_selectedPin.value, firstTime: true);
        }
      } else {
        print('state id is null');
      }
    } else {
      print('country id is blank');
      onCountryChange('Select Country', firstTime: true);
      onStateChange('Select State', firstTime: true);
      onCityChanged('Select City', firstTime: true);
      // onPinChanged('Select Pin', firstTime: true);
      // _selectedCountryId.value = 0;
    }

    firmNameController.text = firmName;
    mailController.text = email;
    addressController.text = _address;
    nameController.text = _contact_name;
    phone1Controller.text = _contact_no;
    phone2Controller.text = _contact_no2;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Obx(
                  () => Container(
                      color: cs.dataSaved.value
                          ? ConstantData.cellColor
                          : Colors.pink.shade50,
                      height: profileHeight + (profileHeight / 5),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: profileHeight,
                                width: profileHeight,
                                decoration: BoxDecoration(
                                    color: ConstantData.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ConstantData.primaryColor,
                                      // width: ConstantWidget.getScreenPercentSize(
                                      //     context, 0.2),
                                    )),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.cyan.shade50,
                                    child: getProfileImage(),
                                  ),
                                ),
                              ),
                            ),
                            // This will show up at the bottom of the big circle
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: InkWell(
                            //     child: Container(
                            //       margin: EdgeInsets.only(
                            //           left:
                            //               ConstantWidget.getScreenPercentSize(
                            //                   context, 10),
                            //           bottom:
                            //               ConstantWidget.getScreenPercentSize(
                            //                   context, 2.7)),
                            //       height: editSize,
                            //       width: editSize,
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           color: ConstantData.primaryColor,
                            //         ),
                            //         child: Center(
                            //           child: Icon(
                            //             Icons.photo_camera_back,
                            //             color: Colors.white,
                            //             size: ConstantWidget.getPercentSize(
                            //                 editSize, 48),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //
                            //     // onTap: _imgFromGallery,
                            //   ),
                            // )
                          ],
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  color: ConstantData.cellColor,
                  // color: ConstantData.cellColor,
                  padding: EdgeInsets.all(defaultMargin),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            ConstantWidget.getCustomTextWithoutAlign(
                                'Firm Details',
                                ConstantData.mainTextColor,
                                FontWeight.bold,
                                16),
                            SizedBox(width: 10),
                            Obx(
                              () => Visibility(
                                visible: !cs.dataSaved.value,
                                child: Text('Data Not Saved!!',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),

                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: (defaultMargin / 2)),
                        height: editTextHeight,
                        child: TextField(
                          maxLines: 1,
                          controller: firmNameController,
                          focusNode: firmNameFocus,
                          onEditingComplete: () {
                            if (firmNameController.text.isEmpty) {
                              showSnackbarDialog(
                                  bc, 'Firm/Company Name can\'t be blank');
                            } else {
                              cs.customer.update((cust) =>
                                  cust.firmName = firmNameController.text);
                              cs.dataSaved(false);
                              mail.requestFocus();
                            }
                          },
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            labelStyle: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.textColor),
                            labelText: 'Name (Firm/Customer)*',
                            // hintText: 'Full Name',
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: (defaultMargin / 2)),
                        height: editTextHeight,
                        child: TextField(
                          maxLines: 1,
                          controller: mailController,
                          focusNode: mail,
                          onEditingComplete: () {
                            bool changed = false;
                            if (mailController.text.isEmpty) {
                              changed = true;
                              country.requestFocus();
                            } else {
                              if (EmailValidator.validate(
                                  mailController.text)) {
                                changed = true;
                                country.requestFocus();
                              } else {
                                showSnackbarDialog(
                                    bc, 'Invalid Email ID, can\'t proceed');
                              }
                              if (changed) {
                                cs.customer.update((cust) =>
                                    cust.txtemail = mailController.text);
                                cs.dataSaved(false);
                              }
                            }
                          },
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
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
                        margin:
                            EdgeInsets.symmetric(vertical: (defaultMargin / 2)),
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
                              fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            labelStyle: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.textColor),
                            labelText: 'Phone',
                            // hintText: 'Full Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),
                      //Country dropdown
                      Obx(
                        () => SizedBox(
                          height: 42,
                          child: DropdownSearch<String>(
                            focusNode: country,
                            mode: Mode.BOTTOM_SHEET,
                            items: _countryItemsList.value,
                            label: "Country*",
                            hint: "Select Country",
                            onChanged: onCountryChange,
                            selectedItem: _selectedCountry.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin),
                      ),
                      //State Dropdown
                      Obx(
                        () => SizedBox(
                          height: 42,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: _stateItemsList.value,
                            label: "State*",
                            hint: "Select State",
                            onChanged: onStateChange,
                            selectedItem: _selectedState.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 42,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: _cityItemList.value,
                            label: "City*",
                            hint: "Select City",
                            onChanged: onCityChanged,
                            selectedItem: _selectedCity.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin),
                      ),
                      Obx(
                        () => SizedBox(
                          height: 42,
                          child: DropdownSearch<String>(
                            mode: Mode.BOTTOM_SHEET,
                            items: _pinItemList.value,
                            label: "Pin*",
                            hint: "Select Pin",
                            selectedItem: _selectedPin.value,
                            onChanged: onPinChanged,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: (defaultMargin / 2)),
                            height: editTextHeight,
                            child: TextField(
                              maxLines: 1,
                              focusNode: address,
                              onEditingComplete: () {
                                if (addressController.text.isEmpty) {
                                  showSnackbarDialog(
                                      bc, 'Address can\'t be blank');
                                } else {
                                  cs.customer.update((cust) =>
                                      cust.address = addressController.text);
                                  cs.dataSaved(false);
                                  name.requestFocus();
                                }
                              },
                              controller: addressController,
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.mainTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
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
                                labelText: 'Shipping Address*',
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: defaultMargin),
                  color: ConstantData.cellColor,
                  padding: EdgeInsets.all(defaultMargin),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: ConstantWidget.getCustomTextWithoutAlign(
                            'Contact Details',
                            ConstantData.mainTextColor,
                            FontWeight.bold,
                            16),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: (defaultMargin / 2)),
                            height: editTextHeight,
                            child: TextField(
                              onEditingComplete: () {
                                if (nameController.text.isEmpty) {
                                  showSnackbarDialog(bc,
                                      'Contact person\'s name can\'t be blank');
                                } else {
                                  cs.customer.update((cust) =>
                                      cust.personName = nameController.text);
                                  cs.dataSaved(false);
                                  phone1.requestFocus();
                                }
                              },
                              maxLines: 1,
                              controller: nameController,
                              focusNode: name,
                              autofocus: false,
                              style: TextStyle(
                                  fontFamily: ConstantData.fontFamily,
                                  color: ConstantData.mainTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
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
                                labelText: 'Contact Name*',
                                // hintText: 'Full Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: (defaultMargin / 2)),
                        height: 55,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          maxLines: 1,
                          focusNode: phone1,
                          onEditingComplete: () {
                            if (phone1Controller.text.isEmpty) {
                              showSnackbarDialog(
                                  bc, 'Phone number can\'t be blank');
                            } else {
                              cs.customer.update((cust) =>
                                  cust.personNumber = phone1Controller.text);
                              cs.dataSaved(false);
                              phone2.requestFocus();
                            }
                          },
                          controller: phone1Controller,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            labelStyle: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.textColor),
                            labelText: 'Primary Contact Number*',
                            // hintText: 'Full Name',
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: (defaultMargin / 2)),
                        height: 55,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          maxLines: 1,
                          focusNode: phone2,
                          onEditingComplete: () {
                            cs.customer.update((cust) =>
                                cust.alternateNumber = phone2Controller.text);
                            cs.dataSaved(false);
                          },
                          controller: phone2Controller,
                          style: TextStyle(
                              fontFamily: ConstantData.fontFamily,
                              color: ConstantData.mainTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantData.textColor, width: 0.0),
                            ),

                            labelStyle: TextStyle(
                                fontFamily: ConstantData.fontFamily,
                                color: ConstantData.textColor),
                            labelText: 'Alternate Number',
                            // hintText: 'Full Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (defaultMargin / 2),
                      ),
                      //Country dropdown
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                        child: Column(
                      children: [
                        // ConstantWidget.getButtonWidget(context, 'Save',
                        //     ConstantData.primaryColor, login),
                        ElevatedButton(
                          style: ConstantData.btnStylePrimary,
                          onPressed: updateProfile,
                          child: const Text('Update Profile'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Note: All Fields marked with * are mandatory',
                            style: TextStyle(
                              fontSize: 12,
                            )),
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: defaultMargin,
                )
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
