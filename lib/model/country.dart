// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

import 'package:collection/collection.dart';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

List<String> countryNameFromCountry(List<Country> data) =>
    data.map((x) => x.countryName).toList();

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String getCountryID(List<Country> data, String countryName) => data
    .where((element) => element.countryName == countryName)
    .firstOrNull
    .countryid
    .toString();
String getCountryName(List<Country> countries, String countryId) => countries
    .where((country) => country.countryid.toString() == countryId)
    .firstOrNull
    .countryName
    .toString();

class Country {
  Country({
    this.countryid,
    this.countryName,
  });

  int countryid;
  String countryName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        countryid: json["countryid"],
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "countryid": countryid,
        "country_name": countryName,
      };
}
