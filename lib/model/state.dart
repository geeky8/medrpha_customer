// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

List<States> statesFromJson(String str) =>
    List<States>.from(json.decode(str).map((x) => States.fromJson(x)));

List<String> stateNamefromState(List<States> data) =>
    data.map((e) => e.stateName).toList();

String statesToJson(List<States> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String getStateID(List<States> states, String stateName) => states
    .firstWhere((stateObj) => stateObj.stateName == stateName)
    .stateid
    .toString();

String getStateName(List<States> states, String stateId) => states
    .firstWhere((stateObj) => stateObj.stateid.toString() == stateId)
    .stateName;

List<String> selectedStateNameforCountry(
        List<States> states, String countryId) =>
    states
        .where((stateObj) => stateObj.countid.toString() == countryId)
        .toList()
        .map((e) => e.stateName)
        .toList();

class States {
  States({
    this.countid,
    this.stateid,
    this.stateName,
  });

  int countid;
  int stateid;
  String stateName;

  factory States.fromJson(Map<String, dynamic> json) => States(
        countid: json["countid"],
        stateid: json["stateid"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "countid": countid,
        "stateid": stateid,
        "state_name": stateName,
      };
}
