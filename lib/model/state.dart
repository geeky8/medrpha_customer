// To parse this JSON data, do
//
//     final states = statesFromJson(jsonString);

import 'dart:convert';

List<States> statesFromJson(String str) =>
    List<States>.from(json.decode(str).map((x) => States.fromJson(x)));

String statesToJson(List<States> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
