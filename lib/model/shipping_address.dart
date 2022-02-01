// To parse this JSON data, do
//
//     final shippingAddress = shippingAddressFromJson(jsonString);

import 'dart:convert';

ShippingAddress shippingAddressFromJson(String str) =>
    ShippingAddress.fromJson(json.decode(str));

String shippingAddressToJson(ShippingAddress data) =>
    json.encode(data.toJson());

class ShippingAddress {
  ShippingAddress({
    this.phoneno,
    this.firmName,
    this.gstno,
    this.valid,
    this.dl1,
    this.dl2,
    this.address,
    this.txtemail,
    this.txtdlno,
    this.countryname,
    this.statename,
    this.cityname,
    this.areaname,
  });

  String phoneno;
  String firmName;
  String gstno;
  String valid;
  String dl1;
  String dl2;
  String address;
  String txtemail;
  String txtdlno;
  String countryname;
  String statename;
  String cityname;
  String areaname;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        phoneno: json["phoneno"],
        firmName: json["firm_name"],
        gstno: json["gstno"],
        valid: json["valid"],
        dl1: json["dl1"],
        dl2: json["dl2"],
        address: json["address"],
        txtemail: json["txtemail"],
        txtdlno: json["txtdlno"],
        countryname: json["countryname"],
        statename: json["statename"],
        cityname: json["cityname"],
        areaname: json["areaname"],
      );

  Map<String, dynamic> toJson() => {
        "phoneno": phoneno,
        "firm_name": firmName,
        "gstno": gstno,
        "valid": valid,
        "dl1": dl1,
        "dl2": dl2,
        "address": address,
        "txtemail": txtemail,
        "txtdlno": txtdlno,
        "countryname": countryname,
        "statename": statename,
        "cityname": cityname,
        "areaname": areaname,
      };
}
