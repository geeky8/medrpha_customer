import 'package:flutter_medical_ui/model/local_session.dart';
import 'package:flutter_medical_ui/util/PrefData.dart';
import 'package:get/get.dart';

class LocalSessionController extends GetxController {
  LocalSession mySession;
  int test = 11;

  @override
  void onInit() {
    super.onInit();
    getSessionData();
    print('Init called from Local session controller');
  }

  Future<void> getSessionData() async {
    print('Creating the Local session object');
    mySession = await PrefData.getAllLocalData();
  }

  String getSessionValue() {
    return mySession.session;
  }
}
