// To parse this JSON data, do
//
//     final pin = pinFromJson(jsonString);

import 'dart:convert';

List<Pin> pinFromJson(String str) =>
    List<Pin>.from(json.decode(str).map((x) => Pin.fromJson(x)));

List<String> areaNameFromPin(List<Pin> data) =>
    data.map((e) => e.areaName).toList();

String getPin(List<Pin> pins, String pinId) =>
    pins.firstWhere((pin) => pin.areaid.toString() == pinId).areaName;

String getPinId(List<Pin> pins, String pinStr) =>
    pins.firstWhere((pin) => pin.areaName == pinStr).areaid.toString();

List<String> selectedPinNameforCity(List<Pin> pins, String cityId) => pins
    .where((pin) => pin.cityid.toString() == cityId)
    .toList()
    .map((e) => e.areaName)
    .toList();

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
