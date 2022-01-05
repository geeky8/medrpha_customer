import './../util/PrefData.dart';

class CommonFunctions {
  Future<String> isSessionActive() async {
    String SessionId = await PrefData.getSessionID();
    if (SessionId == '' || SessionId == null) {
      return 'no';
    } else {
      return SessionId;
    }
  }

  Future<int> showPrice() async {
    bool registrationComplete = await PrefData.getRegCompleted();
    if (!registrationComplete) {
      return 1;
    } else {
      bool adminApproved = await PrefData.getAdminApproved();
      if (!adminApproved) {
        return 2;
      } else {
        return 3;
      }
    }
  }
}
