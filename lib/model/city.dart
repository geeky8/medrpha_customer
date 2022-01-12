// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    this.statid,
    this.cityid,
    this.cityName,
  });

  int statid;
  int cityid;
  String cityName;

  factory City.fromJson(Map<String, dynamic> json) => City(
        statid: json["statid"],
        cityid: json["cityid"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "statid": statid,
        "cityid": cityid,
        "city_name": cityName,
      };
}
