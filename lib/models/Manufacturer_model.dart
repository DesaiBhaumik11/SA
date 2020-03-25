
import 'dart:convert';

import 'package:flutter/services.dart';

class ManufacturerFarmer {

  String imageUrl;
  String name;
  String address;
  String phoneNumber;
  String email;

  ManufacturerFarmer({this.imageUrl, this.name, this.address, this.phoneNumber, this.email});

  factory ManufacturerFarmer.fromJson(Map<String, dynamic> json) => ManufacturerFarmer(
    imageUrl: json["ImageUrl"],
    name: json["Name"],
    address: json["Address"],
    phoneNumber: json["PhoneNumber"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson () => {
    "ImageUrl" : imageUrl,
    "Name" : name,
    "Address" : address,
    "PhoneNumber" : phoneNumber,
    "Email" : email,
  };

  Future<String> loadManufacturerDa() async {
    String jsonString = await rootBundle.loadString('assets/OkJsons/manufacturer.json');
    final jsonResponse = json.decode(jsonString);
    print(jsonResponse);
    return jsonResponse;
  }
}