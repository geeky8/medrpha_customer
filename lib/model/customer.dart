// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.firmName,
    this.gstno,
    this.phoneno,
    this.txtemail,
    this.txtdlno,
    this.dl1,
    this.dl2,
    this.valid,
    this.countryid,
    this.stateid,
    this.cityid,
    this.areaid,
    this.address,
    this.txtdlname,
    this.fssaiNo,
    this.pic3,
    this.personName,
    this.personNumber,
    this.alternateNumber,
    this.hdnDrugsyesno,
    this.hdnFssai,
  });

  String firmName;
  String gstno;
  String phoneno;
  String txtemail;
  String txtdlno;
  String dl1;
  String dl2;
  String valid;
  String countryid;
  String stateid;
  String cityid;
  String areaid;
  dynamic address;
  String txtdlname;
  String fssaiNo;
  String pic3;
  String personName;
  String personNumber;
  String alternateNumber;
  String hdnDrugsyesno;
  String hdnFssai;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firmName: json["firm_name"],
        gstno: json["gstno"],
        phoneno: json["phoneno"],
        txtemail: json["txtemail"],
        txtdlno: json["txtdlno"],
        dl1: json["dl1"],
        dl2: json["dl2"],
        valid: json["valid"],
        countryid: json["countryid"],
        stateid: json["stateid"],
        cityid: json["cityid"],
        areaid: json["Areaid"],
        address: json["address"],
        txtdlname: json["txtdlname"],
        fssaiNo: json["fssaiNo"],
        pic3: json["pic3"],
        personName: json["PersonName"],
        personNumber: json["PersonNumber"],
        alternateNumber: json["AlternateNumber"],
        hdnDrugsyesno: json["hdnDrugsyesno"],
        hdnFssai: json["hdnFSSAI"],
      );

  Map<String, dynamic> toJson() => {
        "firm_name": firmName,
        "gstno": gstno,
        "phoneno": phoneno,
        "txtemail": txtemail,
        "txtdlno": txtdlno,
        "dl1": dl1,
        "dl2": dl2,
        "valid": valid,
        "countryid": countryid,
        "stateid": stateid,
        "cityid": cityid,
        "Areaid": areaid,
        "address": address,
        "txtdlname": txtdlname,
        "fssaiNo": fssaiNo,
        "pic3": pic3,
        "PersonName": personName,
        "PersonNumber": personNumber,
        "AlternateNumber": alternateNumber,
        "hdnDrugsyesno": hdnDrugsyesno,
        "hdnFSSAI": hdnFssai,
      };
}
