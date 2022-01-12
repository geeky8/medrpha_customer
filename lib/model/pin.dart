// To parse this JSON data, do
//
//     final pin = pinFromJson(jsonString);

import 'dart:convert';

List<Pin> pinFromJson(String str) =>
    List<Pin>.from(json.decode(str).map((x) => Pin.fromJson(x)));

String pinToJson(List<Pin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pin {
  Pin({
    this.cityid,
    this.areaid,
    this.areaName,
  });

  int cityid;
  int areaid;
  String areaName;

  factory Pin.fromJson(Map<String, dynamic> json) => Pin(
        cityid: json["cityid"],
        areaid: json["areaid"],
        areaName: json["area_name"],
      );

  Map<String, dynamic> toJson() => {
        "cityid": cityid,
        "areaid": areaid,
        "area_name": areaName,
      };
}
