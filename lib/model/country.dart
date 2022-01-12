// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
