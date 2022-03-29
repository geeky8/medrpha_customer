class LocalSession {
  String session, mobileNo, pin;
  var regCompleted, adminApproved;

  LocalSession(this.session, this.mobileNo, this.regCompleted,
      this.adminApproved, this.pin);
  clearData() {
    session = '';
    mobileNo = '';
    pin = '';
    try {
      regCompleted.value = false;
      adminApproved.value = false;
    } catch (e) {
      regCompleted = false;
      adminApproved = false;
    }
  }
}
