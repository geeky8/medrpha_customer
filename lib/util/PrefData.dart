import 'package:flutter_medical_ui/model/local_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String defaultString = "workout_";
  static String signIn = defaultString + "signIn";
  static String isIntro = defaultString + "isIntro";
  static String isFirstTime = defaultString + "isFirstTime";
  static String mode = defaultString + "mode";
  static String medDefault = 'medrpha_';
  static String sessionID = medDefault + "sessionId";
  static String mobileNo = medDefault + "mobileNo";
  static String regCompleted = medDefault + "regCompleted";
  static String adminApproved = medDefault + "adminApproved";
  static String pin = medDefault + "pin";

  static Future<LocalSession> getAllLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString(sessionID);
    String mobile = prefs.getString(mobileNo) ?? '';
    String newpin = prefs.getString(pin) ?? '';
    bool regC = prefs.getBool(regCompleted) ?? false;
    bool adminapp = prefs.getBool(adminApproved) ?? false;

    LocalSession ls =
        await LocalSession(session, mobile, regC, adminapp, newpin);
    print('Local data received');
    return ls;
  }

  static getSessionID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionID);
  }

  static setSessionID(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(sessionID, val);
  }

  static getMobileNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mobileNo) ?? '';
  }

  static setMobileNo(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(mobileNo, val);
  }

  static getPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(pin) ?? '';
  }

  static setPin(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(pin, val);
  }

  static setRegCompleted(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(regCompleted, isFav);
  }

  static getRegCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(regCompleted) ?? false;
  }

  static setAdminApproved(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(adminApproved, isFav);
  }

  static getAdminApproved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(adminApproved) ?? false;
  }

  static setIsSignIn(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(signIn, isFav);
  }

  static getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(signIn) ?? false;
  }

  static setIsIntro(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isIntro, isFav);
  }

  static getIsIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isIntro) ?? true;
  }

  static setIsFirstTime(bool isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstTime, isFav);
  }

  static getIsFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isFirstTime) ?? true;
  }

  static setThemeMode(int isFav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(mode, isFav);
  }

  static getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(mode) ?? 0;
  }
}
