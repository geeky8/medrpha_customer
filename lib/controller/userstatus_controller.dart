import 'package:get/get.dart';

class UserStatusController extends GetxService {
  // List<Pin> pinOptions = [];
  // var loaded = false.obs;
  var userStatus;
  @override
  void onInit() async {
    super.onInit();
    // await loadPin();
  }

  UserStatusController(bool userType) {
    this.userStatus = userType.obs;
  }

  bool getUserStatus() {
    return this.userStatus.value;
  }
}
