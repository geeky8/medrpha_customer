// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

List<String> cityNameFromCity(List<City> data) =>
    data.map((e) => e.cityName).toList();

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<String> selectedCityNameforState(List<City> data, String stateId) {
  return data.map((e) {
    if (e.statid.toString() == stateId) {
      return e.cityName;
    }
  }).toList();
}

String getCityName(List<City> cities, String cityId) =>
    cities.firstWhere((city) => city.cityid.toString() == cityId).cityName;

String getCityID(List<City> cities, String cityName) =>
    cities.firstWhere((city) => city.cityName == cityName).cityid.toString();

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
