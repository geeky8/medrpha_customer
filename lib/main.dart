import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_medical_ui/controller/local_session_controller.dart';
import 'package:flutter_medical_ui/util/ConstantData.dart';
import 'package:flutter_medical_ui/util/DataFile.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:flutter_medical_ui/view/my_getx_home_page.dart';
import 'package:get/get.dart';

import 'IntroPage.dart';
import 'MySignUpPage.dart';
import 'TabWidget.dart';
import 'generated/l10n.dart';
import 'model/SubCategoryModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      debugShowCheckedModeBanner: false,
      title: 'Medrpha',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: ConstantData.primaryColor,
        primaryColorDark: ConstantData.primaryColor,
        accentColor: ConstantData.accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  get subCategoryModelList => null;
  LocalSessionController sessionController =
      Get.put(LocalSessionController(), permanent: true);

  @override
  void initState() {
    super.initState();
    // signInValue();
    getLocalData();
    setState(() {});
  }

  bool _isSignIn = false;
  bool _isIntro = false;
  String _session_id;

  void getLocalData() async {
    //print('Printing session data ${sessionController.mySession.session}');
    int del = Get.find<LocalSessionController>().test;
    print('The value of test from local session : ${del}');
    // print(
    //     'The value of mobile number n session ${Get.find<LocalSessionController>().mySession.mobileNo} , ${Get.find<LocalSessionController>().mySession.session}');
    _session_id = await PrefData.getSessionID();
    int themMode = await PrefData.getThemeMode();
    ConstantData.setThemePosition();
    SystemChrome.setSystemUIOverlayStyle((themMode == 0)
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);
    _isIntro = false;
    if (_isIntro) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ));
    } else {
      // _isSignIn = true;
      if (_session_id == '' || _session_id == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MySignUpPage(),
            ));
      } else {
        Timer(Duration(milliseconds: 1700), () {
          List<SubCategoryModel> subCategoryModelList1 =
              DataFile.getSubCategoryModel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                // builder: (context) => MyHome(),
                // builder: (context) => MyPinVerification(),
                //product Detaied page

                // builder: (context) => TestProduct(),
                //new homepage new Style
                builder: (context) => MyNewHomePage(),
              ));
        });
      }
    }
  }

  void signInValue() async {
    print('Prionting session id');
    print(await PrefData.getSessionID());
    print('Done');
    _isSignIn = await PrefData.getIsSignIn();
    _isSignIn = false;
    _isIntro = await PrefData.getIsIntro();
    int themMode = await PrefData.getThemeMode();
    ConstantData.setThemePosition();
    print("isSignIn--" + _isSignIn.toString());
    SystemChrome.setSystemUIOverlayStyle((themMode == 0)
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);
    _isIntro = false;
    if (_isIntro) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ));
    } else {
      // _isSignIn = true;
      print('The value of Sigin is : $_isSignIn');
      if (!_isSignIn) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MySignUpPage(),
            ));
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabWidget(),
              ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: ConstantData.bgColor,
                image: DecorationImage(
                    image: AssetImage(ConstantData.assetsPath + "splash.jpg"),
                    fit: BoxFit.cover)),
          ),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    // });
    //
    // return new Future.value(false);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you really Want to Exit'),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.pop(
                    context,
                    true,
                  ),
              icon: Icon(Icons.check)),
          IconButton(
            onPressed: () => Navigator.pop(
              context,
              true,
            ),
            icon: Icon(Icons.clear),
          ),
        ],
      ),
    );
  }
}
